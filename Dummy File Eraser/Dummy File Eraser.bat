@echo off
Title Dummy File Eraser  - N_A
mode con: cols=135 lines=30
@echo off 

for /f "tokens=1,2*" %%s in ('bcdedit') do set STRING=%%s
if (%STRING%)==(Zugriff) goto NOADMIN

echo.
@echo off  & setlocal
echo msgbox"Administrative permissions are required in order to use this program.",vbExclamation , "N_A"> msg.vbs
msg.vbs
echo.
color E0
goto Ask

:NOADMIN
echo.
@echo off  & setlocal
color 4
echo msgbox"Ran with Administrative Permissions,vbExclamation , "Sin permisos"> msg.vbs
msg.vbs
echo.
goto Ask
:Ask
echo The purpose of this program is to locate and erase any unnecessary files on your system.
echo You can refer to my GitHub page in order to find more detail about this script:
echo https://github.com/Nox-Arcana/Dumby-File-Eraser
echo.
set INPUT=
set /P INPUT=Please type in "Yes" or "No" and press the Enter key to continue: %=%
If /I "%INPUT%"=="yes" goto yes
If /I "%INPUT%"=="Yes" goto yes
If /I "%INPUT%"=="No" goto no
If /I "%INPUT%"=="no" goto no
echo Wrong Command.
echo Exiting...
timeout /t 10
taskkill /im cmd.exe
:yes
echo Launching Dumby File Eraser
@echo off
color E0
Title Dummy File Eraser  - N_A
echo.
cls
echo.
echo Unnecessary registry files will now be erased.
echo Press any key to continue. . .
pause>null
cls
reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /f
reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" /f
reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Bags" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\BagMRU" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Persisted" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\ShellNoRoam\MUICache" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSaveMRU" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /f
cls
echo.
echo --- Unnecessary registry files have been succesfully erased.
echo.
echo.
echo.
echo.
echo.
echo Prefetch, Temp, temp, and recent files will now be erased.
echo Press any key to continue. . .
pause>null
cls
@RD /S /Q "C:\Windows\Prefetch\"
@RD /S /Q "C:\Windows\Temp"
@RD /S /Q "C:\Users\Default\AppData\Roaming\Microsoft\Windows\Recent\"
@RD /S /Q "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Recent\"
@RD /S /Q "C:\Users\%USERNAME%\AppData\Local\Temp"
cls
echo.
color A4
echo The following files were erased: Prefetch, Temp, temp, and recent.
echo.
echo.
echo.
echo.
echo.
echo Windows Event Logs will now be erased.
echo Press any key to continue. . .
pause>null
cls
echo msgbox"This step could take longer than the others. Be aware that your desktop icons may get reset to their default size and location.",vbExclamation , "NOTICE"> msg.vbs
msg.vbs
echo.
color 02
goto clear
:clear
FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
IF (%adminTest%)==(Access) goto noAdmin
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
echo.
echo goto theEnd
cls
echo.
echo --- Dumby File Eraser finished.
echo.
echo.
echo.
echo.
echo.
echo To ensure a clean wipe on your computer, the explorer.exe task will be restarted. This simulates a computer reboot.
echo Press any key to restart explorer.exe and exit this program.
pause>null
taskkill /im explorer.exe /f >null
timeout /t 3 /nobreak >null
start explorer.exe
color F7
echo msgbox"Dumby File Eraser has finished its job. Press OK to exit.",vbExclamation , "N_A"> msg.vbs
msg.vbs
echo.
exit
:do_clear
echo Wiping... %1
wevtutil.exe cl %1
goto :eof
:noAdmin
exit