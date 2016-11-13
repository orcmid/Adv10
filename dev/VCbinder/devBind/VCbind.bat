@echo off
rem VCbind.zip\VCbind.bat 0.0.6       UTF-8                     dh:2016-11-13
rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                  SETTING VC++ COMMAND-SHELL ENVIRONMENT
rem                  =====================================

rem This procedure sets the Windows PC command-shell environment for uase of
rem the Visual C++ command-line compiler, cl.exe, from within a console
rem session.  Additional documentation of the procedure and its usage are
rem found in the accompanying VCbind.txt file.  For further information,
rem see <http://nfoWare.com/dev/2016/11/d161101.htm> and check for the latest
rem version at <http://nfoWare.com/dev/2016/11/d161101b.htm>.
rem    This file reflects ideas applied at the Apache Software Foundation for
rem <https://archive.apache.org/dist/openoffice/4.1.2-patch1/binaries/Windows>

rem ANNOUNCE THIS SCRIPT
rem     XXX: Assume Stand-alone operation for now.
rem          For nesting in another script, find a way to be more "headless"
rem          and avoid clearing and taking over the command shell window.
TITLE SET VC++ COMMAND-LINE ENVIRONMENT
COLOR 71
rem   Soft white background with blue text
CLS
ECHO:
ECHO: [VCbind] 0.0.6 SETTING UP VC++ COMMAND-LINE ENVIRONMENT
ECHO:          with %0
ECHO:          on %DATE% using %USERNAME%'s %COMPUTERNAME% 

rem VERIFY MINIMUM OPERATING CONDITIONS
IF NOT CMDEXTVERSION 2 GOTO :FAIL0

rem VERIFY LOCATION OF THE SCRIPT WHERE VCBIND.ZIP IS FULLY EXTRACTED
IF NOT EXIST "%~dp0LICENSE.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0NOTICE.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.bat" GOTO :FAIL1

rem DETERMINE PARAMETERS
rem    Three environment variables are set whenever there is a successful
rem    VCbind.bat conclusion:
rem           VCbound is the environment (e.g., 140) that was used
rem       VCmodeBound is the mode (e.g., x86) of compilation bound
rem        VCboundVer is the version (e.g., 14.0) of Visual Studio.
rem
rem    other VC* environment variables are used transiently and will
rem    be altered without checking whether they are already defined.
  
rem    XXX: For now, assume no VC* parameters are requested on the
rem         VCbind.bat command-line.

SET VCasked=%VCbound%
SET VCmodeAsked=x86
ECHO: [VCbind] Requesting binding for %VCmodeAsked% compilation.

rem CHECK WHETHER VCBIND SETTINGS HAVE ALREADY BEEN MADE
IF DEFINED VCbound GOTO :ALREADY

rem CHECK WHETHER THERE HAS BEEN SOME OTHER BINDING ALREADY 
IF DEFINED VisualStudioVersion GOTO :FAIL4

rem FIND AVAILABLE 
rem 
rem    XXX: Just use known version 11.0 for initial testing.
set VCasked=110
CALL "%VS110COMNTOOLS%..\..\VC\vcvarsall.bat" %1
rem Only call if there has never been a successful operation
IF "%VisualStudioVersion%" == "" GOTO :FAIL5

ECHO:
ECHO: [VCbind] Environment set for VC++ %VisualStudioVersion% %VCmodeAsked%.
GOTO :SUCCESS

:ALREADY
rem CHECK IF THERE IS A CONFLICT WITH THE PREVIOUS BINDING
IF NOT "%VCasked%" == "%VCbound%" GOTO :FAIL2
IF NOT "%VCmodeAsked%" == "%VCmodeBound%" GOTO :FAIL2

rem CHECK IF ANOTHER CONFLICT HAS ARISEN
IF NOT "%VCboundVer%" == "%VisualStudioVersion%" GOTO :FAIL3

rem TRUST PREVIOUS SETTINGS TO BE REUSABLE
ECHO:
ECHO: [VCbind] Environment set for VC++ %VCboundVer% %VCmodeBound% unchanged.        
GOTO :SUCCESS

:SUCCESS
rem    XXX: Assuming no need to fiddle ERRORLEVEL at this point.
ECHO:
ECHO:
SET VCbound=%VCasked%
SET VCmodeBound=%VCmodeAsked%
SET VCboundVer=%VisualStudioVersion%
rem    correct whether first or subsequent success
PAUSE
EXIT /B 0

