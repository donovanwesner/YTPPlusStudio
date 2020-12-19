:: to-do: make bash *.sh files for this script
@echo off
:: BatchGotAdmin - checking for admin, you can ignore this
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
SET REPONAME=YTPPlusCLI
SET REPO=https://github.com/YTP-Plus/%REPONAME%.git
SET REPOPATH=./%REPONAME%
SET GITVER=2.11.0.0
SET NODEVER=14.15.3
ECHO Checking if Git is already installed...
WHERE git
IF %ERRORLEVEL% EQU 0 ECHO Git is already installed.
IF %ERRORLEVEL% NEQ 0 ECHO Git not detected. Installing TortoiseGit... && START /WAIT msiexec.exe /i https://download.tortoisegit.org/tgit/%GITVER%/TortoiseGit-%GITVER%-64bit.msi /quiet && ECHO Finished installing TortoiseGit.
SET ERRORLEVEL=0
ECHO -----
ECHO Checking if Node is already installed...
WHERE node
IF %ERRORLEVEL% EQU 0 ECHO Node is already installed.
IF %ERRORLEVEL% NEQ 0 ECHO Node not detected. Installing NodeJS... && START /WAIT msiexec.exe /i https://nodejs.org/dist/latest-v4.x/node-v%NODEVER%-x64.msi /quiet && ECHO Finished installing NodeJS.
ECHO -----
ECHO Pressing a key to continue will clone %REPO% here and install it via NPM:
PAUSE
IF NOT EXIST %REPOPATH% git clone %REPO%
CD %REPOPATH%
CMD /C npm install
ECHO -----
ECHO Finished! Pressing a key will exit:
PAUSE
EXIT 0
