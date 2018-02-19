/*
 * Filename: displayLights.s
 * Author: Yash Nevatia
 * Description: This function displays the lights based on what bits are set
 * 				in the lightBank array.
 * Date: 8 February 2017
 * Sources of Help
 */ 
 	.global displayLights 	 ! Declares the sumbol to be globally visible so
							 ! we can call this function from other modules.
	.section ".text"		 ! The text segment begins here
/*
 * Function name: displayLights()
 * Function prototype: void displayLights( const unsigned int lightBank[] );
 * Description: This function displays the lights based on what bits are set in
 * 				the lightBank array. Print out the char '*' if a light (bit) is
 * 				on, and the char '-' if a light (bit) is off. Cycle through the
 * 				two banks of lights using your printChar() from PA1 to display
 * 				each light one at a time. Output a space character (' ') between
 * 				every four lights (bits). Terminate each line with a newline
 * 				character '\n'.
 * Parameters:
 *	arg 1: lightBank -- the bits that represent the light's values
 *
 * Side Effects: None.
 * Error Conditions: None
 * Return Value: none
 *
 * Registers Used:
 *	%l0 - stores address of a lightBank element
 * 	%l2 - stores the value of a lightBank element
 * 	%l4 - stores the shifted and original translator value
 * 	%l5 - stores the latest bit value in the loop
 * 	%l6 - counts the number of lightBank elements printed as bits
 * 	%l7 - indexs the loop
 */
 
 EXTR = 0x80000000
 INT_SIZE = 4
 BYTE_SIZE = 4

displayLights:

 	save	%sp, -96, %sp		! Save callers window, if different than -96
 								! then comment on how that value was calculated

 	mov		%i0, %l0 			! puts address to first element in l0
	
	ld 		[%l0], %l2 			! l2 stores the value of lightBank[0]

	clr 	%l6 				! keeps track of whether bits are printed

printbits:

	set 	EXTR, %l4 			! for translating the hexadecimal
	mov 	1, %l7 				! keeps index of loop

	cmp 	%l4, 0	 			! checks if the translator is done
	be 		endloop 			! ends loop if so
	nop

loop:

	and 	%l2, %l4, %l5 		! reads hex of element in l2, saves to l5

	cmp 	%l5, 0 				! checks if light is off
	bne 	else 				! skips to else if not
	nop

	mov 	'-', %o0 			! prints '-' if it is off
	call 	printChar
	nop

	ba 		endif 				! skips to end of if
	nop

else:
	
	mov 	'*', %o0 			! prints '*' if it is on
	call 	printChar
	nop

endif:
	mov 	%l7, %o0 
	mov 	BYTE_SIZE, %o1
	call 	.rem 				! checks index % 4
	nop

	cmp 	%o0, 0 				! if index % 4 == 0, 
	bne 	notbyte 			!  a byte has completed printing
	nop

	mov 	' ', %o0 			! prints ' ' after a byte
	call 	printChar
	nop

notbyte:

	srl 	%l4, 1, %l4 		! shifts translator to read next bit

	inc 	%l7 				! increases loop index

	cmp 	%l4, 0 				! checks if translator is done
	bne 	loop 				! loops if it is not done
	nop

endloop:

	cmp 	%l6, 1 				! checks if the second element is considered
	be 		done 				! moves to done if it has
	nop

	inc 	%l6 				! notes that first part has been completed

	add  	%l0, INT_SIZE, %l0 	! increments pointer with scaling
	ld 		[%l0], %l2			! l2 now stores the value of lightBank[1]

	ba 		printbits 			! runs print bits again
	nop

done:

	mov 	'\n', %o0 			! prints newline after each set of banks
	call 	printChar
	nop

ret
restore