package MOC_oper

import spinal.core._
import spinal.lib._

import scala.language.postfixOps

object BoxDType extends SpinalEnum {
  val WORD, UWORD, SHORT, USHORT, CHAR, UCHAR = newElement()
}

object BoxFltStatus extends SpinalEnum {
  val IDLE, LineRead, PSUMRead, PSUMWrite, CalFltVal = newElement()
}

class BoxFilter(ADDRWD: Int = 32, DATAWD: Int = 32) extends Component {
  val io = new Bundle {
    val mem_master = master(mem_if(32, 32))
    val rg_input_addr = in UInt (ADDRWD bits)
    val rg_output_addr = in UInt (ADDRWD bits)
    val rg_psum_addr = in UInt (ADDRWD bits)
    val rg_dtype = in(BoxDType())
    val rg_width = in UInt (12 bits)
    val rg_height = in UInt (12 bits)
    val rg_rx = in UInt (4 bits)
    val rg_ry = in UInt (4 bits)
    val start = in Bool()
    val done = out Bool()
  }
  noIoPrefix()
  val real_start = RegNext(io.start) init (False) // 用于延时1周期，避免在FSM中使用start信号
  val nWinSizeX = (io.rg_rx << 1) + 1
  val nWinSizeY = (io.rg_ry << 1) + 1
  val nWinArea = (nWinSizeX * nWinSizeY).asSInt
  val nWinArea_result_reg = RegNextWhen(nWinArea, io.start) init (0) // 用于延时1周期，避免在FSM中使用nWinArea
  val nHalfWinArea = nWinArea_result_reg |>> 1
  val nTypeSizeShift = UInt(2 bits) // 将数据类型转换为字节数的2次幂，可以使用位移操作替代地址倍乘
  val nWordShift = 2
  val nDoubleShift = 3

  // 滤波后输出图像的宽高
  val nOutW = io.rg_width - (io.rg_rx << 1)
  val nOutY = io.rg_height - (io.rg_ry << 1)

  val fsm = Reg(BoxFltStatus()) init (BoxFltStatus.IDLE)
  val fsm_next = BoxFltStatus()

  val fsmPSUMRead = fsm === BoxFltStatus.PSUMRead
  val fsmLineRead = fsm === BoxFltStatus.LineRead
  val fsmPSUMWrite = fsm === BoxFltStatus.PSUMWrite
  val fsmCalFltVal = fsm === BoxFltStatus.CalFltVal

  val Height_cnt = Reg(UInt(12 bits)) init (0) // 原始图像高度计数器
  val Height_cnt_incr = Bool()
  val Height_cnt_done = Bool()

  val Width_cnt = Reg(UInt(12 bits)) init (0) // 原始图像宽度计数器
  val Width_cnt_incr = Bool()
  val Width_cnt_done = Bool()

  val nWinSizeY_cnt = Reg(UInt(nWinSizeY.getWidth bits)) init (0) // 滤波窗口Y方向计数器
  val nWinSizeY_cnt_done = Bool()
  val nWinSizeY_cnt_incr = Bool()
  // 用于计算PSUM的地址，实现shift逻辑，除了第一个窗口，后续只需取首尾地址
  val nWinY_bias = UInt(nWinSizeY.getWidth bits)

  val nWinSizeX_cnt = Reg(UInt(nWinSizeX.getWidth bits)) init (0) // 滤波窗口X方向计数器
  val nWinSizeX_cnt_done = Bool()
  val nWinSizeX_cnt_incr = Bool()
  // 用于计算PSUM的地址，实现shift逻辑，除了第一个窗口，后续只需取首尾地址
  val nWinX_bias = UInt(nWinSizeX.getWidth bits)

