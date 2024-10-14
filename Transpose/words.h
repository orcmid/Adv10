/* words.h 0.0.3                      UTF-8                     dh:2024-10-14
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
 *
 *    The vocabulary is in English language and the words consist of ASCII
 *    characters.  Case is ignored. Wwrds longer than 5 letters are reduced
 *    to the first 5 letters in the database.  The words are stored in
 *    lower-case form, regardless of the case of the input and the case used
 *    for the words in game messages.
 */

typedef enum {      no_type,   // 0, and not a word type
                motion_type,   // a motion verb
                object_type,   // an object name
                action_type,   // an action verb
               message_type    // a word

               } wordtype;     // [fg:27.5]

/*      Each word in the vocabulary database has a wordtype specified in
        its database entry.

        no_type is defined in [fg:27.5] but not used.

        Advent exploits no_type values for determining when a slot in the
        vocabulary in empty.

        Adv10 returns a special no_type entry when the dictionary has no room
        for an additional entry.

        XXX: Exhausting the capacity of the dictionary is not supposed to
             happen.  The Advent code does not check for this condition.
        */

typedef struct {    unsigned char text[6];   // sz string of up to 5 letters
                    unsigned char word_type; // a single-byte wordtype value
                    unsigned char meaning;   // a single-bite meaning code

                    } wordentry;    // [fg:27.5]

/*      The meaning entry is one of the enumeration values associated with
        the given word_type.

        Advent uses the type name "hashentry" for this structure.  For Adv10,
        the term "wordentry" places focus on purpose above the API.

        Unsigned char types are used to avoid possible difficulties in the
        currently-unlikely case that any of the values exceeds 127.
        */

wordentry lookup(char *w);  // [fg:27.8] [Adv10]
       /* Find the vocabulary database wordentry for the given string.
          If there is no such wordentry, one with word_type no_type is
          returned.
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
           terms.  These provide for a kind of fast-travel to places of the
           game, once visited or learned.
           */

/*
   0.0.3  2024-10-14T16:37Z Touch-up, add motion entries typedef
   0.0.2  2024-10-13T21:36Z Introduce wordtype and wordentry typedefs
   0.0.1  2024-10-13T16:32Z Add synopsis
   0.0.0  2024-10-11T21:02Z Start the vocabulary database API.
   */

/*                        ***** end of words.h *****                      */
