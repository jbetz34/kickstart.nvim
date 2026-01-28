-- lua/config/lazy.lua
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- Phase 1: VeryLazy / background plugins
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require 'config.which-key'()
    end,
  },
  {
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      require 'config.mini'()
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    event = 'VeryLazy',
    config = function()
      require 'config.colorscheme'()
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    event = 'VeryLazy',
    config = function()
      require 'config.colorscheme'()
    end,
  },
  {
    'tokyonight.nvim',
    event = 'VeryLazy',
    config = function()
      require 'config.colorscheme'()
    end,
  },
  {
    'vscode.nvim',
    event = 'VeryLazy',
    config = function()
      require 'config.colorscheme'()
    end,
  },

  -- Phase 2: On-demand / filetype / command
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require 'config.treesitter'
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'config.lsp'
    end,
  },
  {
    'williamboman/mason.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'config.lsp'
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'config.lsp'
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'config.lsp'
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'config.telescope'
    end,
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', dependencies = { 'telescope.nvim' } },
  { 'nvim-telescope/telescope-ui-select.nvim', dependencies = { 'telescope.nvim' } },

  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require 'config.gitsigns'
    end,
  },

  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    config = function()
      require 'config.snippets'
    end,
  },
  {
    'blink.cmp',
    event = 'InsertEnter',
    dependencies = { 'nvim-lspconfig', 'LuaSnip' },
    config = function()
      require 'config.snippets'
    end,
  },

  { 'folke/todo-comments.nvim', event = 'VimEnter' },

  -- Rare / manual
  {
    'olimorris/codecompanion.nvim',
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionActions' },
    keys = { { '<leader>cc', '<cmd>CodeCompanionChat<cr>' } },
    dependencies = { 'plenary.nvim', 'nvim-treesitter' },
  },
  {
    'stevearc/conform.nvim',
    cmd = 'Conform',
    keys = { {
      '<leader>f',
      function()
        require('conform').format()
      end,
    } },
    event = 'BufWritePre',
  },
  { 'mkitt/render-markdown.nvim', ft = { 'markdown' }, dependencies = { 'codecompanion.nvim' } },
}
