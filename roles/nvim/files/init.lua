-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


local o = vim.o

o.background = 'dark'   -- Dark background
o.termguicolors = true  -- Enable 256 colors
o.signcolumn = 'yes'    -- Always show signcolumn
-- Set highlight on search
o.hlsearch = false
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
o.clipboard = 'unnamedplus'
-- Save undo history
o.undofile = true
-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

--Show line numbers
o.number = true

--Show relative numbers
o.relativenumber = true

--Highlight current line
o.cursorline = true

o.cmdheight = 2

--Tabs -> Spaces, Tab == 2 Spaces
o.expandtab = true
o.smarttab = true
o.shiftwidth = 2
o.tabstop = 2
--Copy indent from previous line to newline
o.autoindent = true
o.cindent = true

--Spelling
o.spell = true
o.spelllang = 'en_us'

require('lazy').setup({
    'ThePrimeagen/vim-be-good',
    -- Appearance
    {
      'folke/tokyonight.nvim',
      lazy = false,
      priority = 1000,
      config = function()
        require('tokyonight').setup {
          style = 'night',
        }
        vim.cmd('colorscheme tokyonight')
      end
    },
    {
	    -- Set lualine as statusline
	    'nvim-lualine/lualine.nvim',
	    -- See `:help lualine.txt`
	    opts = {
		    options = {
			    theme = 'tokyonight',
		    },
	    },
    },
    -- pending keybinds
    { 'folke/which-key.nvim', opts = {} },
})

--Key binds

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--Half page, center after move

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