  // 用于读取行
  val Init_LineRead = Bool() // 此行的Psum不需要读取初始值
  val LineReadDone = Bool()
  val LineReadAddrBase = UInt(ADDRWD bits)
  val LineReadAddrBase_bias = Reg(UInt(ADDRWD bits)) init (0)
  val LineReadAddr = UInt(ADDRWD bits)
  val LineReadBuf_pre = SInt(33 bits) // 用于处理数据类型
  val LineReadBuf_vld = Delay(fsmLineRead, 1) init (False)
  val LineReadBuf = Reg(SInt(33 bits)) init (0) // 保存读取数据，用于后续与PSUM计算
  // 用于读取行用于累加行
  val Init_PSUM = Bool() // 第一个窗口的PSUM不需要进行滑窗
  val PSUM_Addr = UInt(ADDRWD bits)
  val PSUM_Part = Reg(Bits(1 bits)) init (0) // 64bits数据需要分成2个32bits进行读写
  val PSUM_ReadData = SInt(64 bits)
  val PSUM_ReadDataPartLow = Reg(Bits(32 bits)) init (0) // 用于存储第32bits数据

  val PSUM_decr = Bool()
  val PSUM_WriteData = SInt(64 bits)
  val PSUM_WriteDataPart = Vec(Bits(32 bits), 2)
  val PSUM_WriteData_HighPart_Buf = Reg(Bits(32 bits)) init (0)
  // 计算每个滤波点均值
  // 1. 得到每个窗口的和filter_sum
  // 2. output = (filter_sum + nHalfWinArea)/nWinArea
  val Init_WinCal = Bool() // 第一个窗口的PSUM不需要进行滑窗
  val Ready2CalFltVal = Bool()
  val CalFltVal_working = Reg(Bool()) init (False)
  val PSUMReadData_vld = Delay(fsmPSUMRead & PSUM_Part.asBool, 1) init (False)
  val FilterSUM_decr = Bool()
  val FilterSUM_incr = Bool()
  val FilterSUM_vld = Delay(FilterSUM_incr, 1) init (False)
  val FilterSUM = Reg(SInt(64 bits)) init (0)
  val FilterSUM_done = Bool()

  // 为了修复timing,这一部的计算需要拆分
  val CalFltSum_vld = Reg(Bool()) init (False)
  val CalFltSumValue = Reg(SInt(64 bits)) init (0)

  val CalFltVal_vld = Reg(Bool()) init (False)
  val CalFltValue = Reg(SInt(64 bits)) init (0)

  //  val CalFltVal_vld_reg = Reg(Bool()) init (False)
  //  val CalFltValue_reg = Reg(SInt(64 bits)) init (0)

  val CalFltWin_done = Bool()

  val Flt_all_done = Bool()

  // 需要对计算结果进行clip并转换成输出数据类型
  val minValue = SInt(64 bits)
  val maxValue = SInt(64 bits)
  val ClipValue = SInt(64 bits)
  // 如果数据类型不为word，则需要根据地址对有效数据进行偏移
  val ClipValueByteShift = Bits(32 bits)
  val ClipDataWriteMask = Bits(4 bits)
  val ClipDataWriteAddr = UInt(ADDRWD bits)
  val ClipDataY_bias = Reg(UInt(ADDRWD bits)) init (0)


  io.done := Flt_all_done

  Height_cnt_incr := CalFltWin_done
  Height_cnt_done := Height_cnt === (nOutY - 1)
  when(Height_cnt_incr) {
    when(Height_cnt_done) {
      Height_cnt := 0
    } otherwise {
      Height_cnt := Height_cnt + 1
    }
  }

  Width_cnt_done := (Width_cnt === (io.rg_width - 1) & fsmPSUMWrite) | (Width_cnt === nOutW - 1 & fsmCalFltVal)
  Width_cnt_incr := (fsmPSUMWrite & PSUM_Part.asBool) | (fsmCalFltVal & CalFltVal_vld)

  when(Width_cnt_incr) {
    when(Width_cnt_done) {
      Width_cnt := 0
    } otherwise {
      Width_cnt := Width_cnt + 1
    }
  }

