@echo off
rem VCbind.zip\VCbind.bat 0.0.11       UTF-8                       2016-11-15 
rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                  SETTING VC++ COMMAND-SHELL ENVIRONMENT
rem                  ======================================

rem This procedure sets the Windows PC command-shell environment for command-
rem line use of the Visual C++ command-line compiler, cl.exe, and related
rem build tools.

rem Additional documentation of the procedure and its usage are found in the
rem accompanying VCbind.txt file.  For further information, see
rem <http://nfoWare.com/dev/2016/11/d161101.htm> and check for the latest
rem version at <http://nfoWare.com/dev/2016/11/d161101b.htm>.

rem SELECT TERSE OR VERBOSE
rem     %1 value "*" selects terse operation
rem     don't shift it out until Command Extensions confirmed.
SET VCterse=
IF "%1" == "*" SET VCterse=^>NUL
rem                used to dump verbose echoes

rem ANNOUNCE THIS SCRIPT
IF "%1" == "*" GOTO :WHISPER
TITLE VC++ COMMAND-LINE BUILD ENVIRONMENT SETUP
COLOR 71
rem   Soft white background with blue text

CLS
ECHO:
:WHISPER
ECHO: [VCbind] 0.0.11 SETTING UP VC++ COMMAND-SHELL ENVIRONMENT
IF NOT CMDEXTVERSION 2 GOTO :FAIL0
ECHO:          %TIME% %DATE% on %USERNAME%'s %COMPUTERNAME% 
ECHO:          %~f0
rem            reporting full-path filename of this script

rem VERIFY LOCATION OF THE SCRIPT WHERE VCBIND.ZIP IS FULLY EXTRACTED
IF NOT EXIST "%~dp0LICENSE.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0NOTICE.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.bat" GOTO :FAIL1

rem DETERMINE PARAMETERS
rem    VCbind.bat has the following command-line parameters:

rem         > VCbind [*][option [toolset]]

rem    where
rem             * signifies that terse output is preferred
rem               (suitable when operated from within another script)

rem        config is one of the VC++ "platform" cases:
rem                        x86 for producing x86 code via the x86 compiler
rem                      amd64 for producing x64 code via the x64 compiler
rem                  amd64_x86 for producing x86 code via the x64 compiler
rem                  x86_amd64 for producing x64 code via the x86 compiler
rem               Some toolsets and platforms will limite these.
rem               x86 is the default and always works.

rem       toolset identifies which common tools to start checking from:
rem                        140 for Visual Studio 2015 (14.0) flavors, then 
rem                        120 for Visual Studio 2013 (12.0) flavors, then
rem                        110 for Visual Studio 2012 (11.0) flavors, then
rem                        100 for Visual Studio 2010 (10.0) flavors, and then
rem                         90 for Visual Studio 2008 (9.0) flavors
rem                140 is the default  
rem                XXX: This variability allows for easy testing also.

rem    Three environment variables are set whenever there is a successful
rem    VCbind.bat conclusion:
rem           VCbound identifes the common tools (e.g., 140) that were used
rem     VCboundConfig is the bound configuration (e.g., x86) for compilation
rem        VCboundVer is the version (e.g., 14.0) of Visual Studio
rem                   that the VC++ build tools correspond to.
rem    other VC* environment-variable names are used transiently and will
rem    be altered without checking whether they are already defined.
  
IF "%1" == "*" SHIFT /1

SET VCaskedConfig=x86
IF NOT "%1" == "" SET VCaskedConfig=%1

SET VCasked=140
IF DEFINED VCboud SET VCasked=%VCbound%
IF NOT "%2" == "" SET VCasked=%2

rem VERIFY CONFIG
IF "%VCaskedConfig%" == "x86"  GOTO :CHECKTOOLSET
IF "%VCaskedConfig%" == "amd64" GOTO :CHECKTOOLSET
IF "%VCaskedConfig%" == "x86_amd64" GOTO :CHECKTOOLSET
IF NOT "%VCaskedConfig%" == "amd64_x86" GOTO :FAIL7

:CHECKTOOLSET
rem VERIFY TOOLSET
IF "%VCasked%" == "140" GOTO :CHECKCONFLICT
IF "%VCasked%" == "120" GOTO :CHECKCONFLICT
IF "%VCasked%" == "110" GOTO :CHECKCONFLICT
IF "%VCasked%" == "100" GOTO :CHECKCONFLICT
IF NOT "%VCasked%" ==  "90" GOTO :FAIL7

:CHECKCONFLICT
rem CHECK WHETHER VCBIND SETTINGS HAVE ALREADY BEEN MADE
IF DEFINED VCbound GOTO :ALREADY

rem CHECK WHETHER THERE HAS BEEN SOME OTHER BINDING ALREADY 
IF DEFINED VCINSTALLDIR GOTO :FAIL4

rem FIND LATEST-AVAILABLE RELEASED TOOLSET
rem      starting from VCasked (default 140)   

GOTO :TRY%VCasked%

