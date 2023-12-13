/*----------------------------------------------------------------
//           Mon premier programme                              //
----------------------------------------------------------------*/
    .text
    .globl    _start
_start:
	mov r1, #1 
	add r0, r1, r1
	subs r0, r1, r0
nop
	adds r0, r0, r1
nop 
	teq r0,r0

	nop
	nop
_good:
	nop
	nop
_bad:
	nop
	nop
