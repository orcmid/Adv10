/* adv10.c 0.0.7                      UTF-8                     dh:2024-11-07
 *
 *                           ADVENTURE VERSION 1.0
 *                           =====================
 *
 *                THE ORIGINAL COLLOSAL CAVE TEXT ADVENTURE
 *
 *    Copyright © 1998 by Don Woods and Don Knuth; all rights reserved.
 *    Adapted with permission.
 *
 *    Derived by Dennis E. Hamilton from the 2010-01-26 version of Don
 *    Knuth's Literate Programming source code file, advent.w.gz, available
 *    at <http://www-cs-faculty.stanford.edu/~knuth/programs.html#advent>.
 *    This version incorporates all applicable errata published through
 *    November 2013 for Knuth's "Selected Papers on Fun and Games,"
 *    <http://www-cs-faculty.stanford.edu/~knuth/fg.html>, identified as
 *    [fg] below.
 *
 *    WARNING AND APOLOGY: This code has been stripped away from the
 *    Literate Programming version.  If you want to understand the
 *    structure of this program and its behavior, I urge consultation
 *    of the literate (woven) version in a print ("final-form") version.
 *
 *    Whether or not a good idea, the purpose of this raw C version is to
 *    have a form, with embedded narration, that is closer to the style of
 *    contemporary C/C++ Language open-source development practice.  The
 *    idea is to use that as a spring-board toward modularization and
 *    mutation into a variety of modern application flavors, including
 *    web, desktop GUI and mobile/tablet applications.  Internationalization,
 *    accessibility, tracing, and preservation of game state will be
 *    interesting challenges.
 *
 *    The version having code the closest to adv10.c is in the third printing
 *    of [fg].  For other sources, history and variations on the original,
 *    consult <https://en.wikipedia.org/wiki/Colossal_Cave_Adventure>.
 *
 *    To provide some correspondence with the literate version for those who
 *    start by examining this code, the section numberss of [fg] Chapter 27
 *    are used to identify the place where a given code fragment appears
 *    in the literate form.  [Adv10] is used for places where modifications
 *    have been made as part of refactoring the code.
 */

/*   INTRODUCTION [fg:27.1]
     ======================
     This program presents the original 350-point Collosal Cave Adventure,
     as devised by Will Crowther and extended by Don Woods in 1977.  The
     FORTRAN version was converted to C Language and recast as a Literate
     Program (using CWEB) by Don Knuth and made available online in 1998.
     */

/*   THE PROGRAM [fg:27.2]
     =====================
     This program compiles to a single executable, adv10 (adv10.exe on
     Microsoft Windows).  When it is placed in a location where it can
     be operated by console command, just enter the name, 'adv10'.
        TO DO: Explain where instructions for compiling the program
               are found.
        TO DO: Explain where instructions for deployment and for
               operation of the program can also be found.
     */

#include <stdio.h>
     /* basic input/output routines: fgets, fputs, and printf via stdin and
        stdout */
     /* TODO: Use Unicode Input Output.
        TODO: Eliminate printf wherever possible and isolate input-output
              for internationalization and accessibility, at some point.
        */
#include <ctype.h>      /* isspace, tolower, and toupper routines */
#include <string.h>     /* strcmp and strcpy variations to compare and copy
                           strings, using safe string operations wherever
                           possible
                           */

#include <time.h>       /* current time, used as random number seed */
#include <stdlib.h>     /* exit */

#include <stdbool.h>    /* bool, true, false */

/*   MACROS FOR SUBROUTINE PROTOTYPES [fg:27.3]
     ------------------------------------------
     [Adv10] In the code, subroutines are declared first with Clean C
     prototypes.  We presume modern compilers and will be doing x64
     compilations. Compiling specifies C11 and the C Standard Library.

     There is no need to accomodate the K&R style of function declaration.
     */

/*   TYPE DEFINITIONS [fg: 27.2]
     ---------------------------
     [Adv10] Type definitions associated with particular aspects of the
     program are declared in *.h files on behalf of an API.  Others are
     confined to API-suppporting *.c modules.  There might not be any
     type definitions in this main program, Adv10.c.
     */

