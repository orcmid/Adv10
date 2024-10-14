/* words.c 0.0.1                      UTF-8                     dh:2024-10-14
 *
 *                           ADVENTURE VERSION 1.0
 *                           =====================
 *
 *                THE ORIGINAL COLLOSAL CAVE TEXT ADVENTURE
 *
 *                         VOCABULARY DATABASE MODULE
 *                         --------------------------
 *
 *    Copyright © 1998 by Don Woods and Don Knuth; all rights reserved.
 *    Adapted with permission.
 *
 *    Derived by Dennis E. Hamilton from the 2010-01-26 version of Don
 *    Knuth's Literate Programming source code file, advent.w.gz, available
 *    at <http://www-cs-faculty.stanford.edu/~knuth/programs.html#advent>.
 *    This version incorporates all applicable errata published through
 *    January 2022-04-21 for Knuth's "Selected Papers on Fun and Games,"
 *    <http://www-cs-faculty.stanford.edu/~knuth/fg.html>, identified as
 *    [fg] below.
 */

#include "words.h"

#define hash_prime 1009
         // [fg:27.6 Size of the words table, a prime that is big enough
         // and good enough to minimize hash collisions.
         //   The success in avoiding collisions will be verified as the
         // database is populated.
         // XXX: The value must fit in an int.

wordentry noword = { {0, 0, 0, 0, 0, 0}, no_type, 0 };
         // [Adv10] A wordentry that is used to indicate that a word is not
         //         in the vocabulary.  It is also used to indicate that a
         //         slot in the vocabulary database is empty.

wordentry words[hash_prime];
         // [fg:27.7] The vocabulary database.  It is pre-initialized to all
         //           noword entries by the default initialization of
         //           static arrays and structures.
         //           XXX: This depends on noword being 8 byes of 0 and this
         //                static array being initialized to bytes of 0.


int lookup(char * w )

{
  register int h; register char *p; register char t;
  t=w[5]; w[5]='\0'; /* truncate the word */
  for (h=0,p=w;*p;p++) h=*p+h+h;
  h%=hash_prime; /* compute starting address */
  w[5]=t; /* restore original word */
  if (h<0) return -1; /* a negative character might screw us up */
  while (hash_table[h].word_type) {
    if (streq(w,hash_table[h].text)) return h;
    h++;@+if (h==hash_prime) h=0;
  }
  return -1;
}

wordtype current_type = no_type;
         // [fg:27.7] Used for the type of entries being added in a series
         //           of calls to new_word.

void new_word(  char *w,  /* text[ ] value to be set,
                             a string of length 5 or less */
                int m     /* its "meaning" value */
                )

   {  /* [fg: 27.6] Create a vocabulary entry with the specified-word text[]
         and meaning.  The wordtype used is the value set in current_type.
         */

      register int h,k; register char *p;

      for (h=0,p=w;*p;p++)
           h=*p+h+h;

      h%=hash_prime;

      while (words[h].word_type)
            {  h++;
               if (h==hash_prime) h=0;
               }

       strcpy(words[h].text,w);
       words[h].word_type = current_type;
       hash_table[h].meaning = m;

       /* XXX: This code assumes that words[] will always have room.
               */
       /* TODO: I would like for full words to be allowed, with them
                truncated to 5 lower-case characters and have the lookup
                provide that transformation and re-use that part here,
                maybe even checking for a word already present.
                */
       /* TODO: Instrument this to let us know how many collisions happen
                before finding a slot. This will also detect a full
                dictionary.
                */

       } /* new_word */


/*
   0.0.1  2024-10-14T19:50Z Backup before some cleanups
   0.0.0  2024-10-11T20:36Z Start the vocabulary database module.
   */

/*                        ***** end of words.c *****                      */
