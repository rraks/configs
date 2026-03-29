local configs = require 'nvim-treesitter.configs'
configs.setup {
  highlight = { 
    enable = true,
  },
  indent = {
    enable = false,
  }
}


require('treesitter-context').setup({
  mode = 'topline',
  line_numbers = true,
  max_lines = 8,
})


vim.keymap.set("n", "]c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
