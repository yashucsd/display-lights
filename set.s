/*
 * Filename: set.s
 * Author: Yash Nevatia
 * Description: This function sets the lights in the lightBank based on which
 * 				bits are set in the bit patterns passed in. pattern0 represents
 * 				the bits that should be set in the first 32 lights, and pattern1
 * 				represents the bits that should be set in the second 32 lights.
 * Date: 8 February 2017
 * Sources of Help
 */ 
 	.global set          	 ! Declares the sumbol to be globally visible so
							 ! we can call this function from other modules.
	.section ".text"		 ! The text segment begins here
/*
 * Function name: set()
 * Function prototype: void set( unsigned int lightBank[], 
 * 						const unsigned int pattern0, 
 * 						const unsigned int pattern1 );
 * Description: This function sets the lights in the lightBank based on which
 * 				bits are set in the bit patterns passed in.
 * Parameters:
 * 	arg 1: lightBank - the lights to be set
 *	arg 2: pattern0 - the bits that should be set in the first 32 lights
 * 	arg 3: pattern1 - the bits that should be set in the second 32 lights
 *
 * Side Effects: None.
 * Error Conditions: None
 * Return Value: none
 *
 * Registers Used:
 * 	%l0 - keeps the address of the first element of the lightBank
 * 	%l1 - stores the value of a given element of lightBank
 */

INT_SIZE = 4

 set:

 	save	%sp, -96, %sp		! Save callers window, if different than -96
								! then comment on how that value was calculated

	mov		%i0, %l0 			! puts address to first element in l0
	
	ld 		[%l0], %l1 			! l1 stores the value of lightBank[0]
	or 		%l1,  %i1, %l1 		! adds l4 to l1 to update lightBank[0]
	st 		%l1, [%l0] 			! stores the new values of l1 to l0

	add  	%l0, INT_SIZE, %l0 	! increments pointer with scaling

	ld 		[%l0], %l1 			! l1 stores the value of lightBank[1]
	or 		%l1, %i2, %l1 		! adds l5 to l1 to update lightBank[1]
	st 		%l1, [%l0] 			! stores new values of l1 to l0

ret
restore