local actions = require('telescope.actions')
local telescope = require('telescope')
telescope.setup {
  defaults = {
    layout_config = {width = 0.75, prompt_position = "top", preview_cutoff = 120, horizontal = {mirror = false}, vertical = {mirror = false}},
    find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
    prompt_prefix = " ",
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default + actions.center
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
      }
    }
  },
  extensions = {
    aerial = {
      -- How to format the symbols
      format_symbol = function(symbol_path, filetype)
        if filetype == "json" or filetype == "yaml" then
          return table.concat(symbol_path, ".")
        else
          return symbol_path[#symbol_path]
        end
      end,
      -- Available modes: symbols, lines, both
      show_columns = "both",
    },
  }
}


vim.api.nvim_set_keymap('n', '<leader><leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader><leader>f', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader><leader>l', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader><leader>h', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader><leader>r', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader><leader>d', [[<cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<CR>]], { noremap=true, silent=true })
