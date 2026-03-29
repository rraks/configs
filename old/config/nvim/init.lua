-----------------------------------
-- rraks' NeoVim setup
------------------------------------

--
-- Imports
--

require('general')
require('keybindings')
require('plugins')
require('treesitter')
require('lsp')
require('completion')
require('ui')
require('git')
require('misc')
require('tscope')
-- require('aerial')

vim.lsp.set_log_level("debug")
