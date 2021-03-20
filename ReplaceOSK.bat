@echo off
setlocal EnableDelayedExpansion

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

echo [96m//////////////////////////////////////////// [0m
echo [96m//     REPLACE OSK by LULECH23 [v2.0]     // [0m
echo [96m//////////////////////////////////////////// [0m
echo.
echo This script will replace the legacy Windows OSK with the modern touch keyboard^.
echo For best results, make sure the latest ^.NET Framework is installed^.
echo.
echo To undo changes and restore the original OSK, run this script 
echo again later^.
echo.

if exist "%WINDIR%\System32\osk.exe.bak" (
    if exist "%APPDATA%\TabTipProxy\TabTipProxy.exe" (
        echo OSK is currently set to: [92mModern Touch (TabTipProxy^)[93m
    ) else (
        echo OSK is currently set to: [93mModern Touch (TabTip^)[93m
    )
)
if not exist "%WINDIR%\System32\osk.exe.bak" (
    echo OSK is currently set to: [95mLegacy OSK[93m
)

timeout /t 10 /nobreak
echo. 
echo [0mPerforming changes...

REM /////////////////////////
REM //     TABTIPPROXY     //
REM /////////////////////////

REM Get .NET Framework version based on OS
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set FrameWork="Framework" || set FrameWork="Framework64"

REM Find JScript.NET compiler
set jsc=NULL
if exist "%SystemRoot%\Microsoft.NET\!FrameWork!\" (
    for /f "tokens=* delims=" %%j in ('dir /b /s /a:-d /o:-n "%SystemRoot%\Microsoft.NET\!FrameWork!\*jsc.exe"') do (
        set "jsc=%%j"
    )
    goto :export
)

if !jsc!==NULL (
    goto :fallback
)

REM Export TabTipProxy to file
:export
if not exist "%APPDATA%\TabTipProxy\" (
    mkdir "%APPDATA%\TabTipProxy\"
)

echo import System;                                                                                 >  "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo import System.Diagnostics;                                                                     >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo.                                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo /*                                                                                             >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo /////////////////////////////////////////////                                                  >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo //     TABTIP PROXY by LULECH23 [v1.0]     //                                                  >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo /////////////////////////////////////////////                                                  >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo.                                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo This script will open and close the modern Windows touch                                       >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo keyboard when run. Must be compiled to EXE to be used as                                       >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo a legacy OSK replacement.                                                                      >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo */                                                                                             >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo.                                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo // Command                                                                                     >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo var cmd = ^"/c \"" +                                                                           >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo // Check for active input process                                                              >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo "if exist \"%%APPDATA%%\\TabTipProxy.lock\" ( " +                                              >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo     // Close input, if open                                                                    >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo     "wmic process where \"name='TextInputHost.exe'\" delete & " +                              >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo     "del /f /q \"%%APPDATA%%\\TabTipProxy.lock\" " +                                           >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo ") else ( " +                                                                                  >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo     // Open input, if closed                                                                   >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo     "wmic process where \"name='TabTip.exe'\" delete & " +                                     >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo     "start \"\" \"%%PROGRAMFILES%%\\Common Files\\microsoft shared\\ink\\TabTip.exe\" & " +    >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo     "echo 1 > \"%%APPDATA%%\\TabTipProxy.lock\" " +                                            >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo ")" +                                                                                          >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo ^"\"";                                                                                         >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo.                                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo // Settings                                                                                    >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo var s = new System.Diagnostics.ProcessStartInfo("cmd.exe", cmd);                               >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo s.CreateNoWindow = true;                                                                       >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo s.UseShellExecute = true;                                                                      >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo s.WindowStyle = ProcessWindowStyle.Hidden;                                                     >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo.                                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo // Process                                                                                     >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo var p = new System.Diagnostics.Process;                                                        >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo p.StartInfo = s;                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo.                                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo // Run process                                                                                 >> "%APPDATA%\TabTipProxy\TabTipProxy.js"
echo p.Start();                                                                                     >> "%APPDATA%\TabTipProxy\TabTipProxy.js"

REM Compile TabTipProxy
"!jsc!" /nologo /t:winexe /out:"%APPDATA%\TabTipProxy\TabTipProxy.exe" "%APPDATA%\TabTipProxy\TabTipProxy.js"

set proxy="%APPDATA%\TabTipProxy\TabTipProxy.exe"
goto :replace

REM Use vanilla TabTip if .NET Framework was not found
:fallback
echo.
echo Could not find ^.NET Framework^. Skipping TabTipProxy^. Some functionality will be reduced^.
set proxy="%PROGRAMFILES%\Common Files\microsoft shared\ink\TabTip.exe"

REM Set vanilla TabTip to auto-invoke when run
reg add HKLM\SOFTWARE\Microsoft\TabletTip\1.7 /t REG_DWORD /v EnableDesktopModeAutoInvoke /d 1 /f

REM /////////////////////////
REM //     REPLACE OSK     //
REM /////////////////////////

:replace
if not exist "%WINDIR%\System32\osk.exe.bak" (
    REM Take ownership of legacy OSK
    takeown /f "%WINDIR%\System32\osk.exe" /a
    echo.
    icacls "%WINDIR%\System32\osk.exe" /grant administrators:F
    echo.

    REM Backup original OSK application
    ren "%WINDIR%\System32\osk.exe" "osk.exe.bak"

    REM Link modern touch OSK in place of legacy OSK
    mklink "%WINDIR%\System32\osk.exe" !proxy!

    REM Close TextInputHost to prepare for TabTipProxy
    wmic process where "name='TextInputHost.exe'" delete

    REM End process, we're done!
    echo.
    echo Legacy OSK replaced with modern touch keyboard^.
    if !jsc!==NULL (
        echo.
        echo Please sign out of Windows to finish applying changes to the system^.
    )
) else (
    REM Delete modern touch OSK proxy
    del /f /q "%APPDATA%\TabTipProxy\TabTipProxy*"
    del /f /q "%WINDIR%\System32\osk.exe"

    REM Restore original OSK application
    ren "%WINDIR%\System32\osk.exe.bak" "osk.exe"
    
    REM Reset TabTip auto-invoke behavior
    echo.
    reg add HKLM\SOFTWARE\Microsoft\TabletTip\1.7 /t REG_DWORD /v EnableDesktopModeAutoInvoke /d 0 /f

    echo.
    echo Legacy OSK restored^.
)

echo.[93m
pause