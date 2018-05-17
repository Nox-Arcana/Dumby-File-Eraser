@echo off
Title Limpiador de archivos innecesarios -j.A
mode con: cols=135 lines=30
@echo off 

for /f "tokens=1,2*" %%s in ('bcdedit') do set STRING=%%s
if (%STRING%)==(Zugriff) goto NOADMIN

echo.
@echo off  & setlocal
echo msgbox"Para que este programa funcione de manera correcta, es necesario ejecutarlo como administrador.",vbExclamation , "j.A"> msg.vbs
msg.vbs
echo.
color E0
goto Ask

:NOADMIN
echo.
@echo off  & setlocal
color 4
echo msgbox"Este archivo fue ejecutado sin permisos de Administrador,vbExclamation , "Sin permisos"> msg.vbs
msg.vbs
echo.
goto Ask
:Ask
echo Este programa accedera a archivos internos en tu computadora con el proposito de buscar y eliminar aquellos que no son necesarios.
set INPUT=
set /P INPUT=Porfavor, escribe "Si" o "No" y presiona la tecla Enter: %=%
If /I "%INPUT%"=="Si" goto yes
If /I "%INPUT%"=="si" goto yes
If /I "%INPUT%"=="No" goto no
If /I "%INPUT%"=="no" goto no
echo Comando Inválido.
echo Cerrando...
timeout /t 10
taskkill /im cmd.exe
:yes
echo Ejecutando Limpiador...
@echo off
color E0
Title Limpiador de archivos innecesarios -j.A
echo.
cls
echo.
echo Archivos del registro del sistema seran los primeros en ser eliminados.
echo Presiona cualquier tecla para continuar..
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
echo --- Archivos del registro han sido eliminados.
echo.
echo.
echo.
echo.
echo.
echo Los archivos temporales y recientes seran eliminados.
echo Presiona cualquier tecla para continuar..
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
echo --- Archivos temporales y recientes han sido eliminados.
echo.
echo.
echo.
echo.
echo.
echo Como ultimo paso, los eventos de errors, entre otras cosas, seran eliminados.
echo Presiona cualquier tecla para continuar con el ultimo paso..
pause>null
cls
echo msgbox"Este ultimo paso podria tomar mas tiempo que los pasos anterios. Es muy posible que los iconos de su escritorio vuelvan a su tamano y localizacion originales. Tendra que ordenarlos denuevo.",vbExclamation , "j.A"> msg.vbs
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
echo --- Limpiador de archivos innecesarios finalizado.
echo.
echo.
echo.
echo.
echo.
echo Presiona cualquier tecla para reiniciar explorer.exe y dar por finalizado este programa.
pause>null
taskkill /im explorer.exe /f >null
timeout /t 3 /nobreak >null
start explorer.exe
color F7
echo msgbox"Finalizado.",vbExclamation , "j.A"> msg.vbs
msg.vbs
echo.
exit
:do_clear
echo Eliminando... %1
wevtutil.exe cl %1
goto :eof
:noAdmin
exit