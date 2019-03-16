AGS 3.2.1 Runtime for Mac OS X
Alpha 1
Unofficial Release Build by Edmundo Ruiz

Yes, this is UNOFFICIAL. This build only exists for testing and
assessing what works and doesn't work on Mac OS X. It is not
intended for distributing your game on mac. Please be patient
until we work out all the kinks and provide an official version!

Thanks to Steve McCrea for the original Mac port work and to
to bero and Electroshokker for their work the linux build!
Without them, this wouldn't really exist.

To Run:
0. You must have an AGS game that was compiled in AGS 3.2.1
1. Copy the files ags, acsetup.cfg, liballeg.4.4.1.dylib, and liballeg.4.4.dylib to the game's folder 
2. Open the Terminal (Applications -> Utilities -> Terminal)
3. Navigate to the game folder in the terminal
4. To run the game type:
./ags <GameExecutableName>.exe

Example:
Let's say you're trying to run DemoGame.exe, and it's located on your
Desktop under the folder Demo Game/:

- Copy the files ags and acsetup.cfg to the Demo Game/ folder.
- Open the Terminal (in Applications -> Utilities -> Terminal)
- Once a terminal window opens, you can type followed by enters:
cd ~/Desktop/Demo\ Game/
./ags DemoGame.exe

You can quit the game anytime with Command + Quit

After you're done you can exit the terminal by typing
exit (followed by enter)
And quitting the Terminal application.


Saved Games:
To follow the OS X convention, saved games will be saved in:
~/Library/Application Support/<Game Name>/


Known Issues:
- Not very user friendly method to run a game
- No graphical game setup application exists. To modify game settings, you can
open the acsetup.cfg file in a text editor and change values manually
- No CD Audio Support
- No Video Support
- No Midi Support
- No Plug-in Support
- Right clicking may only work on USB mouses. For trackpads and Bluetooth mice,
use Ctrl+Click instead
- Certain keyboard characters are messed up. For example, backspace throws strange
characters!
- Switching away from the app and back may cause mouse sync issues.
- System cursor is always visible
- Supports Mac OS X 10.6. It's unknown how what other versions it supports at this time.
- Unknown on whether it's Universal application
- CPU Usage is kind of high (may just be AGS in general)
- It's 32-bit. 64-bit support is not possible at this time
- Allegro uses old graphics libraries. You may see this message: "Warning once: This
application, or a library it uses, is using NSQuickDrawView, which has been
deprecated. Apps should cease use of QuickDraw and move to Quartz."
