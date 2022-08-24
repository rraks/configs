local configs = require 'nvim-treesitter.configs'
configs.setup {
  ensure_installed = "maintained", -- Only maintained parsers allowed
  highlight = { 
    enable = true,
  },
  indent = {
    enable = false,
  }
}