  nWinSizeY_cnt_done :=
    (nWinSizeY_cnt === (nWinSizeY - 1) & Init_PSUM) |
      (nWinSizeY_cnt === 1 & !Init_PSUM)
  nWinSizeY_cnt_incr := LineReadDone
  when(nWinSizeY_cnt_incr) {
    when(nWinSizeY_cnt_done) {
      nWinSizeY_cnt := 0
    } otherwise {
      nWinSizeY_cnt := nWinSizeY_cnt + 1
    }
  }
  when(Init_PSUM) {
    nWinY_bias := nWinSizeY_cnt
  } otherwise {
    when(nWinSizeY_cnt === 0) {
      nWinY_bias := 1
    } otherwise {
      nWinY_bias := (nWinSizeY - 1)
    }
  }

  nWinSizeX_cnt_incr := CalFltVal_working & PSUM_Part.asBool
  nWinSizeX_cnt_done := (nWinSizeX_cnt === (nWinSizeX - 1) & Init_WinCal) | ((nWinSizeX_cnt === 1) & !Init_WinCal)
  when(nWinSizeX_cnt_incr) {
    when(nWinSizeX_cnt_done) {
      nWinSizeX_cnt := 0
    } otherwise {
      nWinSizeX_cnt := nWinSizeX_cnt + 1
    }
  }
  when(CalFltVal_working) {
    when(Init_WinCal) {
      nWinX_bias := nWinSizeX_cnt
    } otherwise {
      when(nWinSizeX_cnt === 0) {
        nWinX_bias := 1
      } otherwise {
        nWinX_bias := (nWinSizeX - 1)
      }
    }
  } otherwise {
    nWinX_bias := 0
  }

  /**
   * line read logic
   */
  Init_LineRead := nWinSizeY_cnt === 0 & Height_cnt === 0
  LineReadDone := Width_cnt_done & Width_cnt_incr & !CalFltVal_working

  when(Ready2CalFltVal) {
    LineReadAddrBase_bias := LineReadAddrBase_bias + (io.rg_width |<< nTypeSizeShift)
  }
  when(nWinSizeY_cnt === 0 & !Init_PSUM) {
    LineReadAddrBase := io.rg_input_addr + LineReadAddrBase_bias - (io.rg_width |<< nTypeSizeShift) * nWinY_bias
  } otherwise {
    LineReadAddrBase := io.rg_input_addr + LineReadAddrBase_bias + (io.rg_width |<< nTypeSizeShift) * nWinY_bias
  }

  LineReadAddr := LineReadAddrBase + (Width_cnt |<< nTypeSizeShift)

  when(LineReadBuf_vld) {
    LineReadBuf := LineReadBuf_pre
  }

  /**
   * psum logic
   */
  Init_PSUM := Height_cnt === 0
  when(nWinSizeX_cnt === 0 & !Init_WinCal) {
    PSUM_Addr := io.rg_psum_addr + (PSUM_Part.asUInt << nWordShift) + (Width_cnt << nDoubleShift) - (nWinX_bias << nDoubleShift)
  } otherwise {
    PSUM_Addr := io.rg_psum_addr + (PSUM_Part.asUInt << nWordShift) + (Width_cnt << nDoubleShift) + (nWinX_bias << nDoubleShift)
  }
  when(fsmPSUMWrite | fsmPSUMRead) {
    PSUM_Part := ~PSUM_Part
  }

