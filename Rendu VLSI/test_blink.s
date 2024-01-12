/*----------------------------------------------------------------
//           Mon premier programme                              //
----------------------------------------------------------------*/   

	

.text
    .globl    _start


_start:
	b debut
nop
nop

fun : 
	add r2, r1, #2
	orr r15, r14, #0
	nop
	nop

debut :
	mov r1, #1 

	bl fun
nop
	b _good

_bad:
	nop
	nop





_good:
	nop
	nop

