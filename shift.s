/*
 * Filename: shift.s
 * Author: Yash Nevatia
 * Description: This function shifts the current light patterns in the light
 * 				banks by shiftCnt places.
 * Date: 8 February 2017
 * Sources of Help
 */ 
 	.global shift          	 ! Declares the sumbol to be globally visible so
							 ! we can call this function from other modules.
	.section ".text"		 ! The text segment begins here
/*
 * Function name: shift()
 * Function prototype: void shift(unsigned int lightBank[], const int shiftCnt);
 * Description: This function shifts the current light patterns in the light
 * 				banks by shiftCnt places. If shiftCnt is positive, shift left;
 * 				if shiftCnt is negative, shift right. Only the lower 6 bits of 
 * 				the shiftCnt should be used for the amount to shift by (use bit
 * 				mask 0x3F to get the lower 6 bits). Note: Care must be taken
 * 				before masking negative numbers because of 2’s complement
 * 				notation.
 * Parameters: 
 * 	arg 1: lightBank - the lights to shift
 *	arg 2: shiftCnt - the number of places to shift lightbank
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
 * 	%l5 - holds the appropriate hexadecimal to retrieve the first/last bit
 */

 MASK = 0x3F
 LEXTR = 0x80000000
 REXTR = 0x00000001
 INT_SIZE = 4

 shift:

 	save	%sp, -96, %sp		! Save callers window, if different than -96
								! then comment on how that value was calculated

	mov		%i0, %l0 			! puts address to first element in l0
	ld 		[%l0], %l2 			! l2 stores the value of lightBank[0]	
	add  	%l0, INT_SIZE, %l1 	! increments pointer with scaling
	ld 		[%l1], %l3			! l3 stores the value of lightBank[1]

	clr 	%l4					! stores right/left most bit

	cmp 	%i1, 0
	bl 		right				! if shiftCnt < 0, shifts right		
	nop

	and 	%i1, MASK, %i1 		! masks shiftCnt for lower 6 bits

left:
	
	cmp 	%i1, 0
	be 		endLloop			! ends shifting if there is no more to shift
	nop
	
Lloop:

	sll 	%l2, 1, %l2 		! shifts lB[0] once

	set 	LEXTR, %l5

	and 	%l3, %l5, %l4		! puts first element of lB[1] in l4

	srl 	%l4, 31, %l4		! moves bit to the rightmost status

	or 		%l2, %l4, %l2 		! puts bit in rightmost spot of lB[0]

	sll 	%l3, 1, %l3			! shifts lB[1] once

	dec 	%i1 				! reduces the number of shifts to do

	cmp 	%i1, 0
	bne 	Lloop 				! loops again if there are more shifts to do
	nop

endLloop:

	ba end 						! since shifting is complete, skips to end
	nop

right:

	neg 	%i1 				! the shift count is negative
	and 	%i1, MASK, %i1 		! masks shiftCnt for lower 6 bits
	
	cmp 	%i1, 0
	be 		end			 		! ends shifting if there is no more to shift
	nop
	
Rloop:

	srl 	%l3, 1, %l3 		! shifts lB[1] once

	set 	REXTR, %l5

	and 	%l2, %l5, %l4		! puts last element of lB[0] in l4

	sll 	%l4, 31, %l4		! moves bit to the leftmost status

	or 		%l3, %l4, %l3 		! puts bit in leftmost spot of lB[1]

	srl 	%l2, 1, %l2			! shifts lB[0] once

	dec 	%i1 				! reduces the number of shifts to do

	cmp 	%i1, 0
	bne 	Rloop 				! loops again if there are more shifts to do
	nop

end:

	st 		%l2, [%l0] 			! stores new values of l2 to l0
	st 		%l3, [%l1] 			! stores new values of l3 to l1

ret
restore