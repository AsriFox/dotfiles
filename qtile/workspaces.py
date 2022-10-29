from libqtile import layout, bar, widget
from libqtile.config import Group, Screen
from libqtile.core.manager import Qtile
from typing import Callable

groups = [Group(i) for i in "12345678"]

def go_to_group(name: str) -> Callable:
    def _inner(qtile: Qtile):
        qtile.groups_map[name].cmd_toscreen()
    return _inner

layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Max(),
    # layout.Stack(num_stacks=2),
    layout.Bsp(margin=8),
    # layout.Matrix(),
    layout.MonadTall(margin=8),
    layout.MonadWide(margin=8),
    # layout.RatioTile(),
    layout.Tile(margin=8),
    # layout.TreeTab(),
    layout.VerticalTile(margin=8),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="iosevka bold",
    fontsize=12,
    padding=3,
)

topbar = bar.Bar(
    [
        widget.CurrentLayoutIcon(
            scale=0.8
        ),
        widget.GroupBox(
            highlight_method='block'
        ),
        widget.Prompt(),
        widget.WindowName(),
        widget.Chord(
            chords_colors={
                "launch": ("#ff0000", "#ffffff"),
            },
            name_transform=lambda name: name.upper(),
        ),
        widget.TextBox("asrifox",
            foreground="#d75f5f",
        ),
        widget.Systray(),
        widget.Clock(
            format="%Y-%m-%d %a %H:%M:%S",
        ),
    ],
    24,
    background = '#00000000',

    #border_width=[8, 8, 8, 8],  # Draw top and bottom borders
    #border_color=["00000000", "00000000", "00000000", "00000000"]
)

screens = [
    Screen(
        top=topbar,
        wallpaper = '/home/asrifox/Pictures/1190273.png',
        wallpaper_mode = 'fill'
    ),
]
