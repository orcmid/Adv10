/* words.c 0.0.6                      UTF-8                     dh:2024-10-16
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

#include <ctype.h>  /* for tolower */

#include <string.h> /* for strncpy */

#include "words.h"

#define hash_prime 1009
      /* [fg:27.6] Size of the words table, a prime that is big enough
         and good enough to minimize hash collisions.

         Success in avoiding collisions will be verified as the
         database is populated.

         XXX: The value must fit in an int used as an index over words[].
         */

const wordentry noword = { "\0", no_type, 0 };
      /* [Adv10] A wordentry that is used to indicate that a word is not
         in the vocabulary.  It is also used to indicate that a
         slot in the vocabulary database is empty.
         */

wordentry words[hash_prime];
      /* [fg:27.7] The vocabulary database.  It is pre-initialized to all
         noword entries by the default initialization of
         static arrays and structures.

         XXX: This depends on the words[] wordentry values being initialized
              to bytes of 0.
        */

static wordentry word_prep(  char *w /* a string of characters to prep */
                             )

   {  /* [Adv10] Construct a no_type wordentry with the text[] value
         being the w[] string transformed to not more than max_word_length
         lower-case characters.

         What we are doing here is encapsulating the way that words are
         transformed into the form used for hashing and comparison.

         Using word_prep here in words.c relieves the parsing of input from
         implementing a vocabulary database constraint.  It also allows for
         future changes to the way that words are prepared without
         affecting the rest of the program.
         */

      wordentry model = noword;

      strncpy(model.text, w, max_word_length);

      int i = 0;
      do model.text[i] = tolower(model.text[i]);
         while ( model.text[++i] );

      return model;

      } /* word_prep */


static unsigned int word_hash(  unsigned char *w
                                /* a string of characters to hash */
                                )

   {  /* [Adv10] Compute a hash value from the w[] string of characters.
         This common calculation is factored out of [fg: 27.6, 28.8] to
         ensure consistency in the hash calculation.
         */

      unsigned int h = 0;
      while (*w)
            h = *w++ + h + h;

      return h % hash_prime;

      } /* word_hash */


wordentry lookup(  char *w /* a string of characters to look up */
             )

   {  /* [fg:27.8] Look up the word in the vocabulary database and return the
         entry if found.  If not found, return a no_type wordentry form.
         */

      wordentry pending = word_prep(w);

      unsigned int h = word_hash(pending.text);
           /* where we start looking in words[] */

      while (words[h].word_type)
            {  if (!strcmp(pending.text,words[h].text))
                    return words[h];
               if (++h == hash_prime) h = 0;
               }

      return pending;
            /* it will have the not-found text[] although the original,
               argument to word_prep might work better */

      /* TODO: 4. The message(s) about this need to be supplied in words.c
                  if that makes any sense.
         */

      } /* lookup */


long word_count = 0;
         /* [Adv10] counting the number of words inserted in the dictionary.*/

long word_collisions = 0;
         /* [Adv10] counting the number of collisions before insertions */

wordtype current_type = no_type;
         /* [fg:27.7] Used for the wordtype of entries being added in a series
            of calls to new_word.  See the load vocabulary functions below.
            */

static void new_word(  char *w,  /* string that the wordentry.text[ ] will be
                                    be prepared from */
                        int m    /* its "meaning" value */
                )

   {  /* [fg: 27.6] Create a vocabulary entry with the specified-word text[]
         and meaning.  The wordtype in the entry is set from current_type.

         XXX: [Adv10] If the database is full, no entry will be added.
         TODO: We could return a status that indicates the word could not
               be added.  We probably wouldn't check it until adding the
               last word is attempted.
         */

      wordentry pending = word_prep(w);

      unsigned int h = word_hash(pending.text);
           /* where we start looking to put this in the database,
              the same place where lookup will start searching. */

      /* Find the first empty slot at or beyond the hash determined index */

      if ( !(word_count < hash_prime) ) return;
           /* ensuring at least one empty slot so searches always end */
           /* XXX: This is where we could return the no_type pending */

      while (words[h].word_type)
            {  ++h; ++word_collisions;
               if (h==hash_prime) h=0;
               }

      pending.word_type = current_type;
      pending.meaning = m;

      words[h] = pending;

      ++word_count;

      } /* new_word */


/*
   0.0.6  2024-10-16T16:45Z Smooth, protect and count insertions/collisions
   0.0.5  2024-10-15T23:39Z Adjust to 0.0.4 words.h
   0.0.4  2024-10-14T23:23Z Add shared word_hash function
   0.0.3  2024-10-14T22:49Z Complete lookup and new_word functions
   0.0.2  2024-10-14T20:25Z Touch up the comments and add some TODOs
   0.0.1  2024-10-14T19:50Z Backup before some cleanups
   0.0.0  2024-10-11T20:36Z Start the vocabulary database module.
   */

/*                        ***** end of words.c *****                      */
