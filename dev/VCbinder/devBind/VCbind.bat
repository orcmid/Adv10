@echo off
rem VCbind\VCbind.bat 0.0.4           UTF-8                    dh:2016-10-27
echo * VCbind\VCbind.bat 0.0.4: %USERNAME%'s %COMPUTERNAME% VC environment

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

rem                Copyright 2006, 2014 Dennis E. Hamilton
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

rem SET ENVIRONMENT TO USE the VC++ command-line compiler.  This script
rem is executed in a console session to set the environment for command-line
rem operation of compiler cl.exe and related tools, with setup of paths for
rem executables, link libraries, and include files.

rem The procedure always exits with ERRORLEVEL set, with 0 for success,
rem 2 for failure.

rem TODO
rem  * Capture and Explain Errors here rather than in scripts depending
rem    on VCbind.
rem  * Create environment settings that avoid repeated additions to
rem    PATH and other environment variables.
rem  * Fail when an already-set environment is with different vcvarsall
rem    options.
rem  * Move all of the TODOs to the devBind.txt file describing further
rem    development of devBind.
rem  * Convert devBind to automatically find a candidate environment setup
rem    or to have a specified one.


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
