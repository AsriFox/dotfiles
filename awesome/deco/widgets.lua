local awful = require("awful")
local wibox = require("wibox")

-- Keyboard layout
local keyboard_layout = require("widgets.keyboard_layout")
kbdcfg = keyboard_layout.kbdcfg({type='tui'})
kbdcfg.add_primary_layout("English", "US", "us")
kbdcfg.add_primary_layout("Русский", "RU", "ru(typewriter)")
kbdcfg.bind()
-- Mouse bindings
kbdcfg.widget:buttons(
 awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch_next() end),
                       awful.button({ }, 3, function () kbdcfg.menu:toggle() end))
)

-- Systray widget
mysystray = wibox.widget.systray()
mysystray:set_base_size(20)

-- Create a textclock widget
format = "%H:%M:%S"
refresh = 1
mytextclock = wibox.widget.textclock(format, refresh)
mytextclock.font = "Monospace 8"
