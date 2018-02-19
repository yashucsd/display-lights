/*
 * Filename: testdisplayLights.c
 * Author: Yash Nevatia
 * Description: Unit test program to test the function displayLights().
 * Date: 8 February 2017
 * Sources of Help
 */ 

#include <stdlib.h>
#include <signal.h>

#include <string.h>

#include "pa2.h"       /* For displayLights() function prototype */
#include "test.h"      /* For TEST() macro and stdio.h */

#define SYSRUN(CMD) (system(CMD))

void runTest( unsigned int bank[], char * expectedOutput, char * testDesc );

char * refFileName = ".test_displayLights_reference_file";
char * testFileName = ".test_displayLights_student_file";


/*
 * Unit Test for displayLights.s
 * 
 * void displayLights( const unsigned int lightBank[] );
 *
 * Displays the lights based on what bits are set in the lightBank array.
 * Prints '*' if a light is on, prints '-' if a light is off.  A space ' ' is
 * printed between each set of four lights.
 */
void testdisplayLights() {

  unsigned int lightBank[2];
  char * expected;


  /* Test 1 */
  lightBank[0] = 0x0;
  lightBank[1] = 0x0;
  expected = "---- ---- ---- ---- ---- ---- ---- ---- "      /* lightBank[0] */
             "---- ---- ---- ---- ---- ---- ---- ---- \n";   /* lightBank[1] */
  runTest( lightBank, expected, "Test: 0x0, 0x0" );

  /* Test 2 */
  lightBank[0] = 0x11111111;
  lightBank[1] = 0x88888888;
  expected = "---* ---* ---* ---* ---* ---* ---* ---* "
             "*--- *--- *--- *--- *--- *--- *--- *--- \n";
  runTest( lightBank, expected, "Test: 0x11111111, 0x88888888" );

  /* Test 3 */
  lightBank[0] = 0x89ABCDEF;
  lightBank[1] = 0x12345678;
  expected = "*--- *--* *-*- *-** **-- **-* ***- **** "
             "---* --*- --** -*-- -*-* -**- -*** *--- \n";
  runTest( lightBank, expected, "Test: 0x89ABCDEF, 0x12345678" );

  /* Test 4 */
  lightBank[0] = 0x0;
  lightBank[1] = 0xFFFFFFFF;
  expected = "---- ---- ---- ---- ---- ---- ---- ---- "
             "**** **** **** **** **** **** **** **** \n";
  runTest( lightBank, expected, "Test: 0x0, 0xF" );

}


/*
 * Function Name: runTest()
 * Function Prototype: void runTest( unsigned int bank[], char * expectedOutput,
                                     char * testDesc );
 * Description:  Helper function to actually run a test of displayLights.
 *               Prints test description (as specified by testDesc), and
 *               calls displayLights, handling segfaults.
 * Parameters:
 *     arg1: unsigned int bank[] -- bank of lights
 *     arg2: char * expectedOutput -- the expected output to be printed by
 *                                    displayLights()
 *     arg3: char * testDesc -- Description of the test being run
 * Side Effects: Outputs the result of the test to stdout
 * Error Conditions: None
 * Return Value: None
 */
void runTest( unsigned int bank[], char * expectedOutput, char * testDesc ) {
  char buf[BUFSIZ] = {0};

  /* 
   * Begin setup to capture stdout to a file.  You aren't expected to know how
   * to do this, but it never hurts to learn!
   */
  FILE * testFilePtr = fopen( testFileName, "w+" );
  if ( testFilePtr == NULL ) {
    perror( "Could not open test file" );
    exit( 1 );
  }

  if ( dup2( fileno( testFilePtr ), fileno( stdout ) ) == -1 ) {
    perror( "Could not duplicate stdout file descriptor" );
    exit( 1 );
  }
  /* End setup to capture stdout */

  /* Print test description */
  fprintf( stderr, "\n%s\n", testDesc );

  /* Display the lights and flush stdout */
  displayLights( bank );
  fflush( stdout );

  /* Reset file pointer */
  fseek( testFilePtr, 0, SEEK_SET );

  /* Read from test file and compare */
  fgets( buf, BUFSIZ, testFilePtr );

  TEST( strncmp( buf, expectedOutput, BUFSIZ ) == 0 );
  
  /* Close file when done */
  fclose( testFilePtr );
}


int main() {

  fprintf( stderr, "Running tests for displayLights...\n" );
  testdisplayLights();
  fprintf( stderr, "\nDone running tests!\n" );

  return 0;
}
