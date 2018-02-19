#
# Makefile template for CSE 30 -- PA2
# You should not need to change anything in this file.
#
# XXX DO NOT EDIT
#


HEADERS		= pa2.h pa2Strings.h
C_SRCS		= checkCmd.c clear.c checkPrompt.c
EXE_C_SRCS	= main.c $(C_SRCS)
ASM_SRCS	= displayLights.s set.s shift.s toggle.s rotate.s ripple.s \
		  printChar.s

C_OBJS		= $(C_SRCS:.c=.o)
EXE_C_OBJS	= $(EXE_C_SRCS:.c=.o)
ASM_OBJS	= $(ASM_SRCS:.s=.o)
OBJS		= $(C_OBJS) $(ASM_OBJS)
EXE_OBJS	= $(EXE_C_OBJS) $(ASM_OBJS)

EXE		= pa2
TEST_BINS	= testdisplayLights testcheckCmd testset testclear testtoggle \
		  testshift testrotate testripple


#
# Extra Credit Sources
#

HEADERS_EC	= pa2.h pa2Strings.h pa2EC.h
C_SRCS_EC	= mainEC.c jumbotronEC.c
ASM_SRCS_EC	= displayLightsEC.s

C_OBJS_EC	= $(C_SRCS_EC:.c=.o)
ASM_OBJS_EC	= $(ASM_SRCS_EC:.s=.o)
OBJS_EC		= $(C_OBJS_EC) $(ASM_OBJS_EC)

EXE_EC		= pa2EC



#
# Relevant man pages:
#
# man gcc
# man as
# man lint
#

GCC		= gcc
ASM		= $(GCC)
LINT		= lint

GCC_FLAGS	= -c -g -Wall -D__EXTENSIONS__ -std=c99
LINT_FLAGS1	= -c -err=warn
LINT_FLAGS2	= -u -err=warn
ASM_FLAGS	= -c -g
LD_FLAGS	= -g -Wall


#
# Standard rules
#

.s.o:
	@echo "Assembling each assembly source file separately ..."
	$(ASM) $(ASM_FLAGS) $<
	@echo ""

.c.o:
	@echo "Linting each C source file separately ..."
	$(LINT) $(LINT_FLAGS1) $<
	@echo ""
	@echo "Compiling each C source file separately ..."
	$(GCC) $(GCC_FLAGS) $<
	@echo ""

#
# Simply have our project target be a single default $(EXE) executable.
#

$(EXE):	$(EXE_OBJS)
	/bin/rm -f mainEC.o mainEC.ln test*.o test*.ln
	@echo "2nd phase lint on all C source files ..."
	$(LINT) $(LINT_FLAGS2) *.ln
	@echo ""
	@echo "Linking all object modules ..."
	$(GCC) -o $(EXE) $(LD_FLAGS) $(EXE_OBJS)
	@echo ""
	@echo "Done."

#
# Target to create EC program named $(EXE_EC)
#

$(EXE_EC):	$(OBJS_EC) $(OBJS)
	/bin/rm -f main.o main.ln test*.o test*.ln
	@echo "2nd phase lint on all C source files ..."
	$(LINT) $(LINT_FLAGS2) *.ln
	@echo ""
	@echo "Linking all object modules ..."
	$(GCC) -o $(EXE_EC) $(LD_FLAGS) $(OBJS_EC) $(OBJS)
	@echo ""
	@echo "Done."

$(C_OBJS):	$(HEADERS)

$(C_OBJS_EC):	$(HEADERS_EC)


clean:
	@echo "Cleaning up project directory ..."
	/usr/bin/rm -f *.o $(EXE) $(EXE_EC) *.ln core a.out $(TEST_BINS)
	@echo ""
	@echo "Clean."

new:
	make clean
	make

testdisplayLights: test.h pa2.h displayLights.o testdisplayLights.o printChar.o
	@echo "Compiling testdisplayLights.c"
	gcc -g -o testdisplayLights testdisplayLights.c displayLights.s \
	printChar.s
	@echo "Done."

testcheckCmd: test.h pa2.h checkCmd.o testcheckCmd.o
	@echo "Compiling testcheckCmd.c"
	gcc -g -o testcheckCmd testcheckCmd.c checkCmd.c
	@echo "Done."

testset: test.h pa2.h set.o testset.o
	@echo "Compiling testset.c"
	gcc -g -o testset testset.c set.s
	@echo "Done."

testclear: test.h pa2.h clear.o testclear.o
	@echo "Compiling testclear.c"
	gcc -g -o testclear testclear.c clear.c
	@echo "Done."

testtoggle: test.h pa2.h toggle.o testtoggle.o
	@echo "Compiling testtoggle.c"
	gcc -g -o testtoggle testtoggle.c toggle.s
	@echo "Done."

testshift: test.h pa2.h shift.o testshift.o
	@echo "Compiling testshift.c"
	gcc -g -o testshift testshift.c shift.s
	@echo "Done."

testrotate: test.h pa2.h rotate.o testrotate.o
	@echo "Compiling testrotate.c"
	gcc -g -o testrotate testrotate.c rotate.s
	@echo "Done."

testripple: test.h pa2.h ripple.o testripple.o rotate.o displayLights.o \
	printChar.o
	@echo "Compiling testripple.c ripple.s rotate.s displayLights.s \
	printChar.s"
	gcc -g -o testripple testripple.c ripple.s rotate.s displayLights.s \
	printChar.s
	@echo "Done."

