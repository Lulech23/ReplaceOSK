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
echo [96m//     REPLACE OSK by LULECH23 [v2.1]     // [0m
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

REM Find VB.NET compiler
set vbc=NULL
if exist "%SystemRoot%\Microsoft.NET\!FrameWork!\" (
    for /f "tokens=* delims=" %%j in ('dir /b /s /a:-d /o:-n "%SystemRoot%\Microsoft.NET\!FrameWork!\*vbc.exe"') do (
        set "vbc=%%j"
    )
    goto :export
)

if !vbc!==NULL (
    goto :fallback
)

REM Export TabTipProxy to file
:export
if not exist "%APPDATA%\TabTipProxy\" (
    mkdir "%APPDATA%\TabTipProxy\"
)

echo Imports System                                                                                                                                         >  "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo Imports System.Diagnostics                                                                                                                             >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo Imports System.Threading                                                                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo Imports System.Runtime.InteropServices                                                                                                                 >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo.                                                                                                                                                       >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo ' /////////////////////////////////////////////                                                                                                        >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo ' //     TABTIP PROXY by LULECH23 [v2.0]     //                                                                                                        >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo ' /////////////////////////////////////////////                                                                                                        >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo '                                                                                                                                                      >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo ' This script will open and close the modern Windows touch                                                                                             >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo ' keyboard when run. Must be compiled to EXE to be used as                                                                                             >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo ' a legacy OSK replacement.                                                                                                                            >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo.                                                                                                                                                       >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo Module mainModule                                                                                                                                      >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo     Public Class User32                                                                                                                                >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo             ^<DllImport("user32.dll", SetLastError:=True, CharSet:=CharSet.Auto)^> _                                                                   >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo             Public Shared Function SendMessage(ByVal hWnd As IntPtr, ByVal Msg As UInteger, ByVal wParam As IntPtr, ByVal lParam As IntPtr) As Boolean >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo             End Function                                                                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo.                                                                                                                                                       >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo             ^<DllImport("user32.dll", SetLastError:=True, CharSet:=CharSet.Auto)^> _                                                                   >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo             Public Shared Function FindWindow(ByVal lpClassName As String, ByVal lpWindowName As String) As IntPtr                                     >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo             End Function                                                                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo     End Class                                                                                                                                          >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo.                                                                                                                                                       >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo     Sub Main()                                                                                                                                         >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo         Dim WM_SYSCOMMAND As Int32 = 274                                                                                                               >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo         Dim SC_CLOSE As UInt32 = 61536                                                                                                                 >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo         Dim TouchhWnd As New IntPtr(0)                                                                                                                 >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo         TouchhWnd = User32.FindWindow("IPTip_Main_Window", Nothing)                                                                                    >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo.                                                                                                                                                       >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo         If TouchhWnd = 0 Then                                                                                                                          >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo             ' TabTip is closed, open TabTip                                                                                                            >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo             Process.Start(Environ("ProgramFiles") + "\Common Files\Microsoft Shared\ink\TabTip.exe")                                                   >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo         Else                                                                                                                                           >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo             ' TabTip is opened, close TabTip                                                                                                           >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo             User32.SendMessage(TouchhWnd, WM_SYSCOMMAND, SC_CLOSE, 0)                                                                                  >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo         End If                                                                                                                                         >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo     End Sub                                                                                                                                            >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"
echo End Module                                                                                                                                             >> "%APPDATA%\TabTipProxy\TabTipProxy.vb"

REM Compile TabTipProxy
"!vbc!" /nologo /t:winexe /out:"%APPDATA%\TabTipProxy\TabTipProxy.exe" "%APPDATA%\TabTipProxy\TabTipProxy.vb"

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
    if !vbc!==NULL (
        echo.
        echo Please restart Windows to finish applying changes to the system^.
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
    if !vbc!==NULL (
        echo.
        echo Please restart Windows to finish applying changes to the system^.
    )
)

echo.[93m
pause