  when(fsmPSUMRead & PSUM_Part.asBool) {
    PSUM_ReadDataPartLow := io.mem_master.rdata
  }
  PSUM_ReadData := (io.mem_master.rdata ## PSUM_ReadDataPartLow).asSInt

  PSUM_decr := !Init_PSUM & nWinSizeY_cnt === 0
  PSUM_WriteData := 0
  when(Init_LineRead) {
    PSUM_WriteData := LineReadBuf_pre.resized
  } otherwise {
    when(PSUM_decr) {
      PSUM_WriteData := PSUM_ReadData - LineReadBuf
    } otherwise {
      PSUM_WriteData := PSUM_ReadData + LineReadBuf
    }
  }

  PSUM_WriteData_HighPart_Buf := PSUM_WriteDataPart(1)
  for (i <- 0 until 2) {
    PSUM_WriteDataPart(i) := PSUM_WriteData((i + 1) * 32 - 1 downto i * 32).asBits
  }

  /**
   * 计算滤波值
   */
  FilterSUM_decr := (CalFltVal_working & PSUMReadData_vld) & !Init_WinCal & nWinSizeX_cnt === 1
  FilterSUM_incr := CalFltVal_working & PSUMReadData_vld & !FilterSUM_decr
  FilterSUM_done := nWinSizeX_cnt_done & nWinSizeX_cnt_incr
  Init_WinCal := CalFltVal_working & Width_cnt === 0
  Ready2CalFltVal := nWinSizeY_cnt_done & LineReadDone & fsmPSUMWrite

  when(CalFltWin_done) {
    CalFltVal_working := False
  } elsewhen (Ready2CalFltVal) {
    CalFltVal_working := True
  }

  when(Ready2CalFltVal) {
    FilterSUM := 0
  } elsewhen (FilterSUM_decr) {
    FilterSUM := FilterSUM - PSUM_ReadData
  } elsewhen (FilterSUM_incr) {
    FilterSUM := FilterSUM + PSUM_ReadData
  }

  // 为了修复timing,这一部的计算需要拆分
  CalFltSum_vld := FilterSUM_vld & fsmCalFltVal
  when(FilterSUM_vld & fsmCalFltVal) {
    CalFltSumValue := FilterSUM + nHalfWinArea
  }

  CalFltVal_vld := CalFltSum_vld
  when(CalFltSum_vld) {
    CalFltValue := CalFltSumValue / nWinArea_result_reg
  }

  CalFltWin_done := Width_cnt_done & Width_cnt_incr & fsmCalFltVal

  Flt_all_done := CalFltWin_done & Height_cnt_done

  /**
   * clip logic
   */
  switch(io.rg_dtype) {
    is(BoxDType.WORD) {
      minValue := S(-2147483648, 64 bits)
      maxValue := S(2147483647, 64 bits)
    }
    is(BoxDType.UWORD) {
      minValue := S(0, 64 bits)
      maxValue := S(4294967295L, 64 bits)
    }
    is(BoxDType.SHORT) {
      minValue := S(-32768, 64 bits)
      maxValue := S(32767, 64 bits)
    }
    is(BoxDType.USHORT) {
      minValue := S(0, 64 bits)
      maxValue := S(65535, 64 bits)
    }
    is(BoxDType.CHAR) {
      minValue := S(-128, 64 bits)
      maxValue := S(127, 64 bits)
    }
    is(BoxDType.UCHAR) {
      minValue := S(0, 64 bits)
      maxValue := S(255, 64 bits)
    }
  }
  when(CalFltValue > maxValue) {
    ClipValue := maxValue
  } elsewhen (CalFltValue < minValue) {
    ClipValue := minValue
  } otherwise {
    ClipValue := CalFltValue
  }

  when(real_start) {
    ClipDataY_bias := 0
  } elsewhen (Height_cnt_incr) {
    ClipDataY_bias := ClipDataY_bias + nOutW
  }
  ClipDataWriteAddr := io.rg_output_addr + (ClipDataY_bias |<< nTypeSizeShift) + (Width_cnt |<< nTypeSizeShift)

  fsm := fsm_next
  fsm_next := fsm
  switch(fsm) {
    is(BoxFltStatus.IDLE) {
      when(real_start) {
        fsm_next := BoxFltStatus.LineRead
      }
    }
    is(BoxFltStatus.LineRead) {
      when(Init_LineRead) {
        fsm_next := BoxFltStatus.PSUMWrite
      } otherwise {
        fsm_next := BoxFltStatus.PSUMRead
      }
    }
    is(BoxFltStatus.PSUMRead) {
      when(PSUM_Part.asBool) {
        when(CalFltVal_working) {
          when(FilterSUM_done) {
            fsm_next := BoxFltStatus.CalFltVal
          } otherwise {
            fsm_next := BoxFltStatus.PSUMRead
          }
        } otherwise {
          fsm_next := BoxFltStatus.PSUMWrite
        }
      }
    }
    is(BoxFltStatus.PSUMWrite) {
      when(PSUM_Part.asBool) {
        when(Ready2CalFltVal) {
          fsm_next := BoxFltStatus.PSUMRead
        } otherwise {
          fsm_next := BoxFltStatus.LineRead
        }
      }
    }
    is(BoxFltStatus.CalFltVal) {
      when(CalFltVal_vld) {
        when(CalFltWin_done) {
          when(Flt_all_done) {
            fsm_next := BoxFltStatus.IDLE
          } otherwise {
            fsm_next := BoxFltStatus.LineRead
          }
        } otherwise {
          fsm_next := BoxFltStatus.PSUMRead
        }
      }
    }
  }

  /**
   * data widen logic
   */
  switch(io.rg_dtype) {
    is(BoxDType.CHAR) {
      switch(LineReadAddr(1 downto 0)) {
        is(0) {
          LineReadBuf_pre := io.mem_master.rdata(7 downto 0).asSInt.resize(33 bits)
        }
        is(1) {
          LineReadBuf_pre := io.mem_master.rdata(15 downto 8).asSInt.resize(33 bits)
        }
        is(2) {
          LineReadBuf_pre := io.mem_master.rdata(23 downto 16).asSInt.resize(33 bits)
        }
        is(3) {
          LineReadBuf_pre := io.mem_master.rdata(31 downto 24).asSInt.resize(33 bits)
        }
      }
    }
    is(BoxDType.UCHAR) {
      switch(LineReadAddr(1 downto 0)) {
        is(0) {
          LineReadBuf_pre := io.mem_master.rdata(7 downto 0).asUInt.resize(33 bits).asSInt
        }
        is(1) {
          LineReadBuf_pre := io.mem_master.rdata(15 downto 8).asUInt.resize(33 bits).asSInt
        }
        is(2) {
          LineReadBuf_pre := io.mem_master.rdata(23 downto 16).asUInt.resize(33 bits).asSInt
        }
        is(3) {
          LineReadBuf_pre := io.mem_master.rdata(31 downto 24).asUInt.resize(33 bits).asSInt
        }
      }
    }
    is(BoxDType.SHORT) {
      switch(LineReadAddr(1 downto 0)) {
        is(0) {
          LineReadBuf_pre := io.mem_master.rdata(15 downto 0).asSInt.resize(33 bits)
        }
        is(2) {
          LineReadBuf_pre := io.mem_master.rdata(31 downto 16).asSInt.resize(33 bits)
        }
        default {
          LineReadBuf_pre := 0
        }
      }
    }
    is(BoxDType.USHORT) {
      switch(LineReadAddr(1 downto 0)) {
        is(0) {
          LineReadBuf_pre := io.mem_master.rdata(15 downto 0).asUInt.resize(33 bits).asSInt
        }
        is(2) {
          LineReadBuf_pre := io.mem_master.rdata(31 downto 16).asUInt.resize(33 bits).asSInt
        }
        default {
          LineReadBuf_pre := 0
        }
      }
    }
    is(BoxDType.WORD) {
      LineReadBuf_pre := io.mem_master.rdata(31 downto 0).asSInt.resize(33 bits)
    }
    is(BoxDType.UWORD) {
      LineReadBuf_pre := io.mem_master.rdata(31 downto 0).asUInt.resize(33 bits).asSInt
    }
  }
  switch(nTypeSizeShift) {
    is(0) { // byte
      switch(ClipDataWriteAddr(1 downto 0)) {
        is(0) {
          ClipValueByteShift := ClipValue(7 downto 0).asBits.resized
          ClipDataWriteMask := B"0001"
        }
        is(1) {
          ClipValueByteShift := (ClipValue(7 downto 0) << 8).asBits.resized
          ClipDataWriteMask := B"0010"
        }
        is(2) {
          ClipValueByteShift := (ClipValue(7 downto 0) << 16).asBits.resized
          ClipDataWriteMask := B"0100"
        }
        is(3) {
          ClipValueByteShift := (ClipValue(7 downto 0) << 24).asBits.resized
          ClipDataWriteMask := B"1000"
        }
      }
    }
    is(1) { // half
      switch(ClipDataWriteAddr(1 downto 0)) {
        is(0) {
          ClipValueByteShift := ClipValue(15 downto 0).asBits.resized
          ClipDataWriteMask := B"0011"
        }
        is(2) {
          ClipValueByteShift := (ClipValue(15 downto 0) << 16).asBits.resized
          ClipDataWriteMask := B"1100"
        }
        default {
          ClipValueByteShift := 0
          ClipDataWriteMask := 0
        }
      }
    }
    is(2) { // word
      ClipValueByteShift := ClipValue(31 downto 0).asBits.resized
      ClipDataWriteMask := B"1111"
    }
    default {
      ClipValueByteShift := 0
      ClipDataWriteMask := 0
    }
  }
  switch(io.rg_dtype) {
    is(BoxDType.WORD) {
      nTypeSizeShift := 2
    }
    is(BoxDType.UWORD) {
      nTypeSizeShift := 2
    }
    is(BoxDType.SHORT) {
      nTypeSizeShift := 1
    }
    is(BoxDType.USHORT) {
      nTypeSizeShift := 1
    }
    is(BoxDType.CHAR) {
      nTypeSizeShift := 0
    }
    is(BoxDType.UCHAR) {
      nTypeSizeShift := 0
    }
  }

  io.mem_master.rd := False
  io.mem_master.wr := False
  io.mem_master.addr := 0
  io.mem_master.wmask := 0
  io.mem_master.wdata := 0
  when(fsmLineRead) {
    io.mem_master.rd := True
    io.mem_master.wr := False
    io.mem_master.addr := LineReadAddr |>> 2
    io.mem_master.wmask := 0
    io.mem_master.wdata := 0
  } elsewhen (fsmPSUMRead) {
    io.mem_master.rd := True
    io.mem_master.wr := False
    io.mem_master.addr := PSUM_Addr |>> 2
    io.mem_master.wmask := 0
    io.mem_master.wdata := 0
  } elsewhen (fsmPSUMWrite) {
    io.mem_master.rd := False
    io.mem_master.wr := True
    io.mem_master.addr := PSUM_Addr |>> 2
    io.mem_master.wmask := B"1111"
    when(PSUM_Part.asBool) {
      io.mem_master.wdata := PSUM_WriteData_HighPart_Buf
    } otherwise {
      io.mem_master.wdata := PSUM_WriteDataPart(0)
    }
  } elsewhen (CalFltVal_vld) {
    io.mem_master.rd := False
    io.mem_master.wr := True
    io.mem_master.addr := ClipDataWriteAddr |>> 2
    io.mem_master.wmask := ClipDataWriteMask
    io.mem_master.wdata := ClipValueByteShift
  }
}

object BoxFilter_inst {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = ASYNC,
        clockEdge = RISING,
        resetActiveLevel = LOW),
      mode = Verilog,
      oneFilePerComponent = true,
      nameWhenByFile = false,
      inlineConditionalExpression = true,
      enumPrefixEnable = false,
      anonymSignalPrefix = "tmp",
      targetDirectory = "/home/zhangyiyao/coco_work/cocoTest/Trash_IP/BoxFilter/rtl")
      //      .addStandardMemBlackboxing(blackboxAll)
      .generate(new BoxFilter())
  }.printPruned()
}