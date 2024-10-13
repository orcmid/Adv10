/* words.h 0.0.2                      UTF-8                     dh:2024-10-13
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
           Advent exploits no_type for determining when a slot in the
        vocabulary in empty.
           Adv10 also uses no_type when there is no room to add an entry
        and when a word is not in the vocabulary.
        */

typedef struct {    unsigned char text[6];   // sz string of up to 5 letters
                    unsigned char word_type; // a single-byte wordtype value
                    unsigned char meaning;   // a single-bite meaning code

                    } wordentry;    // [fg:27.5]

/*         The meaning value is one of the enumeration values associated with
        the given word_type.
           Advent uses the type name hashentry for this structure, saying
        more about the implementation than is needed for the API.
           For Adv10, the term wordentry is chosen to be more about purpose.
        Unsigned char types are used to avoid possible difficulties in the
        unlikely case that any of the values exceeds 127.
        */

/*
   0.0.2  2024-10-13T21:36Z Introduce wordtype and wordentry typedefs
   0.0.1  2024-10-13T16:32Z Add synopsis
   0.0.0  2024-10-11T21:02Z Start the vocabulary database API.
   */

/*                        ***** end of words.h *****                      */
