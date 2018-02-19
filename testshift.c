/*
 * Filename: testshift.c
 * Author: Yash Nevatia
 * Description: Unit test program to test the function shift().
 * Date: 8 February 2017
 * Sources of Help
*/
  
#include "test.h"    /* For TEST() macro and stdio.h */
#include "pa2.h"     /* For shift() function prototype */

/*
 * Unit Test for shift.s
 *
 * void shift( unsigned int lightBank[], const int shiftCnt );
 * 
 * Shifts the current light pattern in the lightBank by shiftCnt places.
 * If shiftCnt is positive, shift left.  If shiftCnt is negative, shift right.
 */
void testshift() {
  unsigned int lightBank[2];
  int shiftCnt;

  (void) printf( "Testing shift()\n" );


  /* Shift left by 1 bit */
  lightBank[0] = 0xCAFEBABE;
  lightBank[1] = 0xDECAFBAD;
  shiftCnt = 1;
 
  shift( lightBank, shiftCnt );
  TEST( lightBank[0] == 0x95FD757D && lightBank[1] == 0xBD95F75A );


  /* Shift right by 1 bit */
  lightBank[0] = 0xCAFEBABE;
  lightBank[1] = 0xDECAFBAD;
  shiftCnt = -1;

  shift( lightBank, shiftCnt );
  TEST( lightBank[0] == 0x657F5D5F && lightBank[1] == 0x6F657DD6 );

  /* Shift right by 13 bit */
  lightBank[0] = 0xCAFEBABE;
  lightBank[1] = 0xDECAFBAD;
  shiftCnt = -13;

  shift( lightBank, shiftCnt );
  TEST( lightBank[0] == 0x000657F5 && lightBank[1] == 0xD5F6F657 );

  /* Shift left by 28 bit */
  lightBank[0] = 0xCAFEBABE;
  lightBank[1] = 0xDECAFBAD;
  shiftCnt = 28;

  shift( lightBank, shiftCnt );
  TEST( lightBank[0] == 0xEDECAFBA && lightBank[1] == 0xD0000000 );

  /* Shift by 0 bits */
  lightBank[0] = 0xCAFEBABE;
  lightBank[1] = 0xDECAFBAD;
  shiftCnt = 0;

  shift( lightBank, shiftCnt );
  TEST( lightBank[0] == 0xCAFEBABE && lightBank[1] == 0xDECAFBAD );

  /* Shift right by 32 bits */
  lightBank[0] = 0xCAFEBABE;
  lightBank[1] = 0xDECAFBAD;
  shiftCnt = -32;

  shift( lightBank, shiftCnt );
  TEST( lightBank[0] == 0x00000000 && lightBank[1] == 0xCAFEBABE );

  /* Shift left by 40 bits */
  lightBank[0] = 0xCAFEBABE;
  lightBank[1] = 0xDECAFBAD;
  shiftCnt = 40;

  shift( lightBank, shiftCnt );
  TEST( lightBank[0] == 0xCAFBAD00 && lightBank[1] == 0x00000000 );


  printf( "Finished running tests on shift()\n" );
}


int main() {
  testshift();

  return 0;
}
