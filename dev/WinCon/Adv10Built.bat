@echo off
rem Adv10Built.bat 0.0.1              UTF-8                        2016-12-11
rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                    ENSURE ADV10 BUILT FROM SOURCE
rem                    ==============================

rem      This script is part of the Adv10 WinCon Construction Set for 
rem      ensuring that a successful build has occured.  If Adv10Build has
rem      not previously succeeded, it will be attempted automatically.

rem      The main work of this script is to confirm that Adv10Build\ is nearby
rem      and then use Adv10Build\Adv10Build.bat to determine whether a build
rem      is available or one needs to be attempted.

rem      See :USAGE for optional parameters and compatibility requirements.

rem      IMPORTANT NOTE: This version of Adv10Built.bat is as a prototype
rem      for experimental confirmation as part of the Adv10 project.  In
rem      the future, this script will be produced by customization of a
rem      WinCon Construction Kit provided by the nfoTools project.  For
rem      further information, see <http://nfoWare.com/dev/2016/11/d161103.htm>
rem      and <https://github.com/orcmid/nfoTools>devKits/WinDev/WinConKit.

REM IDENTIFY THE PROGRAM BUILT BY THIS CONSTRUCTION SET
SET WinCon=Adv10

REM * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
REM DO NOT CUSTOMIZE THE SCRIPT BODY FURTHER BELOW HERE.  
REM    1. Maintain the top-level file name, version, and last-change date
REM    2. Maintain the version progression at the end if desired.
REM    3. Put the top-level file name in the final remark.

rem The Construction Kit Version 
SET WinConBuiltVer=0.0.0
rem     semantic versioning candidate

rem SELECT SPLICED, TERSE, OR DEFAULT VERBOSE
rem     %1 value "+" selects smooth non-stop operation for splicing output
rem        into that of a calling script such as WinConRun or equivalent.
rem     %2 might then be "*" for terse operation and allow for that.
rem 
SET WinConTersed=
SET WinConBuiltSplice=%1
IF NOT "%1" == "+" GOTO :MAYBETERSE
IF "%2" == "*" SET WinConTersed=%2

:MAYBETERSE
rem SELECT TERSE OR VERBOSE
rem     %1 value "*" here selects terse operation
rem
IF "%1" == "*" SET WinContersed=%1
rem                used to dump verbose echoes

SET VCterse=
IF DEFINED WinConTersed SET VCterse=^>NUL

rem ANNOUNCE THIS SCRIPT
IF "%1" == "*" GOTO :WHISPER
IF "%1" == "+" GOTO :WHISPER
TITLE ENSURING %WinCon% SUCCESSFULLY BUILT
COLOR 71
rem   Soft white background with blue text

CLS
ECHO:
:WHISPER
ECHO: [%WInCon%Built] %WinConBuiltVer% ENSURE %WinCon% SUCCESSFUL BUILD
IF NOT CMDEXTVERSION 2 GOTO :FAIL0
IF "%VWinConBuiltSplice%" == "+" GOTO :LOCATE
ECHO:          %TIME% %DATE% on %USERNAME%'s %COMPUTERNAME%%VCterse%
ECHO:          %~dp0%VCterse%     
rem            reporting construction-set folder location

:LOCATE
rem REQUIRE SCRIPT STORED IN ARTIFACTS OF CONSTRUCTION SET (%~dp0)
IF NOT EXIST "%~dp0%WindCon%Built.bat" GOTO :FAIL1
IF NOT EXIST "%~dp0%WIndCon%Build.zip" GOTO :FAIL1
IF NOT "%~f0" == "%~dp0%WindCon%Built.bat" GOTO :FAIL1

rem DETERMINE REQUIRED ACTION
rem    See :USAGE for the %WinCon%Build API contract
IF "%1" == "+" SHIFT /1  
rem    XXX: Making invariant %* without any [+] 
IF "%1" == "?" GOTO :USAGE

rem CONFIRM EXTRACTION OF %WinCon%Build.zip
IF NOT EXIST "%~dp0%WinCon%Build\%WinCon%Build.bat" GOTO :FAIL2