:TRY140
IF NOT DEFINED VS140COMNTOOLS GOTO :TRY120
set VisualStudioVersion=14.0
rem    XXX: Because Build Tools case doesn't set it
CALL :VCTRY "%VS140COMNTOOLS%..\..\VC\" 140
IF NOT ERRORLEVEL 9 EXIT /B %ERRORLEVEL%
set VisualStudioVersion=
rem    XXX: Because guessed wrong

:TRY120
IF NOT DEFINED VS120COMNTOOLS GOTO :TRY110
CALL :VCTRY "%VS120COMNTOOLS%..\..\VC\" 120
IF NOT ERRORLEVEL 9 EXIT /B %ERRORLEVEL%

:TRY110
IF NOT DEFINED VS110COMNTOOLS GOTO :TRY100
CALL :VCTRY "%VS110COMNTOOLS%..\..\VC" 110
IF NOT ERRORLEVEL 9 EXIT /B %ERRORLEVEL%

:TRY100
IF NOT DEFINED VS100COMNTOOLS GOTO :TRY90
CALL :VCTRY "%VS100COMNTOOLS%..\..\VC" 100
IF NOT ERRORLEVEL 9 EXIT /B %ERRORLEVEL%

:TRY90
IF NOT DEFINED VS90COMNTOOLS GOTO :FAIL6
CALL :VCTRY "%VS90COMNTOOLS%..\..\VC" 90
IF NOT ERRORLEVEL 9 EXIT /B %ERRORLEVEL%
GOTO :FAIL6

rem TRY ESTABLISHING A PARTICULAR VC++ VERSION 
rem       %1 is the quoted full path to the expected VC folder
rem       %2 is the common tools version (e.g., 140 for VS 14.0, 2015)
rem ERRORLEVEL 9 is returned if there is a VC\ setup is not supplied
rem            2 is returned if there was a reported FAIL case
rem            0 is returned if there was a reported SUCCESS case

:VCTRY
set ERRORLEVEL=
set VCasked=%2%
IF NOT EXIST %1\vcvarsall.bat EXIT /B 9
CALL %1\vcvarsall.bat %VCaskedConfig%
IF ERRORLEVEL 1 GOTO :FAIL5

:WINNER
ECHO:          Success: VC++ %VisualStudioVersion% %VCaskedConfig% config set.
GOTO :SUCCESS

:ALREADY
rem CHECK IF THERE IS A CONFLICT WITH THE PREVIOUS BINDING
IF NOT "%VCasked%" == "%VCbound%" GOTO :FAIL2
IF NOT "%VCaskedConfig%" == "%VCboundConfig%" GOTO :FAIL2

rem CHECK IF ANOTHER CONFLICT HAS ARISEN
IF NOT "%VCboundVer%" == "%VisualStudioVersion%" GOTO :FAIL3

rem TRUST PREVIOUS SETTINGS TO BE REUSABLE
rem      Avoid multiple running of vcvarsall and duplicating the PATH and
rem      other parameter settings.
ECHO:          Using existing VC++ %VCboundVer% %VCboundConfig% config setup.        
GOTO :SUCCESS

:SUCCESS
SET VCbound=%VCasked%
SET VCboundConfig=%VCaskedConfig%
SET VCboundVer=%VisualStudioVersion%
rem    appropriate whether or not already set
ECHO:  %VCterse%
IF "%VCterse%" == "" PAUSE
EXIT /B 0

:FAIL7
ECHO:          *** UNSUPPORTED VCBIND PARAMETER ***
ECHO:          Invalid: %*
ECHO:          %VCterse%
ECHO:          NO CHANGES HAVE BEEN MADE
GOTO :BAIL

:FAIL6
ECHO:          *** NO VC++ BUILD TOOLS FOUND ***
ECHO:          VCbind-supported build tools could not be located.   %VCterse%
ECHO:          %VCterse%
ECHO:          NO ENVIRONMENT CHANGES HAVE BEEN MADE                
ECHO:          See %<http://nfoWare.com/dev/2016/11/d161101.htm%>   %VCterse%
ECHO:          for suitable freely-available versions.              %VCterse%
GOTO :BAIL

:FAIL5
set VisualStudioVersion=
rem     in case incorrectly guessed at :TRY140
ECHO: [VCbind] *** SETUP FOR TOOLS %VCasked% %VCaskedConfig% CONFIG FAILED ***
ECHO:          Check preceding messag(s) for failure information.
ECHO:          %VCterse%
ECHO:          NO VC++ CONFIGURATION ENVIRONMENT IS SET             %VCterse%
GOTO :BAIL

:FAIL4
ECHO:          *** VC ENVIRONMENT ALREADY SET BY OTHER MEANS ***    %VCterse%  
ECHO:          The environment is already set for compiling with a  %VCterse%
ECHO:          VC++ compiler version %VisualStudioVersion%          %VCterse%
GOTO :NOMIXING

