/*
 * Filename: rotate.s
 * Author: Yash Nevatia
 * Description: This function rotates the current light patterns in the light
 * 				banks by rotateCnt places.
 * Date: 14 February 2017
 * Sources of Help
 */ 
 	.global rotate         	 ! Declares the sumbol to be globally visible so
							 ! we can call this function from other modules.
	.section ".text"		 ! The text segment begins here
/*
 * Function name: rotate()
 * Function prototype: void rotate( unsigned int lightBank[]
 						const int rotateCnt );
 * Description: This function rotates the current light patterns in the light
 * 				banks by rotateCnt places. If rotateCnt is positive, rotate
 * 				left; if rotateCnt is negative, rotate right. Only the lower
 * 				6 bits of the rotateCnt should be used for the amount to rotate
 * 				by (use bit mask 0x3F to get the lower 6 bits).
 * Parameters:
 * 	arg 1: lightBank - the lights to be rotated
 *	arg 2: rotateCnt - the number of bits to rotate
 *
 * Side Effects: None.
 * Error Conditions: None
 * Return Value: none
 *
 * Registers Used:
 * 	%l0 - stores address of first lightBank element
 * 	%l1 - stores address of second lightBank element
 * 	%l2 - stores value of lightBank[0]
 * 	%l3 - stores value of lightBank[1]
 * 	%l4 - holds the extreme bit of a bank element
 * 	%l5 - holds the other extreme bit of the other bank element
 * 	%l6 - holds the left extractor
 * 	%l7 - holds the right extractor
 */

 MASK = 0x3F
 LEXTR = 0x80000000
 REXTR = 0x00000001
 INT_SIZE = 4

 rotate:

 	save	%sp, -96, %sp		! Save callers window, if different than -96
								! then comment on how that value was calculated

	mov		%i0, %l0 			! puts address to first element in l0
	ld 		[%l0], %l2 			! l2 stores the value of lightBank[0]	
	add  	%l0, INT_SIZE, %l1 	! increments pointer with scaling
	ld 		[%l1], %l3			! l3 stores the value of lightBank[1]

	set 	LEXTR, %l6 			! stores the left extractor
	set 	REXTR, %l7 			! stores the right extractor

	cmp 	%i1, 0
	bl		right				! if rotateCnt < 0, shifts right
	nop

	and 	%i1, MASK, %i1 		! masks rotateCnt for lower 6 bits

left:
	
	cmp 	%i1, 0
	be 		endLloop			! ends rotating if there is no more to rotate
	nop
	
Lloop:
	
	and 	%l2, %l6, %l5 		! puts the leftmost bit of lB[0] in l5
	srl 	%l5, 31, %l5		! moves bit to the rightmost status

	and 	%l3, %l6, %l4		! puts leftmost bit of lB[1] in l4
	srl 	%l4, 31, %l4		! moves bit to the rightmost status

	sll 	%l2, 1, %l2 		! shifts lB[0] once
	sll 	%l3, 1, %l3			! shifts lB[1] once

	or 		%l3, %l5, %l3		! puts l5 in rightmost spot of lB[1]
	or 		%l2, %l4, %l2 		! puts l4 in rightmost spot of lB[0]

	dec 	%i1 				! reduces the number of shifts to do

	cmp 	%i1, 0
	bne 	Lloop 				! loops again if there are more shifts to do
	nop

endLloop:

	ba end 						! since rotate is complete, skips to end
	nop

right:

	neg 	%i1, %i1 			! the rotate count is negative
	and 	%i1, MASK, %i1 		! masks rotateCnt for lower 6 bits
	
	cmp 	%i1, 0
	be 		end			 		! ends program if there is no more to rotate
	nop
	
Rloop:

	and 	%l2, %l7, %l5 		! puts the rightmost bit of lB[0] in l5
	sll 	%l5, 31, %l5		! moves bit to the leftmost status

	and 	%l3, %l7, %l4		! puts rightmost bit of lB[1] in l4
	sll 	%l4, 31, %l4		! moves bit to the leftmost status

	srl 	%l2, 1, %l2 		! shifts lB[0] once
	srl 	%l3, 1, %l3			! shifts lB[1] once

	or 		%l3, %l5, %l3	! puts l5 in leftmost spot of lB[1]
	or 		%l2, %l4, %l2 	! puts l4 in leftmost spot of lB[0]

	dec 	%i1 				! reduces the number of rotations to do

	cmp 	%i1, 0
	bne 	Rloop 				! loops again if there are more rotations to do
	nop

end:

	st 		%l2, [%l0] 			! stores new values of l2 to l0
	st 		%l3, [%l1] 			! stores new values of l3 to l1

ret
restore