rem LET %WinCon%Build.bat do the rest.
CALL "%~dp0%WinCon%Build\%WinCon%Build.bat" + %1 %2 %3 %4 %5 %6 %7 %8 %9
rem    XXX: Always splicing and passing through any other parameters
SET VCterse=
IF DEFINED WinConTersed SET VCterse=^>NUL
rem    XXX: Not counting on %VCterse% preservation by the called script
IF ERRORLEVEL 2 GOTO :FAIL3

:SUCCESS
ECHO:  %VCterse%
IF "%WinConBuiltSplice%" == "+" EXIT /B 0
IF "%VCterse%" == "" PAUSE
EXIT /B 0

:FAIL3
ECHO: [%WinCon%Built] FAIL: %WinCon% BUILD NOT ENSURED
GOTO :BAIL

:FAIL2
ECHO:          **** FAIL: %WinCon%Build.zip NOT EXTRACTED WHERE EXPECTED ****
ECHO:          Extract %WinCon%Build.zip to sub-folder %WinCon%Build\%VCterse%
ECHO:          in the %WinCon% WinCon construction set where script  %VCterse%
ECHO:          %WinCon%Built.bat is located.%VCterse%
GOTO :NOJOY

:FAIL1
ECHO:          **** FAIL: SCRIPT IS NOT IN THE REQUIRED LOCATION ****
ECHO:          %WinCon%Built must be in the construction-set folder  %VCterse%
ECHO:          having %WinCon%Build.zip.%VCterse%
:NOJOY
ECHO:          %VCterse%
ECHO:          NO BUILDING OF %WinCon% HAS BEEN PERFORMED   %VCterse%
ECHO:          Follow instructions for the construction set. Also   %VCterse%
ECHO:          see ^<http://nfoWare.com/dev/2016/11/d161103.htm^>.  %VCterse%
GOTO :BAIL

:FAIL0
ECHO:          **** FAIL: COMMAND SHELL EXTENSIONS REQUIRED ****
ECHO:          This construction set requires CMDEXTVERSION >= 2.    %VCterse%
ECHO:          This is available on all platforms the set supports.  %VCterse%
ECHO:          %VCterse%
ECHO:          %WinCon%Built.bat SCRIPT OPERATIONS NOT BEEN PERFORMED %VCterse%
ECHO:          To enable Command Extensions, arrange to initiate     %VCterse%
ECHO:          the command shell with /E:ON command-line option      %VCterse%
ECHO:          before using the current construction set.            %VCterse%
GOTO :BAIL

:USAGE
rem    PROVIDE USAGE INFORMATION
ECHO:   USAGE: %WinCon%Built [+] ?
ECHO:          %WinCon%Built [+] [*] [clean] [config [toolset]]
ECHO:          where the parameters are the same as for %WinCon%Build
ECHO:          and the exit conditions are the same as for %WinCon%Build
IF EXIST "%~dp0%WinCon%Build\%WinCon%Build.bat" GOTO :BUILDUSAGE
ECHO:   %WinCon%Built requires %WinCon%Build.zip to be extracted first.
GOTO :SUCCESS

:BUILDUSAGE
CALL "%~dp0%WinCon%Build\%WinCon%Build.bat" + ?
SET VCterse=
IF DEFINED WinConTersed SET VCterse=^>NUL
rem    XXX: Not counting on %VCterse% preservation by %WinCon%Build.bat
IF NOT ERRORLEVEL 2 GOTO :SUCCESS
GOTO :BAIL

:BAIL
ECHO:
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
IF NOT "%VCterse%" == "" EXIT /B %ERRORLEVEL%
IF "%WinConBuiltSplice%" == "+" EXIT /B %ERRORLEVEL%
COLOR 74
rem   Soft White background and Red text
ECHO:
PAUSE
EXIT /B %ERRORLEVEL%


rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                    Copyright 2014 Dennis E. Hamilton
rem
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem     http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.

rem -----1---------2---------3---------4---------5---------6---------7-------*

TODO

 * Test
 
 * Move the customization SET rules and recast the introductory prose.

rem 0.0.1 2016-12-11-21:57 Complete Trial Kit Customization for Adv10Built.bat 
rem 0.0.0 2016-12-11-13:22 Clone from VCensure 0.0.3 as the placeholder and
rem       model for the Adv10Built script.

rem                     *** end of Adv10Built.bat ***
