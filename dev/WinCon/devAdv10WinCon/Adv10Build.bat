@echo off
rem Adv10Build.bat 0.0.4              UTF-8                        2016-12-13
rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                    BUILD ADV10 FROM SOURCE AS NEEDED
rem                    =================================

rem                      PROOF-OF-CONCEPT PILOT CODE

rem      This script is part of the Adv10 WinCon Construction Set for 
rem      ensuring that a successful build has occured.  If Adv10Build has
rem      not previously succeeded, it will be attempted automatically.
rem      To require a build, the "clean" parameter can be used.  It will
rem      Delete existing Adv10.exe compilation artifacts and build anew.

rem      See :USAGE for optional parameters and compatibility requirements.

rem      IMPORTANT NOTE: This version of Adv10Build.bat is as a prototype
rem      for experimental confirmation as part of the Adv10 project.  In
rem      the future, this script will be produced by customization of a
rem      WinCon Construction Kit provided by the nfoTools project.  For
rem      further information, see <http://nfoWare.com/dev/2016/11/d161103.htm>
rem      and <https://github.com/orcmid/nfoTools>devKits/WinDev/WinConKit.

REM IDENTIFY THIS CONSTRUCTION SET TARGET AND VERSION
SET WinCon=Adv10
SET WinConSetVer=0.0.0
rem      The construction set version, not the WinConKit version

REM * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
REM DO NOT CUSTOMIZE THE SCRIPT BODY FURTHER BELOW HERE.  
REM    1. Maintain the top-level file name, version, and last-change date
REM    2. Maintain the version progression at the end if desired.
REM    3. Put the top-level file name in the final remark.
REM    
REM THIS IS A SINGLE-COMPILATION SCRIPT
REM    There is a single call on CL.exe with all parameters of that call
REM    provided by @.opt files.  Those files are edited further to provide
REM    the specific case required by the current construction set.

rem SET THE (PILOT) CONSTRUCTION KIT VERSION
SET WinConKitVer=0.0.0
rem     semantic versioning candidate

rem SELECT SPLICED, TERSE, OR DEFAULT VERBOSE
rem     %1 value "+" selects smooth non-stop operation for splicing output
rem        into that of a calling script such as WinConRun or equivalent.
rem     %2 might then be "*" for terse operation and allow for that.
rem 
SET WinConBuildTersed=
SET WinConBuildSplice=%1
IF NOT "%1" == "+" GOTO :MAYBETERSE
IF "%2" == "*" SET WinConBuildTersed=%2

:MAYBETERSE
rem SELECT TERSE OR VERBOSE
rem     %1 value "*" here selects terse operation
rem
IF "%1" == "*" SET WinConBuildTersed=%1
rem                used to dump verbose echoes

SET VCterse=
IF DEFINED WinConBuldTersed SET VCterse=^>NUL

rem ANNOUNCE THIS SCRIPT
IF "%1" == "*" GOTO :WHISPER
IF "%1" == "+" GOTO :WHISPER
TITLE %WinConSetVer% %WinCon% BUILDING FROM SOURCE CODE 
COLOR 71
rem   Soft white background with blue text

CLS
ECHO:
:WHISPER
ECHO: [%WInCon%Build] %WinConSetVer% %WinCon% BUILDING FROM SOURCE CODE
IF NOT CMDEXTVERSION 2 GOTO :FAIL0
IF "%WinConBuildSplice%" == "+" GOTO :LOCATE
ECHO:          %TIME% %DATE% on %USERNAME%'s %COMPUTERNAME%%VCterse%
ECHO:          %~dp0%VCterse%     
rem            reporting construction-set folder location

:LOCATE
rem REQUIRE SCRIPT STORED IN ARTIFACTS OF CONSTRUCTION SET (%~dp0)
IF NOT EXIST "%~dp0%WinCon%Build.bat" GOTO :FAIL1
IF NOT EXIST "%~dp0%WinCon%Build.opt" GOTO :FAIL1
IF NOT EXIST "%~dp0%WinCon%Sources.opt" GOTO :FAIL1
IF NOT "%~f0" == "%~dp0%WinCon%Build.bat" GOTO :FAIL1
IF NOT EXIST "%~dp0..\%WinCon%Build.zip" GOTO :FAIL1
IF NOT EXIST "%~dp0..\VCensure.bat" GOTO :FAIL2

rem DETERMINE REQUIRED ACTION
rem    See :USAGE for the %WinCon%Build API contract
IF "%1" == "+" SHIFT /1  
rem    XXX: Making invariant %* without any [+] 
IF "%1" == "?" GOTO :USAGE

IF DEFINED WinConBuildTersed SHIFT /1
rem    XXX: Making invariant to get to any "clean"

