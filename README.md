# AsriFox's dotfiles
Heavily WIP

### Programs used:
* **shell**: bash
* **window managers**: 
    * [hyprland](https://hyprland.org/)
    * [qtile](http://www.qtile.org/)
    * [openbox](http://openbox.org/)
    * [awesome](https://awesomewm.org/)
* **compositor**: [picom](https://github.com/jonaburg/picom)
* **terminal**: kitty / alacritty
* **notifications**: dunst
* **bar**: tint2 (openbox) / polybar (hyprland)
* **launcher**: [rofi](https://github.com/davatorium/rofi) / [wofi](https://hg.sr.ht/~scoopta/wofi)
* **display configuration**: arandr / wev
* **wallpaper setter**: nitrogen / hyprpaper

Auxiliary:
* **AUR helper**: [Amethyst](https://getcryst.al/site/docs/amethyst/getting-started)
* **network**: NetworkManager ([archwiki](https://wiki.archlinux.org/title/NetworkManager), [ubuntu](https://www.ubuntuupdates.org/package/core/jammy/main/base/network-manager-applet))
* **sound control**: amixer, pavucontrol (for *pulseaudio*)
* **battery**: acpi

* *shell theme*: [powerlevel10k](https://github.com/romkatv/powerlevel10k)
* *rofi theme*: customized *gruvbox-dark-soft*

### Scripts:
* *autorun* - the programs to launch at session startup
* *screenlayout* - example of *xrandr* display configuration. Save the output from *arandr* to this file and launch it before *nitrogen* and such, especially if you have more than one monitor.
