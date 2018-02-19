/*
 * Filename: main.c
 * Author: Yash Nevatia
 * Description: A program that can set, clear, toggle, shift, rotate, and ripple
 *              UCSD's Theatre and Dance Department's bank of lights
 * Date: 14 February 2017
 * Sources of Help      
 */

/* 
 * Header files included here.
 * Std C Lib header files first, then local headers.
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

/* Standard C Library headers use angle brackets < > */
#include "pa2.h"
#include "pa2Strings.h"

/*
 * Function name: main()
 * Function prototype: int main( int argc, char *argv[] );
 * Description: TODO
 * Parameters:
 *      arg 1: filename -- the name of a file to read from
 * Side Effects: None
 * Error Conditions: too many arguments, or the file doesn't exist 
 * Return Value: EXIT_SUCCESS if there are no errors, otherwise EXIT_FAILURE
 */

int main( int argc, char *argv[] ) {
    unsigned int lightBank[2];
    lightBank[0] = 0x0;
    lightBank[1] = 0x0;
    const char * const commands[] = { COMMANDS, NULL };
    
    FILE * inFile = stdin;
    char buf[BUFSIZ] = { 0 };
    short prompt = TRUE;
    
    (void) setvbuf( stdout, NULL, _IONBF, 0 );

    argc--;
    
    if(argc > MAX_ARGS){
        fprintf(stderr, STR_USAGE_MSG, argv[0]);
        return EXIT_FAILURE;
    }

    if(argv[1]){ // there is a file name
        inFile = fopen (argv[1], "r");
        prompt = FALSE;
        if (!inFile){ // the file doesn't exist
            char buffer [BUFSIZ];
            snprintf(buffer, BUFSIZ, argv[1]);
            perror(buffer); // prints error
            return EXIT_FAILURE;
        }
    } else // there is no file name, check prompt
        prompt = checkPrompt();
    
    displayLights(lightBank);
    
    for(DISPLAY_PROMPT; fgets(buf, BUFSIZ, inFile) != NULL; DISPLAY_PROMPT) {
        
        char * cmd = strtok(buf, TOKEN_SEPARATORS);
        
        if(!cmd) continue; // no tokens found, reprompt
        
        if(checkCmd(cmd, commands) < 0){ // command is not found
            fprintf(stderr, STR_BAD_CMD);
            continue;
        }
        
        if(strcmp(cmd, HELP_CMD) == 0){ // help is entered
            fprintf(stderr, "%s\n", STR_HELP_MSG);
            continue;
        }

        if(strcmp(cmd, QUIT_CMD) == 0) // quit is entered
            break;

        char * arg1 = strtok(NULL, TOKEN_SEPARATORS);
        
        if(!arg1){
            fprintf(stderr, STR_ARGS_REQ);
            continue;
        }

        char * endptr;
        errno = 0;

        unsigned int argone = strtoul(arg1, &endptr, BASE);

        if(*endptr) { // this isn't just a number
            fprintf(stderr, STR_STRTOLONG_NOTINT, arg1);
            continue;
        }

        if(errno != 0){
            char buffer [BUFSIZ]; //sets buffer for snprintf
            snprintf(buffer, BUFSIZ, STR_STRTOLONG_CONVERTING, arg1, BASE);
            perror(buffer); // prints error
            continue;
        }

        char * arg2;
        unsigned int argtwo;

        if(strcmp(cmd, SET_CMD) == 0 || strcmp(cmd, CLEAR_CMD) == 0 || 
            strcmp(cmd, TOGGLE_CMD) == 0){ // command requires second argument

            arg2 = strtok(NULL, TOKEN_SEPARATORS);

            if(!arg2){
                fprintf(stderr, STR_TWO_ARGS_REQ);
                continue;
            }
            
            endptr = NULL;
            errno = 0;
            
            argtwo = strtoul(arg2, &endptr, BASE);

            if(*endptr) { // this isn't just a number
                fprintf(stderr, STR_STRTOLONG_NOTINT, arg2);
                continue;
            }

            if(errno != 0){
                char buffer [BUFSIZ]; //sets buffer for snprintf
                snprintf(buffer, BUFSIZ, STR_STRTOLONG_CONVERTING, arg2, BASE);
                perror(buffer); // prints error
                continue;
            }
        }

        char * extra = strtok(NULL, TOKEN_SEPARATORS);

        if(extra){
            fprintf(stderr, STR_EXTRA_ARG, extra);
            continue;
        }

        switch(checkCmd(cmd, commands)) { // execute command
            case 0 : 
                set(lightBank, argone, argtwo);
                break;

            case 1 : 
                clear(lightBank, argone, argtwo);
                break;

            case 2 : 
                toggle(lightBank, argone, argtwo);
                break;

            case 3 : 
                shift(lightBank, argone);
                break;
        
            case 4 :
                rotate(lightBank, argone);
                break;

            case 5 :
                ripple(lightBank, argone);
                break;

            default: 
                continue;
        }
        displayLights(lightBank);
    }

    return EXIT_SUCCESS;
}
