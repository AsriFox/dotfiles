# AsriFox's dotfiles
Heavily WIP

### Programs used:
* **shell**: zsh
* **window manager**: [awesome](https://awesomewm.org/) / [qtile](http://www.qtile.org/)
* **compositor**: picom
* **terminal**: alacritty
* **notifications**: dunst
* **launcher**: [rofi](https://github.com/davatorium/rofi)
* **display configuration**: arandr
* **wallpaper setter**: nitrogen

Auxiliary:
* **network**: NetworkManager ([archwiki](https://wiki.archlinux.org/title/NetworkManager), [ubuntu](https://www.ubuntuupdates.org/package/core/jammy/main/base/network-manager-applet))
* **sound control**: amixer, pacmd (for *pulseaudio*)
* **battery**: acpi

* *shell theme*: [powerlevel10k](https://github.com/romkatv/powerlevel10k)
* *rofi theme*: arthur (included in *rofi-theme-selector*)

### Included configs:
* awesome
* qtile
* picom (shadows are disabled for window gaps to shine)
* alacritty (background transparency requires running *picom -b*)

### Scripts:
* *autorun* - the programs to launch at session startup
* *screenlayout* - example of *xrandr* display configuration. Save the output from *arandr* to this file and launch it before *nitrogen* and such, especially if you have more than one monitor.
