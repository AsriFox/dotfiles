local whichkey = require "which-key"

local conf = {
	window = {
		border = "single",
		position = "bottom",
	},
}

local opts = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

local mappings = {
  ["w"] = { "<cmd>update!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["t"] = { "<cmd>ToggleTerm<CR>", "Terminal" },
	["g"] = { "<cmd>lua _lazygit_toggle()<CR>", "LazyGit" },

	b = {
		name = "Buffer",
		c = { "<Cmd>bd!<Cr>", "Close current buffer" },
    D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
  },

	z = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

	f = {
		name = "Telescope",
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
  },

	d = {
		name = "Debug",
		d = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
		b = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "Breakpoint" },
		s = {
			name = "Step",
			s = { "<cmd>lua require('dap').step_over()<cr>", "Step over" },
			i = { "<cmd>lua require('dap').step_into()<cr>", "Step into" },
			o = { "<cmd>lua require('dap').step_out()<cr>", "Step out" },
		},
		w = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" },
		e = { "<cmd>lua require('dapui').eval()<cr>", "Evaluate expression" },
	},

	x = {
		name = "Trouble",
		x = { "<cmd>TroubleToggle<cr>", "Toggle window" },
		w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics" },
		d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
		l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
		q = { "<cmd>TroubleToggle quickfix<cr>", "Quick fix" },
	}
}

whichkey.setup(opts)
whichkey.register(mappings, opts)
