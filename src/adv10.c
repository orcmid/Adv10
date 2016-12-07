/* adv10.c 0.0.5                      UTF-8                     dh:2016-12-07
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
 *    of [fg].  For other sources as well as variations on the original,
 *    consult <http://nfoWare.com/giocchi/cavern/adv>.
 *
 *    To provide some correspondence with the literate version for those who
 *    start by examining this code, the section numberss of [fg] Chapter 27
 *    are used to identify the place where a given code fragment appears
 *    in the literate form.
 */

/*   INTRODUCTION [fg:27.1]
     ======================
     This program presents the original 350-point Collosal Cave Adventure,
     as devised by Will Crowther and extended by Don Woods in 1977.  The
     FORTRAN version was converted to C Language and recast as a Literate
     Program (using CWEB) by Don Knuth and made available online in 1998.
       TODO:
         * Say more about organization and connection to the WEB version.
         * Explain the identification of sections and cross-references.
         * Include abbreviated connection with [fg:27.1] text.
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
     /* basic input/output routines: fgets, fputs, printf 
        and everything is stdin and stdout */
     /* TODO: Use Unicode Input Output.
        TODO: Eliminate printf wherever possible and isolate input-output
              for internationalization, and accessibility, at some point.
        */
#include <ctype.h>      /* isspace, tolower, and toupper routines */
#include <string.h>     /* strncmp and strcpy to compare and copy strings */
     /* TODO: Use safe string operations wherever possible.
        */
#include <time.h>       /* current time, used as random number seed */
#include <stdlib.h>     /* exit */

/*   MACROS FOR SUBROUTINE PROTOTYPES [fg:27.3]
     ==========================================
     In the code, subroutines are declared first with a prototype,
     and then with an old-style C function definition.  This is used
     to compile properly with STD C compilers and with older compilers.
     */

#ifdef __STDC__
#define ARGS(list) list
#else
#define ARGS(list) ()
#endif

     /* TODO: We will only use STD C and there will always be prototypes.
              It is desirable to remove the above definitions altogether.
              There can still be prototypes up front to allow for
              forward referencing issues and to maintain strong typing.
              */


     /* @^prototypes for functions@>
        XXX: I am not clear why this is present in the web file ahead of
             the conditional ARGS() definition.  It remains to be seen
             what's up and whether this is a gathering point.  I may
             have simply misplaced it in my initial transpositions.
        */


/*   5. TYPE DEFINITIONS
     -------------------
     */

typedef enum{false, true} boolean;
     /* TODO: This may be built-in.  Have to resolve it.  If not, boolean
              is a pre-reserved word in STD C.
              */

/*   7. GLOBAL VARIABLES
     -------------------
     */

/*   6. SUBROUTINES
     --------------
     */


/*   THE MAIN PROGRAM
     ----------------
     */

int main(void)
{
  register int j,k;
  register char *p;
     /* TODO: The optimization of registers is best left to
              optimizers these days.
        TODO: See if these locally-global dependencies are
              necessary.
        TODO: At some point, the main() function will have args
              and they will be used, at least for trouble-shooting
              and perhaps for important adjustments for users.
        TODO: Arrange for the program to identify itself so it is
              always known which version is being operated in
              terminal captures and logs.
        */

  /*  22. ADDITIONAL LOCAL REGISTERS */
  
  /*  ADV10: PROLOGUE */
  
  fputs("\n[Adv10] 0.0.0 ORIGINAL COLLOSAL CAVE TEXT ADVENTURE\n\n", stdout);
  fputs("\n        MUCH DARKNESS\n\n", stdout);

  /* 200. INITIALIZE ALL TABLES */

  /*  75. SIMULATE AN ADVENTURE, GOING TO QUIT WHEN FINISHED */

  /* 198. PRINT THE SCORE AND SAY ADIEU */
     /* TODO: Take on the implied challenge concerning the use
              of GOTO statements.  There should be other control
              patterns that work fine in this situation, though there
              might be a larger code footprint.
        */
  quit:

  /* FINIS */
  exit(0);
  }









/* TODO:
     * Make the corrected advent.w base and also provide diffs between that
       and advent.w base and also adventure.w in case those are ever
       required.
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



/* 0.0.5 2016-12-07-11:01 Minimum version for demonstration of test compiles.
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
