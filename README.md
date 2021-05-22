```
README.md 0.0.2                  2021-05-21
```

# Adventure Version 1.0: The Original Colossal Cave Text Adventure

Adv10 provides a "Clean C" port of the Original Colossal Cave Text Adventure.
The initial objective is a command-line version that operates the same as the
original.

## Basic Clean C Port

The basic implementation (Adv10 1.0.0) is based on the Literate Programming
version provided by Donald E. Knuth in Chapter 27 of his book, "Selected
Papers on Fun & Games."

Knuth's source code has been downloaded and is being morphed into a new set
of files that are keyed back to the Literate Programming sections as part of
ensuring complete and accurate migration to Clean C.  There will be some
refactoring into separate files for convenience.

The replacement of the Literate Programming version with a Clean C source
code is aligned with open-source project practice.  That sacrifice is
motivated by the desire to reduce tooling dependencies, although there will
be nfoTools dependencies.  There are few prerequisites for someone to be able
to build Adv10 for themselves and not many more for being able to contribute
to the project.

Transposition of the source code is accomplished by spiraling, where the code
not only builds but is always executable, however incomplete the operation is.

## Provisions for Verification and Trouble-Shooting

One early enhancement does not alter the game.  It provides for testing that
the game is playable and that all of the available rooms are navigable.  It
also provides a way for someone to report difficulties and also trace the
play.  That might even serve as a crude way to do saves of the game, at least
for play testers.

## Further Developments

This the launchpad for updates the introduce internationalization and also
support accessibility.  There can be progressive versions that move to text
windows (CUA), GUI presentation and then use of animations and prospects for
touch controls.
