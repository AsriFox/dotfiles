# Qtile WM

The main config is in **config.py** - this is the file *qtile* expects. Everything is included into it with `from module import stuff` directives. Things you can change there:
* Startup scripts (*startup_once* hook);
* Window rules (*client_new* hook);
* Global parameters (e.g. "window focus follows mouse"); etc.

* **bindings** module - all the keybindings are here:
* * `Super+Q` - close the window;
* * `Super+D` - spawn the apps launcher (rofi);
* * `Super+R` - prompt to launch a program;
* * `Super+Shift+Arrows` - move the focused window around;
* * `Super+Ctrl+R` - restart *awesome* (to reload the config);

* **workspaces** module:
* * *groups* - what workspaces (virtual screens?) do you have;
* * *layouts* - what window layouts do you use;
* * *screens* - location and content of panels on your screens (see *arandr* for clarification);

* **rules** - special parameters for specific windows (basically, which ones are floating by default);
