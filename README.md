# ReplaceOSK
Replace the legacy Windows 10 on-screen keyboard with a more modern virtual input method

## About
Since Windows 8, Microsoft has been slowly building a modern virtual input method for touch-based Windows devices inspired by the designs of smartphone keyboards. Unfortunately, as with many parts of Windows, legacy components continue to linger in the recesses of the operating system. One such component is the legacy OSK, an XP-era on-screen keyboard meant for mice, not fingers. This can be an annoyance when working with some touch-based devices that default to the legacy OSK, so why not get rid of it?

## How to Use
[ReplaceOSK](https://github.com/Lulech23/ReplaceOSK/blob/main/ReplaceOSK.bat) is a simple Batch file which will replace the legacy OSK with TabTip, Microsoft's modern keyboard, at the system level. Simply download and run it and it'll take care of the rest.

Decide ReplaceOSK isn't for you? Run it again and it'll undo all changes to your system.

## Known Issues
TabTip may be an infinitely superior input method to the legacy OSK, but it's not without its quirks. Since the Anniversary Update to Windows 10, running TabTip only loads the application into memory. To open the keyboard requires a separate invokation from whatever application is requesting input. This is problematic, since the whole purpose of the legacy OSK was to be opened on-demand. To solve this, ReplaceOSK uses a Registry key to inform TabTip to auto-invoke itself when launched. **This workaround will only function if no physical keyboard is present.** Unfortunately, ReplaceOSK is not suitable for use as a supplement to a physical keyboard.

Also, because Windows doesn't allow restarting `TabletInputService` live, you'll have to log out of your Windows session and back in for Registry changes to apply.
