local dashboard = require "alpha.themes.dashboard"
local function header()
  return {
    [[                                                                    ]],
    [[     _/      _/  _/_/_/_/    _/_/    _/      _/  _/_/_/  _/      _/ ]],
    [[    _/_/    _/  _/        _/    _/  _/      _/    _/    _/_/  _/_/  ]],
    [[   _/  _/  _/  _/_/_/    _/    _/  _/      _/    _/    _/  _/  _/   ]],
    [[  _/    _/_/  _/        _/    _/    _/  _/      _/    _/      _/    ]],
    [[ _/      _/  _/_/_/_/    _/_/        _/      _/_/_/  _/      _/     ]],
    [[                                                                    ]],
	}
end
dashboard.section.header.val = header()

local function footer()
  local total_plugins = #vim.tbl_keys(packer_plugins)
  local datetime = os.date "%d-%m-%Y | %H:%M:%S"
  local plugins_text = "\t" .. total_plugins .. " plugins | " .. datetime

  local fortune = require "alpha.fortune"
  local quote = table.concat(fortune(), "\n")
    
  return plugins_text .. "\n" .. quote
end
dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Constant"
dashboard.section.header.opts.hl = "Include"
dashboard.opts.opts.noautocmd = true

require("alpha").setup(dashboard.opts)