IF "%1" == "clean" GOTO :CLEANBUILD
IF NOT "%1" == ^""clean"^" GOTO :VCENSURE
rem    XXX: In case someone takes "clean" literally in the :USAGE

:CLEANBUILD
SHIFT /1
IF NOT EXIST "%~dp0%WinCon%.exe" GOTO :VCENSURE
ECHO:          Cleaning out previous %WinCon%.exe build result.
DEL "%~dp0%WinCon%.*"

:VCENSURE
rem ALWAYS CHECK BINDING BECAUSE OF POSSIBLE PARAMETER CONFLICTS
CALL "%~dp0..\VCensure" + %WinConBuildTersed% %1 %2 %3 %4 %5 %6 %7 %8 %9
IF ERRORLEVEL 2 GOTO :FAIL3

rem USE AN EXISTING EXE IF ONE WAS KEPT
IF NOT EXIST "%~dp0%WinCon%.exe" GOTO :COMPILE
ECHO: [%WinCon%Build] Using already-compiled %WinCon%.exe
GOTO :SUCCESS

:COMPILE
rem ALL RIGHT, LET'S TRY COMPILING
PUSHD "%~dp0"
rem    Deliver all build artifacts into %WinCon%Build\
ECHO: [%WinCon%Build] Compiling ...
CL.exe @%WinCon%Build.opt @%WinCon%Sources.opt
POPD

SET VCterse=
IF DEFINED WinConBuildTersed SET VCterse=^>NUL
rem    XXX: Not counting on %VCterse% preservation by the called scripts
IF ERRORLEVEL 2 GOTO :FAIL4
IF NOT EXIST "%~dp0%WinCon%.exe" GOTO :FAIL4

ECHO: [%WinCon%Build] Compiled %WinCon% available

:SUCCESS
IF "%WinConBuildSplice%" == "+" EXIT /B 0
IF "%VCterse%" == "" PAUSE
EXIT /B 0

:FAIL4
ECHO: [%WinCon%Build] FAIL: %WinCon% EXECUTABLE NOT PRODUCED
ECHO:          Review the errors reported for the compilation, make  %VCterse%
ECHO:          repairs and reattempt.
GOTO :BAIL

:FAIL3
ECHO: [%WinCon%Build] FAIL: COMMAND-LINE ENVIRONMENT SETUP PROBLEM/CONFLICT
ECHO:          After resolving the reported difficulties, retry with %VCterse%
ECHO:          a request for a "clean" built %WinCon%.exe            %VCterse%       
GOTO :BAIL

:FAIL2
ECHO:          **** FAIL: VCensure.bat NOT LOCATED WHERE EXPECTED ****
ECHO:          %WinCon%Build.bat requires VCensure.bat available    %VCterse%
ECHO:          at the %WinCon% WinCon construction set level.       %VCterse%               
GOTO :NOJOY

:FAIL1
ECHO:          **** FAIL: SCRIPT IS NOT IN THE REQUIRED LOCATION ****
ECHO:          %WinCon%Build.bat must be in the folder that %VCterse%
ECHO:          %WinCon%Build.zip is extracted into.  %WinCon%Build  %VCterse%
ECHO:          is not designed to be separated from the extracted    %VCterse%
ECHO:          contents of %WinCon%Build.zip. %VCterse%
ECHO:          %VCterse%
GOTO :NOJOY

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
ECHO:          %WinCon%Build.bat SCRIPT OPERATIONS NOT BEEN PERFORMED %VCterse%
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
IF DEFINED WinConBuiltTersed SET VCterse=^>NUL
rem    XXX: Ignoring deeper-level settings of VCterse
IF NOT ERRORLEVEL 2 GOTO :SUCCESS
GOTO :BAIL

:BAIL 
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
IF NOT "%VCterse%" == "" EXIT /B %ERRORLEVEL%
IF "%WinConBuildSplice%" == "+" EXIT /B %ERRORLEVEL%
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

rem 0.0.4 2016-12-13-18:38 Update to work smoothly with Adv10Built,
rem       completing pilot customization as if from WinConKit.
rem 0.0.3 2016-12-07-11:55 Transposed to Adv10Build for quick experimental 
rem       confirmation of directory, relative-path, and CL.exe @option files.
rem       Earlier effort was in the ShowDef project.
rem 0.02 2014-12-27-16:30 Restore Full Filter
rem      The file requirement is restored and checked in alphabetical order
rem 0.01 2014-12-27-08:49 Correct %-dp0 to %~dp0
rem      Correct syntax error in the DefaultBuild.run check
rem 0.00 2014-12-26-11:04 Initial Run Script
rem      The script is forked from VS2013\Default\DefaultRun.bat 0.03 and
rem      customized for employment as VC\Default\DefaultRun.bat.

rem                     *** end of Adv10Build.bat ***