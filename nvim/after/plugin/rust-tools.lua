local rt = require "rust-tools"

rt.setup {
	server = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = { command = "clippy" },
				inlayHints = { locationLinks = false },
			},
		},
		on_attach = function(_, bufnr)
			vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
			vim.keymap.set('n', '<leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
		end,
	},
}
