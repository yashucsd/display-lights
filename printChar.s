/*
 * Filename: printChar.s
 * Author: Yash Nevatia
 * Description: This assembly module prints the character argument to stdout
 * Date: 31 January 2017
 * Sources of Help:
 */ 
 	.global printChar	! Declares the sumbol to be globally visible so
						! we can call this function from other modules.

	.section ".data"    ! The data segment begins here
fmt:                    ! Formatted string used for printf()
    .asciz "%c"

	.section ".text"	! The text segment begins here
/*
 * Function name: printChar()
 * Function prototype: void printChar( long val );
 * Description: prints the character argument to stdout
 * Parameters:
 *	arg 1: val -- value to be printed
 * 
 * Side Effects: None.
 * Error Conditions: None
 * Return Value: None
 *
 * Registers Used:
 *  %o0 - format string -- copy of fmt for format
 * 	%o1 - arg 1 -- copy for printing
 */

printChar:
 	save	%sp, -96, %sp	! Save callers window, if different than -96
							! then comment on how that value was calculated

	set     fmt, %o0        ! Format string
    mov     %i0, %o1        ! Copy of formal parameter to print
    call    printf          ! Make function call
    nop                     ! Delay slot for call instruction
	
	ret						! Return from subroutine
	restore					! Restore callers window, in "ret" delay shot