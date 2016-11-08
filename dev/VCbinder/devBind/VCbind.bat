@echo off
rem VCbind.zip\VCbind.bat 0.0.5       UTF-8                     dh:2016-11-**
rem -----1---------2---------3---------4---------5---------6---------7-------*

rem                  SETTING VC++ COMMAND-SHELL ENVIRONMENT
rem                  =====================================

rem This procedure sets the Windows PC command-shell environment for uase of
rem the Visual C++ command-line compiler, cl.exe, from within a console
rem session.  Additional documentation of the procedure and its usage are
rem found in the VCbind.txt file in the same VCbind.zip in which this
rem VCbind.bat is normally found.  There is additional information at
rem <http://nfoWare.com/dev/2016/11/d161101.htm>.
rem    This file reflects ideas applied at the Apache Software Foundation for
rem <https://archive.apache.org/dist/openoffice/4.1.2-patch1/binaries/Windows>

rem ANNOUNCE THIS SCRIPT
rem     XXX: Assume Stand-alone operation for now.
rem          For nesting in another script, find a way to be more "headless"
rem          and avoid clearing and taking over the console shell window.
TITLE SET VC++ COMMAND-LINE ENVIRONMENT
COLOR 71
rem   Soft white background with blue text
CLS
ECHO:
ECHO: [VCbind] 0.0.5 SETTING UP VC++ COMMAND-LINE ENVIRONMENT
ECHO:          with %0
ECHO:          on %DATE% using %USERNAME%'s %COMPUTERNAME% 

rem VERIFY MINIMUM OPERATING CONDITIONS
IF NOT CMDEXTVERSION 2 GOTO :FAIL0

rem VERIFY LOCATION OF THE SCRIPT WHERE VCBIND.ZIP IS FULLY EXTRACTED
IF NOT EXIST "%~dp0LICENSE.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0NOTICE.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.txt" GOTO :FAIL1
IF NOT EXIST "%~dp0VCbind.bat" GOTO :FAIL1

rem **** CONTINUE REWORKING FROM HERE ****
rem CONFIRM WHETHER SETTINGS HAVE ALREADY BEEN MADE
rem VERIFY THAT SETTINGS ARE NOT IN CONFLICT
rem 
SET VisualStudioVersion=
rem Only set on a successful operation for any request
CALL "%VS110COMNTOOLS%..\..\VC\vcvarsall.bat" %1
rem Only call if there has never been a successful operation
IF "%VisualStudioVersion%" == "" GOTO :FAIL3
SET VCbindVer=%VisualStudioVersion%
SET VCbindOpt=x86
IF NOT "%1" == "" SET VCbindOpt=%1
rem An appropriate message goes here about setting, etc.
EXIT /B 0

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

:BAIL
COLOR 74
rem   Soft White background and Red text
ECHO:
ECHO:
PAUSE
EXIT /B 2

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


REM **** NOT USING CODE BELOW HERE FOR NOW ****************************
SET ERRORLEVEL=
rem     Remove any incoming %ERRORLEVEL% setting.

IF "%VS80COMNTOOLS%"=="" GOTO :FAIL1
IF NOT "%VCINSTALLDIR%"=="" GOTO :PRESET
IF NOT EXIST "%VS80COMNTOOLS%vsvars32.bat" GOTO :FAIL2
ECHO Settings from %VS80COMNTOOLS%

CALL "%VS80COMNTOOLS%vsvars32.bat"
rem       using the vsvars setup for the installed Visual Studio 2005.

IF "%ERRORLEVEL%" == "" SET ERRORLEVEL=1
EXIT /B %ERRORLEVEL%

:PRESET
ECHO Using VC++ at %VCINSTALLDIR%
rem      the vsvars have already been set.

EXIT /B 1

:FAIL1
ECHO:  **** This script requires Visual C++ 2005 to be installed and
ECHO:  **** the environment variable VS80COMNTOOLS set as part of that
ECHO:  **** Visual C++ or Visual Studio 2005 install
EXIT /B 2

:FAIL2
ECHO: **** Although VS80COMNTOOLS is set, the file vsvars32.bat is
ECHO: **** not available at %VS80COMNTOOLS%
ECHO: ****    Install Visual C++ 2005 Express Edition or modify this
ECHO: **** MyVC++.bat script to locate vsvars32.bat properly in your
ECHO: **** Visual Studio 2005 configuration.
EXIT /B 2

:FAIL3
ECHO * VCBIND OPERATION FAILED
ECHO *     VCbind failed for the reasons noted above.
ECHO *     Provide appropriate correction and customization if needed.
IF "%1" == "" GOTO :BYPASS3
ECHO *     Ensure that the VC Version selected by VCbind supports the
ECHO *     vcvarsall parameter of %1.
:BYPASS3
ECHO *     When the situation is corrected, it may be necessary to start a
ECHO *     new console session to clear out any environment alterations from
ECHO *     the failed VCbind.
ECHO:
EXIT /B 2

:ANNOUNCE
rem Identify this script only if we're done here.
ECHO * VCbind.bat 0.0.4 ESTABLISH VC ENVIRONMENT FOR VC COMPILES %1
ECHO:
EXIT /B 0
rem Exit /B code required to prevent global exit.

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
