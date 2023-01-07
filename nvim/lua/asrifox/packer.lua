vim.cmd [[packadd packer.nvim]]

local function plugins(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-tree/nvim-web-devicons',
		config = function()
			require('nvim-web-devicons').setup {}
		end
	}

	use {
		'nvim-telescope/telescope.nvim',
		tag = '0.1.0',
		requires = {{ 'nvim-lua/plenary.nvim' }}
	}

	use {
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  }

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}

	use {
		'RRethy/vim-illuminate',
		config = function()
			require("illuminate").configure {}
		end
	}

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

  -- use 'simrat39/rust-tools.nvim'
	use 'kdarkhan/rust-tools.nvim'

	use 'mfussenegger/nvim-dap'

	use 'rcarriga/nvim-dap-ui'

	use {
		'akinsho/toggleterm.nvim',
		tag = '*',
	}

	use "folke/which-key.nvim"

	use {
		"folke/trouble.nvim",
		config = function()
			require('trouble').setup {}
		end
	}

	use {
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup()
		end
	}

	use {
		'ellisonleao/gruvbox.nvim',
		config = function()
			require('gruvbox').setup { transparent_mode = true }
			vim.o.background = 'dark'
			vim.cmd('colorscheme gruvbox')
		end
	}

	use 'feline-nvim/feline.nvim'

	use "goolord/alpha-nvim"

	use {
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup {}
		end
	}
end

local packer = require "packer"
packer.init {
	profile = {
		enable = true,
		threshold = 0,
	},
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}
packer.startup(plugins)
