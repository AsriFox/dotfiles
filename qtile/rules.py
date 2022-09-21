from libqtile.layout import Floating
from libqtile.config import Match

floating_layout = Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *Floating.default_float_rules,
        Match(wm_class="confirmreset"),     # gitk
        Match(wm_class="makebranch"),       # gitk
        Match(wm_class="maketag"),          # gitk
        Match(wm_class="ssh-askpass"),      # ssh-askpass
        Match(title="branchdialog"),        # gitk
        Match(title="pinentry"),            # GPG key password entry
        Match(wm_class="WP", title="WP"),   # Wallpaper
    ]
)
