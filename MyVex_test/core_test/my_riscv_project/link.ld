OUTPUT_ARCH( "riscv" )
ENTRY(_start)

MEMORY {
  IRAM (rwx) : ORIGIN = 0x00000, LENGTH = 64K
  DRAM (rwx) : ORIGIN = 0x80000, LENGTH = 64K
}

__top_dmem = ORIGIN(DRAM) + LENGTH(DRAM);

SECTIONS
{
	.text : ALIGN(4)
  	{ 
  		*(.text)
  		*(.text*)
  		*(.vectors)
    	. = ALIGN(4);
    	_etext = .; /* define a global symbol at end of code */
    	LONG(0);
	  	LONG(0);
  	} > IRAM 

	.rodata : ALIGN(4)
	{ 
		_srodata = .;   /* create a global symbol at rodata start */
	  	*(.rodata)
	  	*(.rodata.*)
	  	. = ALIGN(4);
  	} > DRAM

	.data : ALIGN(4)
	{
		*(.data)
		*(.data.*)
		*(.sdata)
		*(.sdata.*)
		. = ALIGN(4);
		_edata = .;      /* define a global symbol at data end */
	} > DRAM

	.bss : ALIGN(4)
	{
		_sbss = .;   		/* create a global symbol at bss start */
		*(.bss*)
		*(.sbss*)
		*(COMMON)
		. = ALIGN(4);
		_ebss = .; 			/* define a global symbol at bss end */
		PROVIDE(_end = .);
		LONG(0);
		LONG(0);
	} > DRAM

  PROVIDE(__stack_top = __top_dmem);

  /DISCARD/ : { *(.comment) }
}
