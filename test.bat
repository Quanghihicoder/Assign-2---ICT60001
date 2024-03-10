@echo off

rem Check for /m switch for setup mode
if "%~1%"=="/m" goto SETUP_MODE

rem set password environment variable
if "%VERAPASS%"=="" (
set /p VERAPASS="Enter Veracrypt password: "
)

rem set the variable contains the absolute path to the Veracrypt exe
if "%VERAPATH%"=="" (
set current="%cd%"
cd C:\
dir /s /b VeraCrypt.exe > %TEMP%\temp.txt
set /p VERAPATH= < %temp%\temp.txt
del %temp%\temp.txt
cd "%current%"
)

rem check if sentinal value exists. If yes, jump to Dismount option else jump to Mount option:
if exist "Z:\103579765.txt" (
	goto DISMOUNT_OPTION
) else (
	goto MOUNT_OPTION
)

goto END

rem call Veracrypt with mount option on command-line
:DISMOUNT_OPTION
echo Dismounting...
%VERAPATH% /d Z: /q /s /f
if errorlevel 1 echo Error dismounting Veracrypt container

goto END


rem call Veracrypt with mount option on command-line
:MOUNT_OPTION
echo Mounting...
%VERAPATH% /v "C:\Apps\103579765.tc" /l "Z" /p %VERAPASS% /q /s
if errorlevel 1 echo Error dismounting Veracrypt container

goto END

rem setup mode
:SETUP_MODE
echo "*******************MENU**********************"
echo "1. Find and store path of Veracrypt.exe"
echo "2. Input password and store"
echo "3. Remove all Vera environment variables"
echo "4. Exit"
set /p op="Enter Veracrypt your choice (1-4): "
if "%op%"=="1" (
set current="%cd%"
cd C:\
dir /s /b VeraCrypt.exe > %TEMP%\temp.txt
set /p VERAPATH= < %temp%\temp.txt
del %temp%\temp.txt
cd "%current%"
) 

if "%op%"=="2" (
set /p VERAPASS="Enter Veracrypt password: "
) 

if "%op%"=="3" (
set VERAPASS=
set VERAPATH=
) 

if "%op%"=="4" (
goto END
) 
goto SETUP_MODE


:END

exit /b 
