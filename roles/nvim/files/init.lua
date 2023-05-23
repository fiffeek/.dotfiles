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

require('lazy').setup({
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
    -- pending keybinds
    { 'folke/which-key.nvim', opts = {} },
})
