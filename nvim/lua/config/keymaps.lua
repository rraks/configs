-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true }
local keymap = vim.api.nvim_set_keymap

local function nkeymap(key, map)
  keymap("n", key, map, opts)
end

-- Saving
keymap("n", "<c-s>", ":w<CR>", {})
keymap("i", "<c-s>", "<Esc>:w<CR>a", {})

-- Clear highlight
nkeymap("<c-h>", ":nohlsearch<Bar>:echo<CR>")

-- Don't jump on star *
keymap("n", "*", "*``", {})
