# ⌨ ReplaceOSK
Replace the legacy Windows 10 on-screen keyboard with a more modern virtual input method!

## About
Since Windows 8, Microsoft has been building a modern virtual input method for touch-based devices inspired by smartphone conventions. Unfortunately, as with many parts of Windows, legacy components continue to linger in the recesses of the operating system. One such component is the legacy OSK, an XP-era on-screen keyboard meant for mice, not fingers. This can be an annoyance when working with some touch-based devices that default to the legacy OSK, so why not get rid of it?

#### Did you know?
The Windows on-screen keyboard can be triggered any time by sending `Win + Ctrl + O`!

## How to Use
ReplaceOSK is comprised of two components: **ReplaceOSK**, and **TabTipProxy**. Using TabTipProxy is optional, but strongly recommended. TabTipProxy will be used by default if a suitable [.NET Runtime](https://dotnet.microsoft.com/download) is available on the host PC (most installations of Windows 10 should include this by default). At this time, >=4.8 is recommended.

#### To Install:
1. Download the latest version of ReplaceOSK from [releases](https://github.com/Lulech23/ReplaceOSK/releases). 
2. Run `ReplaceOSK.bat`.

#### To Uninstall:
1. Run `ReplaceOSK.bat` again and it'll undo all changes to your system.

#### To Update:
1. Run `ReplaceOSK.bat` to uninstall previous versions
2. Run `ReplaceOSK.bat` again to install the new version

Note that changes made by ReplaceOSK are permanent until uninstalled, so you do not need to keep downloaded files on your PC after installation.

### About TabTipProxy
Windows touch input is wildly overcomplicated. A classic win32 application called `TabTip.exe` is used to invoke the touch keyboard automatically under certain conditions. This involves spawning a UWP application called `TextInputHost.exe` and multiple child processes that go by different handles including `IPTip_Main_Window` and `IFrameworkInputPane`, each with their own properties and methods. This makes `TabTip.exe` an unreliable entry point for triggering touch input manually. And even when it works, it can only be used to open, not close the keyboard.

To solve these issues, TabTipProxy was created to act as a middleman between `TabTip.exe` and its child processes. If a suitable .NET Framework is available when running `ReplaceOSK.bat`, TabTipProxy will be generated and compiled as Visual Basic on the user's own machine. This avoids potential issues with Windows treating any invisible application as a virus threat and keeps ReplaceOSK as a project transparent and lightweight.

While TabTipProxy provides a much better experience than vanilla TabTip, if a Visual Basic .NET compiler can't be found on the host PC, ReplaceOSK will fallback to vanilla TabTip instead. The type of installation used will be indicated both during the initial ReplaceOSK operation and in subsequent runs of the Batch script.

## Known Issues
* **TabTipProxy sometimes fails to invoke when a physical keyboard is attached**
    * Workaround: Click outside an input area before triggering OSK (the taskbar is usually a safe place)