/*
 * Filename: testcheckCmd.c
 * Author: Yash Nevatia
 * Description: Unit test program to test the function checkCmd().
 * Date: 8 February 2017
 * Sources of Help
 */ 

#include "test.h"    /* For TEST() macro and stdio.h */
#include "pa2.h"     /* For set() function prototype */

/*
 * Unit Test for checkCmd()
 *
 * int checkCmd( const char * const cmdString, const char * const commands[] );
 * 
 * This function checks to see if the cmdString is in the commands
 * array (you will want to use strncmp()). Make sure to have
 * appropriate null checks for the pointers passed in. If either
 * pointers are null, return -1.
 */
void testcheckCmd() {
    const char * const a = NULL;
    const char * const commands[4] = {"yash", "test", "food", NULL};

    (void) printf( "Testing checkCmd()\n" );

    /* Test One */
    TEST( checkCmd(a, commands) == -1 );

    /* Test Two */
    const char * const b = "NULL";
    TEST( checkCmd(b, commands) == -1 );

    /* Test Three */
    const char * const c = "food";
    TEST( checkCmd(c, commands) == 2 );

    printf( "Finished running tests on checkCmd()\n" );
}

int main() {
    testcheckCmd();
    return 0;
}
