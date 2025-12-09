// Generator : SpinalHDL v1.8.0    git head : 4e3563a282582b41f4eaafc503787757251d23ea
// Component : apb2mem_top
// Git hash  : 64a8a01180c8b78a22afff4458f6a364a04ce1c3

`timescale 1ns/1ps

module apb2mem_top (
  input               debug_rx_en,
  input               debug_nn_en,
  input      [31:0]   apb_slv_pcm_PADDR,
  input      [0:0]    apb_slv_pcm_PSEL,
  input               apb_slv_pcm_PENABLE,
  output              apb_slv_pcm_PREADY,
  input               apb_slv_pcm_PWRITE,
  input      [31:0]   apb_slv_pcm_PWDATA,
  output     [31:0]   apb_slv_pcm_PRDATA,
  output              apb_slv_pcm_PSLVERROR,
  input      [31:0]   apb_slv_fb_PADDR,
  input      [0:0]    apb_slv_fb_PSEL,
  input               apb_slv_fb_PENABLE,
  output              apb_slv_fb_PREADY,
  input               apb_slv_fb_PWRITE,
  input      [31:0]   apb_slv_fb_PWDATA,
  output     [31:0]   apb_slv_fb_PRDATA,
  output              apb_slv_fb_PSLVERROR,
  input      [31:0]   apb_slv_a_PADDR,
  input      [0:0]    apb_slv_a_PSEL,
  input               apb_slv_a_PENABLE,
  output              apb_slv_a_PREADY,
  input               apb_slv_a_PWRITE,
  input      [31:0]   apb_slv_a_PWDATA,
  output     [31:0]   apb_slv_a_PRDATA,
  output              apb_slv_a_PSLVERROR,
  input      [31:0]   apb_slv_w_PADDR,
  input      [0:0]    apb_slv_w_PSEL,
  input               apb_slv_w_PENABLE,
  output              apb_slv_w_PREADY,
  input               apb_slv_w_PWRITE,
  input      [31:0]   apb_slv_w_PWDATA,
  output     [31:0]   apb_slv_w_PRDATA,
  output              apb_slv_w_PSLVERROR,
  output              fb_mem_ena,
  output              fb_mem_wena,
  output     [3:0]    fb_mem_wsel,
  output     [6:0]    fb_mem_addr,
  output     [127:0]  fb_mem_wdata,
  input      [127:0]  fb_mem_rdata,
  output              a_mem_ena,
  output              a_mem_wena,
  output     [3:0]    a_mem_wsel,
  output     [6:0]    a_mem_addr,
  output     [127:0]  a_mem_wdata,
  input      [127:0]  a_mem_rdata,
  output              w_mem_ena,
  output              w_mem_wena,
  output     [3:0]    w_mem_wsel,
  output     [9:0]    w_mem_addr,
  output     [127:0]  w_mem_wdata,
  input      [127:0]  w_mem_rdata,
  output reg          pcm_mb0_ena,
  output reg          pcm_mb0_wena,
  output reg [0:0]    pcm_mb0_wsel,
  output reg [7:0]    pcm_mb0_addr,
  output reg [15:0]   pcm_mb0_wdata,
  input      [15:0]   pcm_mb0_rdata,
  output reg          pcm_mb1_ena,
  output reg          pcm_mb1_wena,
  output reg [0:0]    pcm_mb1_wsel,
  output reg [7:0]    pcm_mb1_addr,
  output reg [15:0]   pcm_mb1_wdata,
  input      [15:0]   pcm_mb1_rdata,
  input               pingpong_flag
);

  reg        [15:0]   pcm_trans_pcm_mb_rdata;
  wire                cache_trans_apb_slv_PREADY;
  wire       [31:0]   cache_trans_apb_slv_PRDATA;
  wire                cache_trans_apb_slv_PSLVERROR;
  wire                cache_trans_mem_ena;
  wire                cache_trans_mem_wena;
  wire       [3:0]    cache_trans_mem_wsel;
  wire       [6:0]    cache_trans_mem_addr;
  wire       [127:0]  cache_trans_mem_wdata;
  wire                coef_trans_apb_slv_PREADY;
  wire       [31:0]   coef_trans_apb_slv_PRDATA;
  wire                coef_trans_apb_slv_PSLVERROR;
  wire                coef_trans_mem_ena;
  wire                coef_trans_mem_wena;
  wire       [3:0]    coef_trans_mem_wsel;
  wire       [9:0]    coef_trans_mem_addr;
  wire       [127:0]  coef_trans_mem_wdata;
  wire                fbank_trans_apb_slv_PREADY;
  wire       [31:0]   fbank_trans_apb_slv_PRDATA;
  wire                fbank_trans_apb_slv_PSLVERROR;
  wire                fbank_trans_mem_ena;
  wire                fbank_trans_mem_wena;
  wire       [3:0]    fbank_trans_mem_wsel;
  wire       [6:0]    fbank_trans_mem_addr;
  wire       [127:0]  fbank_trans_mem_wdata;
  wire                pcm_trans_apb_slv_PREADY;
  wire       [31:0]   pcm_trans_apb_slv_PRDATA;
  wire                pcm_trans_apb_slv_PSLVERROR;
  wire                pcm_trans_pcm_mb_ena;
  wire                pcm_trans_pcm_mb_wena;
  wire       [0:0]    pcm_trans_pcm_mb_wsel;
  wire       [7:0]    pcm_trans_pcm_mb_addr;
  wire       [15:0]   pcm_trans_pcm_mb_wdata;

  apb2mem_trans_2 cache_trans (
    .en                (debug_nn_en                     ), //i
    .apb_slv_PADDR     (apb_slv_a_PADDR[31:0]           ), //i
    .apb_slv_PSEL      (apb_slv_a_PSEL                  ), //i
    .apb_slv_PENABLE   (apb_slv_a_PENABLE               ), //i
    .apb_slv_PREADY    (cache_trans_apb_slv_PREADY      ), //o
    .apb_slv_PWRITE    (apb_slv_a_PWRITE                ), //i
    .apb_slv_PWDATA    (apb_slv_a_PWDATA[31:0]          ), //i
    .apb_slv_PRDATA    (cache_trans_apb_slv_PRDATA[31:0]), //o
    .apb_slv_PSLVERROR (cache_trans_apb_slv_PSLVERROR   ), //o
    .mem_ena           (cache_trans_mem_ena             ), //o
    .mem_wena          (cache_trans_mem_wena            ), //o
    .mem_wsel          (cache_trans_mem_wsel[3:0]       ), //o
    .mem_addr          (cache_trans_mem_addr[6:0]       ), //o
    .mem_wdata         (cache_trans_mem_wdata[127:0]    ), //o
    .mem_rdata         (a_mem_rdata[127:0]              )  //i
  );
  apb2mem_trans_1 coef_trans (
    .en                (debug_nn_en                    ), //i
    .apb_slv_PADDR     (apb_slv_w_PADDR[31:0]          ), //i
    .apb_slv_PSEL      (apb_slv_w_PSEL                 ), //i
    .apb_slv_PENABLE   (apb_slv_w_PENABLE              ), //i
    .apb_slv_PREADY    (coef_trans_apb_slv_PREADY      ), //o
    .apb_slv_PWRITE    (apb_slv_w_PWRITE               ), //i
    .apb_slv_PWDATA    (apb_slv_w_PWDATA[31:0]         ), //i
    .apb_slv_PRDATA    (coef_trans_apb_slv_PRDATA[31:0]), //o
    .apb_slv_PSLVERROR (coef_trans_apb_slv_PSLVERROR   ), //o
    .mem_ena           (coef_trans_mem_ena             ), //o
    .mem_wena          (coef_trans_mem_wena            ), //o
    .mem_wsel          (coef_trans_mem_wsel[3:0]       ), //o
    .mem_addr          (coef_trans_mem_addr[9:0]       ), //o
    .mem_wdata         (coef_trans_mem_wdata[127:0]    ), //o
    .mem_rdata         (w_mem_rdata[127:0]             )  //i
  );
  apb2mem_trans_2 fbank_trans (
    .en                (debug_nn_en                     ), //i
    .apb_slv_PADDR     (apb_slv_fb_PADDR[31:0]          ), //i
    .apb_slv_PSEL      (apb_slv_fb_PSEL                 ), //i
    .apb_slv_PENABLE   (apb_slv_fb_PENABLE              ), //i
    .apb_slv_PREADY    (fbank_trans_apb_slv_PREADY      ), //o
    .apb_slv_PWRITE    (apb_slv_fb_PWRITE               ), //i
    .apb_slv_PWDATA    (apb_slv_fb_PWDATA[31:0]         ), //i
    .apb_slv_PRDATA    (fbank_trans_apb_slv_PRDATA[31:0]), //o
    .apb_slv_PSLVERROR (fbank_trans_apb_slv_PSLVERROR   ), //o
    .mem_ena           (fbank_trans_mem_ena             ), //o
    .mem_wena          (fbank_trans_mem_wena            ), //o
    .mem_wsel          (fbank_trans_mem_wsel[3:0]       ), //o
    .mem_addr          (fbank_trans_mem_addr[6:0]       ), //o
    .mem_wdata         (fbank_trans_mem_wdata[127:0]    ), //o
    .mem_rdata         (fb_mem_rdata[127:0]             )  //i
  );
  apb2pcm_mem_trans pcm_trans (
    .en                (debug_rx_en                   ), //i
    .apb_slv_PADDR     (apb_slv_pcm_PADDR[31:0]       ), //i
    .apb_slv_PSEL      (apb_slv_pcm_PSEL              ), //i
    .apb_slv_PENABLE   (apb_slv_pcm_PENABLE           ), //i
    .apb_slv_PREADY    (pcm_trans_apb_slv_PREADY      ), //o
    .apb_slv_PWRITE    (apb_slv_pcm_PWRITE            ), //i
    .apb_slv_PWDATA    (apb_slv_pcm_PWDATA[31:0]      ), //i
    .apb_slv_PRDATA    (pcm_trans_apb_slv_PRDATA[31:0]), //o
    .apb_slv_PSLVERROR (pcm_trans_apb_slv_PSLVERROR   ), //o
    .pcm_mb_ena        (pcm_trans_pcm_mb_ena          ), //o
    .pcm_mb_wena       (pcm_trans_pcm_mb_wena         ), //o
    .pcm_mb_wsel       (pcm_trans_pcm_mb_wsel         ), //o
    .pcm_mb_addr       (pcm_trans_pcm_mb_addr[7:0]    ), //o
    .pcm_mb_wdata      (pcm_trans_pcm_mb_wdata[15:0]  ), //o
    .pcm_mb_rdata      (pcm_trans_pcm_mb_rdata[15:0]  )  //i
  );
  assign apb_slv_a_PREADY = cache_trans_apb_slv_PREADY; // @[apb2mem_top.scala 32:26]
  assign apb_slv_a_PRDATA = cache_trans_apb_slv_PRDATA; // @[apb2mem_top.scala 32:26]
  assign apb_slv_a_PSLVERROR = cache_trans_apb_slv_PSLVERROR; // @[apb2mem_top.scala 32:26]
  assign a_mem_ena = cache_trans_mem_ena; // @[apb2mem_top.scala 33:22]
  assign a_mem_wena = cache_trans_mem_wena; // @[apb2mem_top.scala 33:22]
  assign a_mem_wsel = cache_trans_mem_wsel; // @[apb2mem_top.scala 33:22]
  assign a_mem_addr = cache_trans_mem_addr; // @[apb2mem_top.scala 33:22]
  assign a_mem_wdata = cache_trans_mem_wdata; // @[apb2mem_top.scala 33:22]
  assign apb_slv_w_PREADY = coef_trans_apb_slv_PREADY; // @[apb2mem_top.scala 36:25]
  assign apb_slv_w_PRDATA = coef_trans_apb_slv_PRDATA; // @[apb2mem_top.scala 36:25]
  assign apb_slv_w_PSLVERROR = coef_trans_apb_slv_PSLVERROR; // @[apb2mem_top.scala 36:25]
  assign w_mem_ena = coef_trans_mem_ena; // @[apb2mem_top.scala 37:21]
  assign w_mem_wena = coef_trans_mem_wena; // @[apb2mem_top.scala 37:21]
  assign w_mem_wsel = coef_trans_mem_wsel; // @[apb2mem_top.scala 37:21]
  assign w_mem_addr = coef_trans_mem_addr; // @[apb2mem_top.scala 37:21]
  assign w_mem_wdata = coef_trans_mem_wdata; // @[apb2mem_top.scala 37:21]
  assign apb_slv_fb_PREADY = fbank_trans_apb_slv_PREADY; // @[apb2mem_top.scala 40:26]
  assign apb_slv_fb_PRDATA = fbank_trans_apb_slv_PRDATA; // @[apb2mem_top.scala 40:26]
  assign apb_slv_fb_PSLVERROR = fbank_trans_apb_slv_PSLVERROR; // @[apb2mem_top.scala 40:26]
  assign fb_mem_ena = fbank_trans_mem_ena; // @[apb2mem_top.scala 41:22]
  assign fb_mem_wena = fbank_trans_mem_wena; // @[apb2mem_top.scala 41:22]
  assign fb_mem_wsel = fbank_trans_mem_wsel; // @[apb2mem_top.scala 41:22]
  assign fb_mem_addr = fbank_trans_mem_addr; // @[apb2mem_top.scala 41:22]
  assign fb_mem_wdata = fbank_trans_mem_wdata; // @[apb2mem_top.scala 41:22]
  assign apb_slv_pcm_PREADY = pcm_trans_apb_slv_PREADY; // @[apb2mem_top.scala 45:24]
  assign apb_slv_pcm_PRDATA = pcm_trans_apb_slv_PRDATA; // @[apb2mem_top.scala 45:24]
  assign apb_slv_pcm_PSLVERROR = pcm_trans_apb_slv_PSLVERROR; // @[apb2mem_top.scala 45:24]
  always @(*) begin
    pcm_mb0_ena = 1'b0; // @[apb2mem_top.scala 48:18]
    if(pingpong_flag) begin
      pcm_mb0_ena = pcm_trans_pcm_mb_ena; // @[apb2mem_top.scala 61:20]
    end
  end

  always @(*) begin
    pcm_mb0_wena = 1'b0; // @[apb2mem_top.scala 49:19]
    if(pingpong_flag) begin
      pcm_mb0_wena = pcm_trans_pcm_mb_wena; // @[apb2mem_top.scala 62:21]
    end
  end

  always @(*) begin
    pcm_mb0_wsel = 1'b0; // @[apb2mem_top.scala 50:19]
    if(pingpong_flag) begin
      pcm_mb0_wsel = pcm_trans_pcm_mb_wsel; // @[apb2mem_top.scala 63:21]
    end
  end

  always @(*) begin
    pcm_mb0_wdata = 16'h0; // @[apb2mem_top.scala 51:20]
    if(pingpong_flag) begin
      pcm_mb0_wdata = pcm_trans_pcm_mb_wdata; // @[apb2mem_top.scala 64:22]
    end
  end

  always @(*) begin
    pcm_mb0_addr = 8'h0; // @[apb2mem_top.scala 52:19]
    if(pingpong_flag) begin
      pcm_mb0_addr = pcm_trans_pcm_mb_addr; // @[apb2mem_top.scala 65:21]
    end
  end

  always @(*) begin
    pcm_mb1_ena = 1'b0; // @[apb2mem_top.scala 54:18]
    if(!pingpong_flag) begin
      pcm_mb1_ena = pcm_trans_pcm_mb_ena; // @[apb2mem_top.scala 68:20]
    end
  end

  always @(*) begin
    pcm_mb1_wena = 1'b0; // @[apb2mem_top.scala 55:19]
    if(!pingpong_flag) begin
      pcm_mb1_wena = pcm_trans_pcm_mb_wena; // @[apb2mem_top.scala 69:21]
    end
  end

  always @(*) begin
    pcm_mb1_wsel = 1'b0; // @[apb2mem_top.scala 56:19]
    if(!pingpong_flag) begin
      pcm_mb1_wsel = pcm_trans_pcm_mb_wsel; // @[apb2mem_top.scala 70:21]
    end
  end

  always @(*) begin
    pcm_mb1_wdata = 16'h0; // @[apb2mem_top.scala 57:20]
    if(!pingpong_flag) begin
      pcm_mb1_wdata = pcm_trans_pcm_mb_wdata; // @[apb2mem_top.scala 71:22]
    end
  end

  always @(*) begin
    pcm_mb1_addr = 8'h0; // @[apb2mem_top.scala 58:19]
    if(!pingpong_flag) begin
      pcm_mb1_addr = pcm_trans_pcm_mb_addr; // @[apb2mem_top.scala 72:21]
    end
  end

  always @(*) begin
    if(pingpong_flag) begin
      pcm_trans_pcm_mb_rdata = pcm_mb0_rdata; // @[apb2mem_top.scala 66:31]
    end else begin
      pcm_trans_pcm_mb_rdata = pcm_mb1_rdata; // @[apb2mem_top.scala 73:31]
    end
  end


endmodule

module apb2pcm_mem_trans (
  input               en,
  input      [31:0]   apb_slv_PADDR,
  input      [0:0]    apb_slv_PSEL,
  input               apb_slv_PENABLE,
  output reg          apb_slv_PREADY,
  input               apb_slv_PWRITE,
  input      [31:0]   apb_slv_PWDATA,
  output reg [31:0]   apb_slv_PRDATA,
  output              apb_slv_PSLVERROR,
  output reg          pcm_mb_ena,
  output reg          pcm_mb_wena,
  output reg [0:0]    pcm_mb_wsel,
  output reg [7:0]    pcm_mb_addr,
  output reg [15:0]   pcm_mb_wdata,
  input      [15:0]   pcm_mb_rdata
);


  assign apb_slv_PSLVERROR = 1'b0; // @[apb2pcm_mem_trans.scala 20:24]
  always @(*) begin
    apb_slv_PREADY = 1'b0; // @[apb2pcm_mem_trans.scala 21:21]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            apb_slv_PREADY = 1'b1; // @[apb2pcm_mem_trans.scala 38:29]
          end else begin
            apb_slv_PREADY = 1'b0; // @[apb2pcm_mem_trans.scala 42:29]
          end
        end else begin
          if(apb_slv_PENABLE) begin
            apb_slv_PREADY = 1'b1; // @[apb2pcm_mem_trans.scala 48:29]
          end else begin
            apb_slv_PREADY = 1'b0; // @[apb2pcm_mem_trans.scala 54:29]
          end
        end
      end
    end
  end

  always @(*) begin
    apb_slv_PRDATA = 32'h0; // @[apb2pcm_mem_trans.scala 22:21]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(!apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            apb_slv_PRDATA = {16'h0,pcm_mb_rdata}; // @[apb2pcm_mem_trans.scala 49:29]
          end
        end
      end
    end
  end

  always @(*) begin
    pcm_mb_ena = 1'b0; // @[apb2pcm_mem_trans.scala 24:17]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            pcm_mb_ena = 1'b1; // @[apb2pcm_mem_trans.scala 33:25]
          end else begin
            pcm_mb_ena = 1'b0; // @[apb2pcm_mem_trans.scala 40:25]
          end
        end else begin
          if(apb_slv_PENABLE) begin
            pcm_mb_ena = 1'b0; // @[apb2pcm_mem_trans.scala 46:25]
          end else begin
            pcm_mb_ena = 1'b1; // @[apb2pcm_mem_trans.scala 51:25]
          end
        end
      end
    end
  end

  always @(*) begin
    pcm_mb_wena = 1'b0; // @[apb2pcm_mem_trans.scala 25:18]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            pcm_mb_wena = 1'b1; // @[apb2pcm_mem_trans.scala 34:26]
          end else begin
            pcm_mb_wena = 1'b0; // @[apb2pcm_mem_trans.scala 41:26]
          end
        end else begin
          if(apb_slv_PENABLE) begin
            pcm_mb_wena = 1'b0; // @[apb2pcm_mem_trans.scala 47:26]
          end else begin
            pcm_mb_wena = 1'b0; // @[apb2pcm_mem_trans.scala 52:26]
          end
        end
      end
    end
  end

  always @(*) begin
    pcm_mb_wsel = 1'b0; // @[apb2pcm_mem_trans.scala 26:18]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            pcm_mb_wsel = 1'b1; // @[apb2pcm_mem_trans.scala 36:26]
          end
        end
      end
    end
  end

  always @(*) begin
    pcm_mb_wdata = 16'h0; // @[apb2pcm_mem_trans.scala 27:19]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            pcm_mb_wdata = apb_slv_PWDATA[15 : 0]; // @[apb2pcm_mem_trans.scala 37:27]
          end
        end
      end
    end
  end

  always @(*) begin
    pcm_mb_addr = 8'h0; // @[apb2pcm_mem_trans.scala 28:18]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            pcm_mb_addr = apb_slv_PADDR[7 : 0]; // @[apb2pcm_mem_trans.scala 35:26]
          end
        end else begin
          if(!apb_slv_PENABLE) begin
            pcm_mb_addr = apb_slv_PADDR[7 : 0]; // @[apb2pcm_mem_trans.scala 53:26]
          end
        end
      end
    end
  end


endmodule

//apb2mem_trans_2 replaced by apb2mem_trans_2

module apb2mem_trans_1 (
  input               en,
  input      [31:0]   apb_slv_PADDR,
  input      [0:0]    apb_slv_PSEL,
  input               apb_slv_PENABLE,
  output reg          apb_slv_PREADY,
  input               apb_slv_PWRITE,
  input      [31:0]   apb_slv_PWDATA,
  output reg [31:0]   apb_slv_PRDATA,
  output              apb_slv_PSLVERROR,
  output reg          mem_ena,
  output reg          mem_wena,
  output reg [3:0]    mem_wsel,
  output reg [9:0]    mem_addr,
  output reg [127:0]  mem_wdata,
  input      [127:0]  mem_rdata
);

  wire       [3:0]    tmp_wsel;
  wire       [1:0]    shiftnum;
  wire       [3:0]    wsel;
  wire       [6:0]    bitoffset;

  assign tmp_wsel = (4'b0001 <<< shiftnum);
  assign shiftnum = apb_slv_PADDR[3 : 2]; // @[BaseType.scala 299:24]
  assign wsel = tmp_wsel; // @[BaseType.scala 318:22]
  assign bitoffset = ({5'd0,shiftnum} <<< 5); // @[BaseType.scala 299:24]
  assign apb_slv_PSLVERROR = 1'b0; // @[apb2mem_trans.scala 47:24]
  always @(*) begin
    apb_slv_PREADY = 1'b0; // @[apb2mem_trans.scala 48:21]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            apb_slv_PREADY = 1'b1; // @[apb2mem_trans.scala 65:29]
          end else begin
            apb_slv_PREADY = 1'b0; // @[apb2mem_trans.scala 69:29]
          end
        end else begin
          if(apb_slv_PENABLE) begin
            apb_slv_PREADY = 1'b1; // @[apb2mem_trans.scala 75:29]
          end else begin
            apb_slv_PREADY = 1'b0; // @[apb2mem_trans.scala 81:29]
          end
        end
      end
    end
  end

  always @(*) begin
    apb_slv_PRDATA = 32'h0; // @[apb2mem_trans.scala 49:21]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(!apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            apb_slv_PRDATA = mem_rdata[bitoffset +: 32]; // @[apb2mem_trans.scala 76:29]
          end
        end
      end
    end
  end

  always @(*) begin
    mem_ena = 1'b0; // @[apb2mem_trans.scala 51:14]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            mem_ena = 1'b1; // @[apb2mem_trans.scala 60:22]
          end else begin
            mem_ena = 1'b0; // @[apb2mem_trans.scala 67:22]
          end
        end else begin
          if(apb_slv_PENABLE) begin
            mem_ena = 1'b0; // @[apb2mem_trans.scala 73:22]
          end else begin
            mem_ena = 1'b1; // @[apb2mem_trans.scala 78:22]
          end
        end
      end
    end
  end

  always @(*) begin
    mem_wena = 1'b0; // @[apb2mem_trans.scala 52:15]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            mem_wena = 1'b1; // @[apb2mem_trans.scala 61:23]
          end else begin
            mem_wena = 1'b0; // @[apb2mem_trans.scala 68:23]
          end
        end else begin
          if(apb_slv_PENABLE) begin
            mem_wena = 1'b0; // @[apb2mem_trans.scala 74:23]
          end else begin
            mem_wena = 1'b0; // @[apb2mem_trans.scala 79:23]
          end
        end
      end
    end
  end

  always @(*) begin
    mem_wsel = 4'b0000; // @[apb2mem_trans.scala 53:15]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            mem_wsel = wsel; // @[apb2mem_trans.scala 63:23]
          end
        end
      end
    end
  end

  always @(*) begin
    mem_wdata = 128'h0; // @[apb2mem_trans.scala 54:16]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            mem_wdata[bitoffset +: 32] = apb_slv_PWDATA; // @[apb2mem_trans.scala 64:54]
          end
        end
      end
    end
  end

  always @(*) begin
    mem_addr = 10'h0; // @[apb2mem_trans.scala 55:15]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            mem_addr = apb_slv_PADDR[13 : 4]; // @[apb2mem_trans.scala 62:23]
          end
        end else begin
          if(!apb_slv_PENABLE) begin
            mem_addr = apb_slv_PADDR[13 : 4]; // @[apb2mem_trans.scala 80:23]
          end
        end
      end
    end
  end


endmodule

module apb2mem_trans_2 (
  input               en,
  input      [31:0]   apb_slv_PADDR,
  input      [0:0]    apb_slv_PSEL,
  input               apb_slv_PENABLE,
  output reg          apb_slv_PREADY,
  input               apb_slv_PWRITE,
  input      [31:0]   apb_slv_PWDATA,
  output reg [31:0]   apb_slv_PRDATA,
  output              apb_slv_PSLVERROR,
  output reg          mem_ena,
  output reg          mem_wena,
  output reg [3:0]    mem_wsel,
  output reg [6:0]    mem_addr,
  output reg [127:0]  mem_wdata,
  input      [127:0]  mem_rdata
);

  wire       [3:0]    tmp_wsel;
  wire       [1:0]    shiftnum;
  wire       [3:0]    wsel;
  wire       [6:0]    bitoffset;

  assign tmp_wsel = (4'b0001 <<< shiftnum);
  assign shiftnum = apb_slv_PADDR[3 : 2]; // @[BaseType.scala 299:24]
  assign wsel = tmp_wsel; // @[BaseType.scala 318:22]
  assign bitoffset = ({5'd0,shiftnum} <<< 5); // @[BaseType.scala 299:24]
  assign apb_slv_PSLVERROR = 1'b0; // @[apb2mem_trans.scala 47:24]
  always @(*) begin
    apb_slv_PREADY = 1'b0; // @[apb2mem_trans.scala 48:21]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            apb_slv_PREADY = 1'b1; // @[apb2mem_trans.scala 65:29]
          end else begin
            apb_slv_PREADY = 1'b0; // @[apb2mem_trans.scala 69:29]
          end
        end else begin
          if(apb_slv_PENABLE) begin
            apb_slv_PREADY = 1'b1; // @[apb2mem_trans.scala 75:29]
          end else begin
            apb_slv_PREADY = 1'b0; // @[apb2mem_trans.scala 81:29]
          end
        end
      end
    end
  end

  always @(*) begin
    apb_slv_PRDATA = 32'h0; // @[apb2mem_trans.scala 49:21]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(!apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            apb_slv_PRDATA = mem_rdata[bitoffset +: 32]; // @[apb2mem_trans.scala 76:29]
          end
        end
      end
    end
  end

  always @(*) begin
    mem_ena = 1'b0; // @[apb2mem_trans.scala 51:14]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            mem_ena = 1'b1; // @[apb2mem_trans.scala 60:22]
          end else begin
            mem_ena = 1'b0; // @[apb2mem_trans.scala 67:22]
          end
        end else begin
          if(apb_slv_PENABLE) begin
            mem_ena = 1'b0; // @[apb2mem_trans.scala 73:22]
          end else begin
            mem_ena = 1'b1; // @[apb2mem_trans.scala 78:22]
          end
        end
      end
    end
  end

  always @(*) begin
    mem_wena = 1'b0; // @[apb2mem_trans.scala 52:15]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            mem_wena = 1'b1; // @[apb2mem_trans.scala 61:23]
          end else begin
            mem_wena = 1'b0; // @[apb2mem_trans.scala 68:23]
          end
        end else begin
          if(apb_slv_PENABLE) begin
            mem_wena = 1'b0; // @[apb2mem_trans.scala 74:23]
          end else begin
            mem_wena = 1'b0; // @[apb2mem_trans.scala 79:23]
          end
        end
      end
    end
  end

  always @(*) begin
    mem_wsel = 4'b0000; // @[apb2mem_trans.scala 53:15]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            mem_wsel = wsel; // @[apb2mem_trans.scala 63:23]
          end
        end
      end
    end
  end

  always @(*) begin
    mem_wdata = 128'h0; // @[apb2mem_trans.scala 54:16]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            mem_wdata[bitoffset +: 32] = apb_slv_PWDATA; // @[apb2mem_trans.scala 64:54]
          end
        end
      end
    end
  end

  always @(*) begin
    mem_addr = 7'h0; // @[apb2mem_trans.scala 55:15]
    if(en) begin
      if(apb_slv_PSEL[0]) begin
        if(apb_slv_PWRITE) begin
          if(apb_slv_PENABLE) begin
            mem_addr = apb_slv_PADDR[10 : 4]; // @[apb2mem_trans.scala 62:23]
          end
        end else begin
          if(!apb_slv_PENABLE) begin
            mem_addr = apb_slv_PADDR[10 : 4]; // @[apb2mem_trans.scala 80:23]
          end
        end
      end
    end
  end


endmodule
