/*
 * File: pa2.h
 * Description: Header file that contains function prototypes and
 *              constants.
 *
 * XXX Only add constants to this file at the bottom.
 * DO NOT EDIT FUNCTION PROTOTYPES OR PREDEFINED CONSTANTS
 *
 */
#ifndef PA2_H   /* Macro Guard */
#define PA2_H

/* Function provided to you */
short checkPrompt();

/* Local function prototypes for PA2 written in C */
int checkCmd( const char * const cmdString, const char * const commands[] );
void clear( unsigned int lightBank[], const unsigned int pattern0,
            const unsigned int pattern1 );

/* Local function prototypes for PA2 written in Assembly */
void displayLights( const unsigned int lightBank[] );
void set( unsigned int lightBank[], const unsigned int pattern0,
          const unsigned int pattern1 );
void toggle( unsigned int lightBank[], const unsigned int pattern0,
             const unsigned int pattern1 );
void shift( unsigned int lightBank[], const int shiftCnt );
void rotate( unsigned int lightBank[], const int rotateCnt );
void ripple( unsigned int lightBank[], const int rippleCnt );

/*
 * void printChar( char ch );
 *
 * Only called from an Assembly routine. Not called from any C routine.
 * Would get a lint message about function declared but not used.
 */


/*
 * Constants and strings defined for matching valid commands
 * Constants are indices of the commands in the command array
 */
#define SET         0
#define CLEAR       1
#define TOGGLE      2
#define SHIFT       3
#define ROTATE      4
#define RIPPLE      5
#define HELP        6
#define QUIT        7

#define SET_CMD     "set"
#define CLEAR_CMD   "clear"
#define TOGGLE_CMD  "toggle"
#define SHIFT_CMD   "shift"
#define ROTATE_CMD  "rotate"
#define RIPPLE_CMD  "ripple"
#define HELP_CMD    "help"
#define QUIT_CMD    "quit"

/*
 * Map the commands strings to indexes for easy association when parsing
 * the commands string to the command.
 */
#define COMMANDS SET_CMD, CLEAR_CMD, TOGGLE_CMD, SHIFT_CMD, ROTATE_CMD, \
             RIPPLE_CMD, HELP_CMD, QUIT_CMD


/* Define constants for ease of readibility. */
#define FALSE 0
#define TRUE 1


/*
 * The prompt to display if we are reading commands interactively from
 * the user vs. reading commands from a file.
 */
#define PROMPT "> "


/*
 * Macro that determines if the prompt should be printed.
 * We do this to make it convenient to determine whether to display
 * a prompt or not depending on whether we are reading from stdin or
 * a file.
 */
#define DISPLAY_PROMPT ( (prompt != FALSE) ? (void) printf( PROMPT ) : (void)0 )


/*
 * Token string for strtok.
 * Allows tokenizing using arbitrary number of whitespaces between tokens.
 */
#define TOKEN_SEPARATORS " \t\n"


/*
 * Number of banks with 32 lights in each bank.
 */
#define NUM_OF_BANKS 2


/* Maximum number of args expected at command line. Doesn't include prog name */
#define MAX_ARGS 1


/* TODO Add any constants that you wish below this line. DONT EDIT ABOVE THIS */

/*The base of the arguments converted from string to long is 16*/
#define BASE 0

#endif /* PA2_H */
