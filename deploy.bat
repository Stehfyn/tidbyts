@echo off
REM Renders a tidbyt app to a .webp and pushes it to the device
REM Usage: .\deploy.bat [appname]

setlocal
set PIXLET=".\pixlet\pixlet.exe"
set TARGET=".\%1\%1.star"
set WEBP=".\%1\%1.webp"
set DEVICE="consequently-nurtured-internal-passerine-4b9"

%PIXLET% render %TARGET%
%PIXLET% push %DEVICE% %WEBP% -i %1

endlocal
pause