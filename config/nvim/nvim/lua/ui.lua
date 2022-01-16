--
-- Theme
--
vim.go.background = 'dark'
vim.api.nvim_set_var('gruvbox_material_background', 'soft')
vim.cmd([[colorscheme gruvbox-material]])


--
-- General
--
vim.o.updatetime = 300
vim.o.signcolumn = "yes"



--
-- LuaLine
--

require('lualine').setup({
  options = {
    theme = 'gruvbox-material',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},

  },
  sections = {
    lualine_a = {
      { 'mode'},
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {},
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic'},
        sections = { 'error', 'warn', 'info', 'hint' },
        diagnostics_color = {
          error = 'DiagnosticError', -- Changes diagnostics' error color.
          warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
          info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
          hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
        },
        symbols = {error = 'ﲅ', warn = '', info = '', hint = '響'},
        colored = false,
        update_in_insert = false,
        always_visible = false,
      }
    },
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location'},
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'filename', 'branch' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
})



