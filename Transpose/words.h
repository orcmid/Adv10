/* words.h 0.0.4                      UTF-8                     dh:2024-10-15
 *
 *                           ADVENTURE VERSION 1.0
 *                           =====================
 *
 *                THE ORIGINAL COLLOSAL CAVE TEXT ADVENTURE
 *
 *                          VOCABULARY DATABASE API
 *                          -----------------------
 *
 *    Copyright © 1998 by Don Woods and Don Knuth; all rights reserved.
 *    Adapted by Dennis E. Hamilton with permission.
 *
 *    The Vocabulary Database contains forms of all of the words that are
 *    recognized by the Adventure program.  In the current version, the
 *    words are fixed and the vocabulary is not extensible.
 */

#define word_lingo "English"
        /* [Adv10] The language of the words in the vocabulary database.
           XXX: This is not so simple when internationalization is considered.
           The definition is exposed for use in any explanatory messages
           about the vocabulary.
           */

#define word_code "ASCII"
        /* [Adv10] The character encoding of the words in the vocabulary
           database.  The definition is exposed for use in any messages that
           refer to the wordprep() behavior in words.c.
           XXX: This is probably not needed, being a technical matter.  There
                might need to be a better way to specify that, if at all.
           XXX: We also need to have a way to drop control characters,
                perhaps in the keyboard entry function.
           */

#define word_case "lower"
        /* [Adv10] The case of the words in the vocabulary database.
           The definition is exposed for use in any messages that refer to
           the wordprep() behavior in words.c.
           XXX: This might not matter.  The player just needs to know that
                the case of letters does not matter.
           */

#define max_word_length 5
       /* [Adv10] The maximum number of characters in a word in the
          vocabulary database.  Longer words are truncated to this length.
          The definition is exposed for use in any messages that refer to
          the wordprep() behavior in words.c.
          XXX: This does not take into consideration multi-byte characters
               and the possibility of UTF-8 encoded code-points.
          */

typedef enum {      no_type,   // 0, and not a word type
                motion_type,   // a motion verb
                object_type,   // an object name
                action_type,   // an action verb
               message_type    // a word

               } wordtype;     // [fg:27.5]

/*      Each word in the vocabulary database has a wordtype specified in
        its database entry.

        no_type is defined in [fg:27.5] but not explicitly used.

        Advent exploits no_type wordtype values for determining when a slot
        in the vocabulary is empty.

        TODO: We need to determine what message_type is about and tie to its
              explanation here.
        */


typedef struct {    unsigned char text[max_word_length+1];
                                  // sz string of up to max_word_length chars
                    unsigned char word_type;
                                  // a single-byte wordtype value
                    unsigned char meaning;
                                  // a single-byte "meaning" code
                    } wordentry;  // [fg:27.5][Adv10]

/*      The meaning entry is one of the enumeration values associated with
        terms of the given word_type [fg: 27.9, .11, .13, .16].

        Advent uses the type name "hashentry" for this structure.  For Adv10,
        the term "wordentry" places focus on purpose at the API level.

        Unsigned char types are used to avoid possible difficulties in the
        currently-unlikely case that any of the values exceeds 127.

        XXX: Exhausting the capacity of the dictionary is not supposed to
             happen.  Adv10 lookup detects this condition and returns
             an entry having no_type word_type */
        */

wordentry lookup(char *w);  // [fg:27.8] [Adv10]
       /* Find the vocabulary database wordentry for the given string.
          If there is no such wordentry, one with word_type no_type is
          returned.

          The string, w[], must be null-terminated. It will be adjusted to the
          dictionary form as part of lookup.  The returned wordentry will have
          the dictionary-form text[] value.
          */


/* MOTION_TYPE TERMS */

typedef enum { N, S, E, W, NE, SE, NW, SW, U, D, L, R, IN, OUT, FORWARD, BACK,
               OVER, ACROSS, UPSTREAM, DOWNSTREAM, ENTER, CRAWL, JUMP, CLIMB,
               LOOK, CROSS, ROAD, WOODS, VALLEY, HOUSE, GULLY, STREAM,
               DEPRESSION, ENTRANCE, CAVE, ROCK, SLAB, BED, PASSAGE, CAVERN,
               CANYON, AWKWARD, SECRET, BEDQUILT, RESERVOIR, GIANT, ORIENTAL,
               SHELL, BARREN, BROKEN, DEBRIS, VIEW, FORK, PIT, SLIT, CRACK,
               DOME, HOLE, WALL, HALL, ROOM, FLOOR, STAIRS, STEPS, COBBLES,
               SURFACE, DARK, LOW, OUTDOORS, Y2, XYZZY, PLUGH, PLOVER, OFFICE,
               NOWHERE

               } motion;    // [fg:27.9]

/*         For a wordentry with word_type motion_type, the meaning entry will
           be one of these term values.

           Note that there are both directions and places among the motion
           terms.  Some provide for a kind of fast-travel to places of the
           game, once visited or learned.
           */

/*
   0.0.4  2024-10-15T23:19Z Adjust, with further #define values
   0.0.3  2024-10-14T16:37Z Touch-up, add motion entries typedef
   0.0.2  2024-10-13T21:36Z Introduce wordtype and wordentry typedefs
   0.0.1  2024-10-13T16:32Z Add synopsis
   0.0.0  2024-10-11T21:02Z Start the vocabulary database API.
   */

/*                        ***** end of words.h *****                      */
