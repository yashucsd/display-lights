/*
 * Filename: testset.c
 * Author: Yash Nevatia
 * Description: Unit test program to test the function set().
 * Date: 8 February 2017
 * Sources of Help
 */ 

#include "test.h"    /* For TEST() macro and stdio.h */
#include "pa2.h"     /* For set() function prototype */


/*
 * Unit Test for set.s
 *
 * void set( unsigned int lightBank[], const unsigned int pattern0,
 *  const unsigned int pattern1 );
 * 
 * This function sets the lights in the lightBank based on which
 * bits are set in the bit patterns passed in. pattern0 represents
 * the bits that should be set in the first 32 lights, and pattern1
 * represents the bits that should be set in the second 32 lights.
 */
void testset() {
  unsigned int lightBank[2];
  unsigned int pattern0;
  unsigned int pattern1;

  (void) printf( "Testing set()\n" );

  /* Test One */
  lightBank[0] = 0xCAFEBABE;
  lightBank[1] = 0xDECAFBAD;
  pattern0 = 0;
  pattern1 = 0;

  set(lightBank, pattern0, pattern1);
  TEST( lightBank[0] == 0xCAFEBABE && lightBank[1] == 0xDECAFBAD );

  /* Test Two */
  lightBank[0] = 0x0;
  lightBank[1] = 0x0;
  pattern0 = 0x11111111;
  pattern1 = 0;

  set(lightBank, pattern0, pattern1);
  TEST( lightBank[0] == 0x11111111 && lightBank[1] == 0x0000000 );

  /* Test Two */
  lightBank[0] = 0x00100001;
  lightBank[1] = 0x1F00F001;
  pattern0 = 0x420C5E30;
  pattern1 = 0xF001F008;

  set(lightBank, pattern0, pattern1);
  TEST( lightBank[0] == 0x421C5E31 && lightBank[1] == 0xFF01F009 );

  printf( "Finished running tests on shift()\n" );
}


int main() {
  testset();

  return 0;
}
