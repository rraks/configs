# Neovim setup guide


## Install neovim
1. The easy way is to download and use an AppImage 
` cd ~/.local/share/ && mkdir -p nvim` 
` curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage` 
` chmod u+x nvim.appimage` 
` sudo ln -s /home/<username>/.local/share/nvim/nvim.appimage `

2. The hard way is to install from [source](https://github.com/neovim/neovim/wiki/Installing-Neovim)

## Install vim-plug
I use vim-plug as my vim plugin manager 
` sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
`

## Configure
1. Install plugins 
`nvim `
` :PlugInstall`
2. The above will install coc.nvim which is the completion manager I use. Install any language server from [here](https://github.com/neoclide/coc.nvim/wiki/Language-servers) 
   For e.g, for python 
   ` :CocInstall coc-python`

