@echo off

REM Check for Admin privileges
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if "%ERRORLEVEL%" NEQ "0" (
    goto :elevate
) else ( 
    goto :continue 
)

:elevate
echo Set UAC = CreateObject^("Shell.Application"^) > "%TEMP%\elevate.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%TEMP%\elevate.vbs"

"%TEMP%\elevate.vbs"
exit /b

:continue
if exist "%TEMP%\elevate.vbs" ( 
    del "%TEMP%\elevate.vbs" 
)
pushd "%CD%"
cd /d "%~dp0"

echo ////////////////////////////////////////////
echo //     REPLACE OSK by LULECH23 [v1.0]     //
echo ////////////////////////////////////////////
echo.
echo This script will replace the legacy Windows OSK with the modern
echo touch keyboard^. Make sure you are running as administrator^!
echo.
echo To undo changes and restore the original OSK, run this script 
echo again later^.
echo.

pause

if not exist "%WINDIR%\System32\osk.exe.bak" (
    REM Take ownership of legacy OSK
    takeown /f "%WINDIR%\System32\osk.exe" /a
    echo.
    icacls "%WINDIR%\System32\osk.exe" /grant administrators:F
    echo.

    REM Backup original OSK application
    ren "%WINDIR%\System32\osk.exe" "osk.exe.bak"

    REM Link modern touch OSK in place of legacy OSK
    mklink "%WINDIR%\System32\osk.exe" "%PROGRAMFILES%\Common Files\microsoft shared\ink\TabTip.exe"

    REM Set modern touch keyboard to auto-invoke when run
    echo.
    reg add HKLM\SOFTWARE\Microsoft\TabletTip\1.7 /t REG_DWORD /v EnableDesktopModeAutoInvoke /d 1 /f

    echo.
    echo Legacy OSK replaced with modern touch keyboard^.
    echo.
    echo Please sign out and back in to finish applying changes^.
) else (
    REM Delete modern touch OSK symlink
    del /f /q "%WINDIR%\System32\osk.exe"

    REM Restore original OSK application
    ren "%WINDIR%\System32\osk.exe.bak" "osk.exe"

    REM Disable auto-invoking modern touch keyboard when run
    echo.
    reg add HKLM\SOFTWARE\Microsoft\TabletTip\1.7 /t REG_DWORD /v EnableDesktopModeAutoInvoke /d 0 /f

    echo.
    echo Legacy OSK restored^.
    echo.
    echo Please sign out and back in to finish applying changes^.
)

echo.
pause