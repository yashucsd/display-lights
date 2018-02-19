/*
 * Filename: clear.c
 * Author: Yash Nevatia
 * Description: This function clears the lights in the lightBank based on which
 * 				bits are set in the bit patterns passed in.
 * Date: 14 February 2017
 * Sources of Help
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Function name: clear()
 * Function prototype:  void clear( unsigned int lightBank[],
 * 				const unsigned int pattern0, const unsigned int pattern1 );
 * Description: This function clears the lights in the lightBank based on which
 * 				bits are set in the bit patterns passed in. pattern0 represents
 * 				the bits that should be cleared in the first 32 lights, and
 * 				pattern1 represents the bits that should be cleared in the
 * 				second 32 lights.
 * Parameters:
 *  arg 1: lightBank[] -- the lights to be cleared
 *  arg 2: pattern0 -- the bits that should be cleared in the first 32 lights
 *  arg 3: pattern1 -- the bits that should be cleared in the second 32 lights
 * Side Effects:
 * Error Conditions:
 * Return Value:   none
 */

void clear( unsigned int lightBank[], const unsigned int pattern0,
	const unsigned int pattern1 ){

	lightBank[0] = lightBank[0] - pattern0;
	lightBank[1] = lightBank[1] - pattern1;

}