:FAIL3
ECHO:          *** VC ENVIRONMENT HAS BEEN ALTERED ***
ECHO:          VC binding to VC++ %VisualStudioVersion% is changed  %VCterse%
ECHO:          from version %VCboundVer% set by VCbind.  Continuing %VCterse%
ECHO:          this session may lead to unexpected results.         %VCterse%
GOTO :NOMIXING

:FAIL2
ECHO:          **** CONFLICT WITH A PRIOR VCBIND ****
ECHO:          The current request conflicts with settings already  %VCterse%
ECHO:          in effect for %VCboundConfig% config with the VC++   %VCterse%
ECHO:          %VisualStudioVersion% compiler.                      %VCterse%
GOTO :NOMIXING

:NOMIXING
ECHO:          %VCterse%
ECHO:          NO CHANGES HAVE BEEN MADE
ECHO:          Do not attempt to change or mix VCbind settings in   %VCterse%
ECHO:          a command-shell session in which VC++ environment    %VCterse%
ECHO:          settings have already been made.                     %VCterse%
GOTO :BAIL

:FAIL1
ECHO:          **** SCRIPT IS NOT IN THE REQUIRED LOCATION ****
ECHO:          VCbind.bat must be in the folder that VCbind.zip     %VCterse%
ECHO:          is extracted into.  VCbind.bat is not designed to be %VCterse%
ECHO:          separated from the extracted contents of VCbind.zip. %VCterse%
ECHO:          %VCterse%
ECHO:          NO CHANGES HAVE BEEN MADE
ECHO:          Follow instructions in the accompanying VCbind.txt   %VCterse%
ECHO:          file for extracting all of VCbind.zip content to a   %VCterse%
ECHO:          working location and using the VCbind.bat there. Also%VCterse%
ECHO:          see ^<http://nfoWare.com/dev/2016/11/d161101.htm^>.  %VCterse%
GOTO :BAIL

:FAIL0
ECHO:          **** COMMAND SHELL EXTENSIONS REQUIRED ****
ECHO:          VCbind requires CMDEXTVERSION 2 or greater.           %VCterse%
ECHO:          This is available on all platforms VCbind supports.   %VCterse%
ECHO:          %VCterse%
ECHO:          NO CHANGES HAVE BEEN MADE
ECHO:          To enable Command Extensions, arrange to initiate     %VCterse%
ECHO:          the command shell with the /E:ON command-line option  %VCterse%
ECHO:          before VCbind.bat is performed directly or indirectly.%VCterse%
GOTO :BAIL

:BAIL
ECHO:
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
IF NOT "%VCterse%" == "" EXIT /B %ERRORLEVEL%
COLOR 74
rem   Soft White background and Red text
ECHO:
PAUSE
EXIT /B %ERRORLEVEL%

rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                    Copyright 2006 Dennis E. Hamilton

rem This file reflects ideas applied at the Apache Software Foundation for
rem <https://archive.apache.org/dist/openoffice/4.1.2-patch1/binaries/Windows>

rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem     <http://www.apache.org/licenses/LICENSE-2.0>

rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.


rem -----1---------2---------3---------4---------5---------6---------7-------*

rem 0.0.11 2016-11-15-17:21 Complete Parameter Filtering
rem 0.0.10 2016-11-15-14:31 Introduce Terse operation;  smooth messages.
rem 0.0.9 2016-11-15-11:03 Define parameters, choose "config" naming of
rem       platform types, and smooth messages and comments some more.
rem 0.0.8 2016-11-14-17:43 Add Try ladder for determining the latest version
rem       installed.  Simplify message layout further.
rem 0.0.7 2016-11-14-09:55 Smooth output of messages
rem       The output messages are smoothed to be more condensed in
rem       non-failure cases.  There is better clarity and terminology.
rem 0.0.6 2016-11-13-11:52 Add Checks for All Conflict Cases     
rem 0.0.5 2016-11-08-10:54 Rearrange comments and move TODOs to the
rem       devBind.txt working file.  Check for acceptable CMDEXTVERSION 
rem       and location (%dp0) where this script is located.
rem 0.0.4 2016-10-27-11:43 Boilerplate in VCbinder/devBind folder 
rem       for morphing into a more robust, automatic version that works
rem       free-standing as part of a command-line construction set for
rem       creating Microsoft Windows programs on Microsft Windows.
rem       Scavenged from ShowDefs version 0.03. 
rem 0.03 2014-12-28-19:11 Get vcvarsall Handshake CALL working
rem      Handshake set up and failure case managed.
rem 0.02 2014-12-28-17:06 Correct vcvarsall Usage
rem      The quotation of the program name is corrected and the ERRORLEVEL
rem      is passed out to the caller.
rem 0.01 2014-12-25-20:41 Confirm that VC\vcvarsall.bat is all we need to
rem      setup plain Visual C++ compiling.
rem 0.00 2014-12-22-17:35 Cloned from OdmVC++.bat 0.27 of 2006-11-04-16:35

rem                     *** end of VCbind.bat ***
