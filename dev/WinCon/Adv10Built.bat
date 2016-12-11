@echo off
rem Adv10Built.bat 0.0.0              UTF-8                        2016-12-11
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

rem Designate the distribution version 
SET Adv10BuiltVer=0.0.0
rem     semantic versioning candidate

rem ****** CONTINUE CUSTOMIZATION FROM HERE ***************************
rem *******************************************************************

rem SELECT SPLICED, TERSE, OR DEFAULT VERBOSE
rem     %1 value "+" selects smooth non-stop operation for splicing output
rem        into that of a calling script such as Adv10Run.
rem     %2 might then be "*" for terse operation and allow for that.
rem 
SET tersed=
SET VCensureSplice=%1
IF NOT "%1" == "+" GOTO :MAYBETERSE
IF "%2" == "*" SET VCtersed=%2

:MAYBETERSE
rem SELECT TERSE OR VERBOSE
rem     %1 value "*" here selects terse operation
rem
IF "%1" == "*" SET VCtersed=%1
rem                used to dump verbose echoes

SET VCterse=
IF DEFINED VCtersed SET VCterse=^>NUL

rem ANNOUNCE THIS SCRIPT
IF "%1" == "*" GOTO :WHISPER
IF "%1" == "+" GOTO :WHISPER
TITLE ENSURING VC++ COMMAND-LINE ENVIRONMENT ENABLED
COLOR 71
rem   Soft white background with blue text

CLS
ECHO:
:WHISPER
ECHO: [VCensure] %VCensureVer% ENSURE VC++ COMMAND-LINE ENVIRONMENT ENABLED
IF NOT CMDEXTVERSION 2 GOTO :FAIL0
IF "%VCensureSplice%" == "+" GOTO :LOCATE
ECHO:          %TIME% %DATE% on %USERNAME%'s %COMPUTERNAME%%VCterse%
ECHO:          %~dp0%VCterse%     
rem            reporting construction-set folder location

:LOCATE
rem REQUIRE SCRIPT STORED IN VCBINDER ARTIFACTS OF CONSTRUCTION SET (%~dp0)
IF NOT EXIST "%~dp0VCensure.bat" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.zip" GOTO :FAIL1

rem DETERMINE REQUIRED ACTION
rem    See :USAGE for the VCbind API contract
IF "%1" == "+" SHIFT /1  
rem    XXX: Making invariant %* without any [+] 
IF "%1" == "?" GOTO :USAGE

rem CONFIRM EXTRACTION OF VCBIND.ZIP
IF NOT EXIST "%~dp0VCbind\VCbind.bat" GOTO :FAIL2

rem LET VCBIND DO THE REST
CALL "%~dp0VCbind\VCbind.bat" + %1 %2 %3
rem    XXX: Always splicing VCbind and passing through the rest
SET VCterse=
IF DEFINED VCtersed SET VCterse=^>NUL
rem    XXX: Not counting on %VCterse% preservation by VCBind.bat
IF ERRORLEVEL 2 GOTO :FAIL3

:SUCCESS
ECHO:  %VCterse%
IF "%VCensureSplice%" == "+" EXIT /B 0
IF "%VCterse%" == "" PAUSE
EXIT /B 0

:FAIL3
ECHO: [VCensure] COMMAND-LINE ENVIRONMENT NOT ENSURED
GOTO :BAIL

:FAIL2
ECHO:          **** FAIL: VCBIND.ZIP NOT EXTRACTED WHERE EXPECTED ****
ECHO:          Extract VCbind.zip to the sub-folder VCbind\ in the  %VCterse%
ECHO:          construction set where VCensure.bat and VCbind.zip   %VCterse%
ECHO:          are located.                                         %VCterse%
GOTO :NOJOY

:FAIL1
ECHO:          **** FAIL: SCRIPT IS NOT IN THE REQUIRED LOCATION ****
ECHO:          VCensure.bat must be in the construction-set folder  %VCterse%
ECHO:          having VCbind.zip.  VCensure.bat is not designed to  %VCterse%
ECHO:          be separated from VCbind.zip in the construciton set.%VCterse%
:NOJOY
ECHO:          %VCterse%
ECHO:          COMMAND-LINE ENVIRONMENT ADJUSTMENTS WERE NOT MADE   %VCterse%
ECHO:          Follow instructions for the construction set. Also   %VCterse%
ECHO:          see ^<http://nfoWare.com/dev/2016/11/d161102.htm^>.  %VCterse%
GOTO :BAIL

:FAIL0
ECHO:          **** FAIL: COMMAND SHELL EXTENSIONS REQUIRED ****
ECHO:          This construction set requires CMDEXTVERSION >= 2.    %VCterse%
ECHO:          This is available on all platforms the set supports.  %VCterse%
ECHO:          %VCterse%
ECHO:          COMMAND-LINE ENVIRONMENT ADJUSTMENTS ARE NOT MADE     %VCterse%
ECHO:          To enable Command Extensions, arrange to initiate     %VCterse%
ECHO:          the command shell with /E:ON command-line option      %VCterse%
ECHO:          before using the current construction set.            %VCterse%
GOTO :BAIL

:USAGE
rem    PROVIDE USAGE INFORMATION
ECHO:   USAGE: VCensure [+] ?
ECHO:          VCensure [+] [*] [config [toolset]]
ECHO:          where the parameters are the same as for VCbind
ECHO:          the exit conditins are the same as for VCbind
IF EXIST "%~dp0VCbind\VCbind.bat" GOTO :BINDUSAGE
ECHO:   VCensure requires VCbind.zip to be extracted first.
GOTO :SUCCESS

:BINDUSAGE
CALL "%~dp0VCbind\VCbind.bat" + ?
SET VCterse=
IF DEFINED VCtersed SET VCterse=^>NUL
rem    XXX: Not counting on %VCterse% preservation by VCBind.bat
IF NOT ERRORLEVEL 2 GOTO :SUCCESS
GOTO :BAIL

:BAIL
ECHO:
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
IF NOT "%VCterse%" == "" EXIT /B %ERRORLEVEL%
IF "%VCensureSplice%" == "+" EXIT /B %ERRORLEVEL%
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

rem TODO
rem
rem   * Determine how much to retain as WinCon-named and what gets changed
rem     to Adv10Mumble.  The idea is to be able to set a couple of environment
rem     variables at the top of the script, rename the script, and be done,
rem     as if customization of a WinConKit had been done.
rem   * We do want renaming of the files to avoid confusion about the version
rem     control and what version we are looking at.  This does mean that 
rem     updating to a new WinConKit is more laborious.  This sets the stage
rem     for how one might automate some of that and how higher-level make and
rem     build systems might or might not be helpful.
rem   * We want to add a [clean] option so that a clean build can be requested.
rem   * It is unclear whether [+][*][clean][config [toolset]] is the way
rem     to go.  We'll probably try it.  It does mean that an adv10.* deletion
rem     should always be safe and not remove anything of importance that 
rem     won't be recreated automatically by a successful build.
rem   * Use %~n0 as much as possible to automatically determine the names of
rem     construction-set-specific places and files.
rem   * It still seems important to make project-specific WinCon component
rem     namings in order to differentiate from the WinConKit origin versus
rem     the project customizations.
rem   * It would be interesting to see if patching could be a means to
rem     upgrading to a new kit without losing an user's customization effort.

rem 0.0.0 2016-12-11-13:22 Clone from VCensure 0.0.3 as the placeholder and
rem       model for the Adv10Built script.

rem                     *** end of Adv10Built.bat ***