typedef enum{false, true} boolean;
     /* TODO: Use of bool is preferable.
        TODO: I intend to use <stdbool.h> and bool instead.  It will depend
              where and how often I see boolean used.
              */

/*   GLOBAL VARIABLES [fg:27.2 and .22]
     ---------------------------------
     [Adv10] We are moving groups of functions and their closely-held data
     into modules of *.h and corresponding *.c files.  Global variables
     are established in the *.c files and accessed via *.h-defined interfaces.

     There is no *.c use of register variables and "local registers" in Adv10.
     We introduce automatic variables as needed in the individual functions
     letting the compilers and linkers optimize.

     TODO: Reconcile the use of q and qq in the handling of instructions
           in [fg: 27.22].  I suspect that is going to be very tricky.
           */

/*   6. SUBROUTINES [fg: 27.6]
     -------------------------
     [Adv10] The vocabulary subroutines [fg: 27.4-27.17 and all of the
     initializations are moved into words.c.  A few of them are reachable
     via the words.h-defined API.
     */


/*   THE MAIN PROGRAM
     ----------------
     */

int main(void)
{ /* UNUSED - ONLY DECLARE (AND ANNOTATE) ONCE ACTUALLY USED
  register int j,k;
  register char *p;

        TODO: At some point, the main() function will have args
              and they will be used, at least for trouble-shooting
              and perhaps for important adjustments for users.
        TODO: Arrange for the program to identify itself so it is
              always known which version is being operated in
              terminal captures and logs.
              */

  /*  22. ADDITIONAL LOCAL REGISTERS */

  /*  ADV10: PROLOGUE (PLACE-HOLDER)*/

  fputs("\n[Adv10] 0.0.0 ORIGINAL COLLOSAL CAVE TEXT ADVENTURE\n\n", stdout);
  fputs("\n        MUCH DARKNESS\n\n", stdout);
      /* TODO: Put the initial "you are standing" message and want help?
               Message here.  Probably after initializations and the start
               of simulation.
               */

  /* 200. INITIALIZE ALL TABLES */

  /*  75. SIMULATE AN ADVENTURE, GOING TO QUIT WHEN FINISHED */

  /* 198. PRINT THE SCORE AND SAY ADIEU */
     /* TODO: Take on the implied challenge concerning the use
              of GOTO statements.  There should be other control
              patterns that work fine in this situation, though there
              might be a larger code footprint.
              */

  /* UNUSED LABEL.  UNCOMMENT ONCE IT IS USED.
  quit:
  */

  /* FINIS */
  exit(0);
  }



/* TODO:
     * I will need a version that I can "script" as part of testing for
       interactive behavior.  I need to have a replayable output as well.
     * Get this and the file I am gutting under source control so I have
       a chance of recovering from screw-ups.  Use git and a private
       project under Visual Studio online.  Or maybe use github.
     * Set up for command-line compilation so the program can be tested.
     * Since Windows users don't run console apps normally, use a .bat
       file to create a nice console window and run the progam within.
     * Create the nfoworks.com/giocchi structure.
   */



/*
   0.0.7 2024-11-07T16:28Z Tidying up based on current direction
   0.0.6 2016-12-08-09:42 Comment-suppress unused declarations and labels
         until they are used, keeping the /Wall compiles clean.
   0.0.5 2016-12-07-11:01 Minimum version for demonstration of test compiles.
   0.0.4 2016-10-08-12:50 Adjust the use of titles and add cross=references
         to the [fg:27] portions that tie to [fg] and advent.w.
   0.0.3 2016-10-04-08:38 Convert to semantic-versioning structure and
         start touching things up some more.  Put more motivation in
         here or somewhere.  Also, figure out where development is
         actually happening so I don't mess up version control.
   0.02 2014-02-05-21:46 Create null implementation
        Using the advent.w that reflects all errata through November 2013,
        extract an initial null program.  It does nothing but start and exit.
   0.01 2014-02-05-18:16 Determined that advent.w.gz is the best base file,
        with additional errata applied from Knuth's web page on [fg].  Named
        this project adv10 and provided a clean introduction describing the
        origin and inspiration for this one.
   0.00 2014-01-31-21:26 Start Stripping the code from the CWEB file.
        The main file starts with the explanatory prologue.
   */

/*                        ***** end of adv10.c *****                      */
