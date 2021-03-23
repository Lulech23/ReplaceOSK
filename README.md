# ⌨ ReplaceOSK
Replace the legacy Windows 10 on-screen keyboard with a more modern virtual input method!

## About
Since Windows 8, Microsoft has been building a modern virtual input method for touch-based devices inspired by smartphone conventions. Unfortunately, as with many parts of Windows, legacy components continue to linger in the recesses of the operating system. One such component is the legacy OSK, an XP-era on-screen keyboard meant for mice, not fingers. This can be an annoyance when working with some touch-based devices that default to the legacy OSK, so why not get rid of it?

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
Windows touch input is handled by a UWP application called `TextInputHost.exe`. A classic win32 application called `TabTip.exe` is used to invoke the on-screen keyboard. However, replacing the legacy OSK with `TabTip.exe` has some caveats: a registry modification is required (and therefore reboot), and it can only be used to open, not close, the keyboard.

To solve these issues, TabTipProxy was created to act as a middleman between ReplaceOSK and `TabTip.exe`. If a suitable .NET Framework is available when running `ReplaceOSK.bat`, TabTipProxy will be generated and compiled as Visual Basic on the user's own machine. This avoids potential issues with Windows treating any invisible application as a virus threat and keeps ReplaceOSK as a project transparent and lightweight.

While TabTipProxy provides a much better experience than vanilla TabTip, if a Visual Basic .NET compiler can't be found on the host PC, ReplaceOSK will fallback to vanilla TabTip instead. The type of installation used will be indicated both during the initial ReplaceOSK operation and in subsequent runs of the Batch script.

## Known Issues
* **TabTipProxy fails to invoke when keyboard was previously closed with X button instead of TabTipProxy**
    * Windows does not normally remove TabTip or TextInputHost from memory when closed. There is no known way to detect when the keyboard has been closed via X at this time, so TabTipProxy will assume the keyboard is still open and close it instead (even if it is technically already closed).
    * Workaround: if running TabTipProxy seems to have no effect the first time, run it again.