:FAIL5
ECHO:
ECHO: [VCbind] *** SETUP FOR TOOLS %VCasked% %VCmodeAsked% FAILED ***
ECHO:          Check preceding messages for failure information.
ECHO:
ECHO:          THE CURRENT STATE IS UNPREDICTABLE
ECHO:          It is likely that %VCmodeAsked% is not supported by
ECHO:          the installed VS %VCasked% Common Tools.  There may
ECHO:          be other problems.
GOTO :BAIL

:FAIL4
ECHO:
ECHO: [VCbind] *** VC ENVIRONMENT ALREADY SET BY OTHER MEANS ***
ECHO:          The environment is already set for compiling with the
ECHO:          VC++ compiler of Visual Studio version %VisualStudioVerison%.
GOTO :NOMIXING

:FAIL3
ECHO:
ECHO: [VCbind] *** VC ENVIRONMENT HAS BEEN ALTERED ***
ECHO:          There has been an alteration of VC binding to version %VisualStudioVersion%
ECHO:          from the version %VCboundVer% set by VCbind.  Continuing
ECHO:          this command-shell session may lead to unexpected results.
GOTO :NOMIXING

:FAIL2
ECHO:
ECHO: [VCbind] **** CONFLICT WITH A PRIOR VCBIND ****
ECHO:          The current request conflicts with settings already
ECHO:          in effect for %VCmodeBound% compilations using the
ECHO:          VC++ compiler of Visual Studio version %VisualStudioVersion%.
rem               TODO: confirm version is always set when vcvarsall works.
GOTO :NOMIXING

:NOMIXING
ECHO:
ECHO:          NO CHANGES HAVE BEEN MADE
ECHO:          Do not attempt to change or mix VCbind settings in a command-
ECHO:          shell session in which VCbind or other settings have already
ECHO:          been made.
GOTO :BAIL

:FAIL1
ECHO:
ECHO: [VCbind] **** SCRIPT IS NOT IN THE REQUIRED LOCATION ****
ECHO:          VCbind.bat must be in the folder that VCbind.zip
ECHO:          is extracted into.  VCbind.bat is not designed to be
ECHO:          separated from the extracted contents of VCbind.zip.
ECHO:
ECHO:          NO CHANGES HAVE BEEN MADE
ECHO:          Follow the instructions in the accompanying VCbind.txt
ECHO:          file for extracting all of VCbind.zip content to a 
ECHO:          working location and using the VCbind.bat there. Also
ECHO:          see "http://nfoWare.com/dev/2016/11/d161101.htm".
GOTO :BAIL

:FAIL0
ECHO:
ECHO: [VCbind] **** COMMAND SHELL EXTENSIONS REQUIRED ****
ECHO:          This script requires CMDEXTVERSION 2 or greater.
ECHO:          This is available since at least Windows XP SP3.
ECHO: 
ECHO:          NO CHANGES HAVE BEEN MADE
ECHO:          To enable Command Extensions, arrange to initiate
ECHO:          the command shell with the /E:ON command-line option
ECHO:          before performing VCbind.bat.
GOTO :BAIL

:BAIL
IF NOT ERRORLEVEL 2 SET ERRORLEVEL=2
COLOR 74
rem   Soft White background and Red text
ECHO:
ECHO:
PAUSE
EXIT /B %ERRORLEVEL%

rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                    Copyright 2006 Dennis E. Hamilton
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


rem 0.0.6 2016-11-13-11:52 Add Checks for All Conflict Cases     
rem 0.0.5 2016-11-08-10:54 Rearrange comments and move TODOs to the
rem       devBind.txt working file.  Check for acceptable CMDEXTVERSION 
rem       and location (%dp0) where this script is located.
rem 0.0.4 2016-10-27-11:43 Boilerplate in VCbinder/devBind folder 
rem       for morphing into a more robust, automatic version that works
rem       free-standing as part of a command-line construction set for
rem       creating Microsoft Windows programs on Microsft Windows.
rem       Scavenged from ShowDefs version scavenged from the OdmVC++.bat 
rem       0.27 version of 2006-11-04-16:35
rem 0.03 2014-12-28-19:11 Get vcvarsall Handshake CALL working
rem      Handshake set up and failure case managed.
rem 0.02 2014-12-28-17:06 Correct vcvarsall Usage
rem      The quotation of the program name is corrected and the ERRORLEVEL
rem      is passed out to the caller.
rem 0.01 2014-12-25-20:41 Confirm that VC\vcvarsall.bat is all we need to
rem      setup plain Visual C++ compiling.
rem 0.00 2014-12-22-17:35 Cloned from OdmVC++.bat 0.27 of 2006-11-04-16:35

rem                     *** end of VCbind.bat ***
