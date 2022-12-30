@echo off
REM Starts a pixlet server on localhost:%PORT%
REM Usage: .\devenv.bat [appname] [port]
REM Ctrl+C to Terminate

setlocal
set PIXLET=".\pixlet\pixlet.exe"
set TARGET=".\%1\%1.star"
set BROWSER="C:\Program Files\Google\Chrome\Application\chrome.exe"
set PORT=8080
if [%2] neq [] (
    set PORT=%2
)

start %BROWSER% "http://localhost:%PORT%"
%PIXLET% serve %TARGET% --watch --port %PORT%

endlocal
pause