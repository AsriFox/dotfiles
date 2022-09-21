-- Standard awesome library
local awful = require("awful")

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get ()
  -- Table of layouts to cover with awful.layout.inc, order matters.
  local layouts = {
    awful.layout.suit.fair,             -- 1:
    awful.layout.suit.fair.horizontal,  -- 2:

    awful.layout.suit.tile,             -- 3:
    awful.layout.suit.tile.left,        -- 4:
    awful.layout.suit.tile.bottom,      -- 5:
    awful.layout.suit.tile.top,         -- 6:

    awful.layout.suit.floating,         -- 7/0:

--  awful.layout.suit.spiral,
--  awful.layout.suit.spiral.dwindle,

--  awful.layout.suit.max,
--  awful.layout.suit.max.fullscreen,
--  awful.layout.suit.magnifier,

--  awful.layout.suit.corner.nw,
--  awful.layout.suit.corner.ne,
--  awful.layout.suit.corner.sw,
--  awful.layout.suit.corner.se,
  }

  return layouts
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
