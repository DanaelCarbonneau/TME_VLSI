/*----------------------------------------------------------------
//           Mon premier programme                              //
----------------------------------------------------------------*/   

.text
    .globl    _start
_start:
	nop
	nop
	mov r1, #1 
	add r0, r1, r1
	subs r0, r1, r0

	adds r0, r0, r1

	teq r0,r0
	
	mov r0, #0
	addne r1, r0, #16
	addeq r1,r0, #20
	ldr r3, data2
nop
	add r1,r3, #0
	beq _good
	add r1,r0, #0
	add r1,r0, #29

	add r1,r0, #26



_bad:
	nop
	nop
_good:
	nop
	nop


