/*
 * Filename: checkCmd.c
 * Author: Yash Nevatia
 * Description: This function checks to see if the cmdString is in the commands
 *              array
 * Date: 8 February 2017
 * Sources of Help
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Function name: checkCmd()
 * Function prototype:  int checkCmd( const char * const cmdString,
 *                      const char * const commands[] );
 * Description: This function checks to see if the cmdString is in the commands
 *              array (you will want to use strncmp()). Make sure to have
 *              appropriate null checks for the pointers passed in. If either
 *              pointers are null, return -1.
 * Parameters:
 *  arg 1: cmdString -- the string being searched for
 *  arg 2: commands[] -- the array being searched
 * Side Effects:
 * Error Conditions:
 * Return Value:    If cmdString is found, return the index of cmdString in the
 *                  commands array. Otherwise, return -1 to indicate cmdString
 *                  was not in the commands array.
 */

int checkCmd( const char * const cmdString, const char * const commands[] ){
   
    if(!cmdString || !commands) 
    	return -1; // value is null
   
    int x = 0;

    while(commands[x] != '\0'){ //check each element in commands
        if(strcmp(commands[x], cmdString) == 0)
            return x; // strings are same, return index
        x++;
    }
    
    return -1; // string not found
}
