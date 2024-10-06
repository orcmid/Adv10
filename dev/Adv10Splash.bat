@echo off
REM Adv10Splash.bat 0.0.2           UTF-8                         2024-10-06
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem                      SIMPLE SPLASH DEMO FOR ADV10
rem
rem    This batch file presents a simple splash screen and indented prompt
rem    simulating the initial text from the original Colossal Cave Adventure.

ECHO:[Adv10] 0.0.0 ORIGINAL COLLOSAL CAVE TEXT ADVENTURE
ECHO:
ECHO:        You are standing at the end of a road before a small brick
ECHO:        building.  Around you is a forest.  A small stream flows out
ECHO:        of the building and down a gully.
ECHO:
ECHO:        Welcome to Adventure!!  Would you like instructions?
PROMPT $E[30m$S$S$S$S$S$S$G$S
rem    This places the Adv10 prompt indented under the splash screen "[Adv10]"
rem    NOTE: The $E0m needs to be at the start of messages to reset to default
rem    And the game does this a little differently.  Maybe we need a bold
rem    black for the users responses.
rem
rem |----1----|----2----|----3----|----4----|----5----|----6----|----7----|--*
rem
rem 0.0.2  2024-10-06T20:21Z Leave the black setting for user's response.
rem 0.0.1  2024-10-06T18:16Z Remove " after "instructions?""
rem 0.0.0  2024-10-05T18:56Z Fork of Adv10Prompt.bat 0.0.0
rem
rem                    *** end of Adv10Splash.bat ***
