# Awesome WM

The main config is in **rc.lua** - this is the file *awesome* expects. Everything is included into it with `require("folder.module")` directives. Things you can change there are at the end of the file: *useless gaps*, *autorun* location.

* **mytheme.lua** - theme file with colors and stuff;

* **main** module:
* * *user-variables* - define whatever you want to use;
* * *menu* - what shows up in the main menu (on the left of the main panel);
* * *tags* - what workspaces (virtual screens?) do you have;
* * *layouts* - what window layouts do you use;
* * *rules* - special parameters for specific windows;
* * *signals* - reaction to events in the WM;
* * *error-handling* - nuff said (don't touch without a solid reason);

* **binding** module:
* * *clientbuttons* - windows' reactions to mouse buttons;
* * *clientkeys* - windows' reactions to keyboard keys, e.g.:
* * * `Super+Q` - close the window;
* * * `Super+M` - maximize the window;
* * * `Super+Ctrl+Space` - toggle *floating* state for the window;
* * *globalbuttons* - the WM's reactions to mouse buttons;
* * *globalkeys* - the WM's reactions to keyboard keys, e.g.:
* * * `Super+S` - show help (all the keybindings);
* * * `Super+W` - spawn the main menu (like the one on the left of the main panel);
* * * `Super+D` - spawn the apps launcher (rofi);
* * * `Super+R` - prompt to launch a program;
* * * `Alt+Shift` - change the keyboard layout;
* * * `Super+Shift+Arrows` - move the focused window around;
* * * `Super+Ctrl+R` - restart *awesome* (to reload the config);

* **deco** module:
* * *statusbar* - the main panel with all the widgets;
* * *taglist* - workspace buttons;
* * *tasklist* - "what windows do you have open on this workspace" buttons;
* * *titlebar* - the title bar above every window;
* * *wallpaper* - fallback wallpaper (when you don't have *nitrogen*);
* * *widgets* - a collection of customized widgets to use on the main panel:
* * * keyboard layout (see **widgets.keyboard_layout**);
* * * system tray (for background programs, like *nm-applet*);
* * * text clock;

* **widgets** module:
* * [keyboard layout](https://github.com/echuraev/keyboard_layout);
* * [battery](https://github.com/streetturtle/awesome-wm-widgets/tree/master/battery-widget);
* * [volume](https://github.com/streetturtle/awesome-wm-widgets/tree/master/volume-widget);
