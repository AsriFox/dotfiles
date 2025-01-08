# Session variables
set -gx QT_QPA_PLATFORM wayland
set -gx XCURSOR_SIZE 32
set -gx _JAVA_AWT_WM_NONREPARENTING 1

status is-interactive; and begin
    fish_config theme choose "Catppuccin Macchiato"
    set -g fish_greeting 'Catfish deployed'
end
