----------------------------------
-- rraks' NeoVim setup

-- General keybindings
----------------------------------


local opts = {noremap = true }
local keymap = vim.api.nvim_set_keymap

local function nkeymap(key, map)
  keymap('n', key, map, opts)
end

-- Leader
keymap('', '<Space>', '<Nop>', { noremap = false, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Saving
keymap('n', '<c-s>', ':w<CR>', {})
keymap('i', '<c-s>', '<Esc>:w<CR>a', {})


-- Clear highlight
nkeymap('<c-h>', ':nohlsearch<Bar>:echo<CR>')
