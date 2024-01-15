/*----------------------------------------------------------------
//           Mon premier programme                              //
----------------------------------------------------------------*/   

	

.text
    .globl    _start




_start:
	
	ldr r3, data
nop
nop
	str r3, data2
nop
	ldr r8, data2
nop
nop
nop
	b _good




_bad:
	nop
	nop
_good:
	nop
	nop

data: .word 0x12345678 
data2: .word 0x00000000

