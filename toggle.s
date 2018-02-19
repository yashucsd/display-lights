/*
 * Filename: toggle.s
 * Author: Yash Nevatia
 * Description: This function toggles the lights in the lightBank based on which
 * 				bits are set in the bit patterns passed in.
 * Date: 14 February 2017
 * Sources of Help
 */ 
 	.global toggle         	 ! Declares the sumbol to be globally visible so
							 ! we can call this function from other modules.
	.section ".text"		 ! The text segment begins here
/*
 * Function name: toggle()
 * Function prototype: void toggle( unsigned int lightBank[],
 * 					const unsigned int pattern0, const unsigned int pattern1 );
 * Description: This function toggles the lights in the lightBank based on which
 * 				bits are set in the bit patterns passed in. pattern0 represents
 * 				the bits that should be toggled in the first 32 lights, and 
 * 				pattern1 represents the bits that should be toggled in the 
 * 				second 32 lights.
 * Parameters:
 * 	arg 1: lightBank - the lights to be toggled
 *	arg 2: pattern0 - the bits that should be toggled in the first 32 lights
 * 	arg 3: pattern1 - the bits that should be toggled in the second 32 lights
 *
 * Side Effects: None.
 * Error Conditions: None
 * Return Value: none
 *
 * Registers Used:
 * 	%l0 - keeps the address of a given element of the lightBank
 * 	%l1 - stores the value of a given element of lightBank
 */

INT_SIZE = 4

toggle:

 	save	%sp, -96, %sp		! Save callers window, if different than -96
								! then comment on how that value was calculated

	mov		%i0, %l0 			! puts address to first element in l0
	
	ld 		[%l0], %l1 			! l1 stores the value of lightBank[0]
	xor 	%l1,  %i1, %l1 		! lB[0] ^ pattern0
	st 		%l1, [%l0] 			! puts xor'd l1 back in lB[0]

	add  	%l0, INT_SIZE, %l0 	! increments pointer with scaling

	ld 		[%l0], %l1 			! l1 stores the value of lightBank[1]
	xor 	%l1, %i2, %l1 		! lB[1] ^ pattern1
	st 		%l1, [%l0] 			! puts xor'd l1 back in lB[1]

ret
restore
