set number
set tabstop=4
set shiftwidth=4
set expandtab
set encoding=UTF-8
set formatoptions-=t
set mouse=a
set termguicolors
set background=dark

set guifont=RobotoMono\ NF:h8

set guicursor+=i:hor20-Cursor/lCursor

call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'andweeb/presence.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'ryanoasis/vim-devicons'
Plug 'tikhomirov/vim-glsl'
Plug 'yamatsum/nvim-cursorline'
Plug 'goolord/alpha-nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'rebelot/kanagawa.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'kevinhwang91/nvim-hlslens'

call plug#end()

colorscheme kanagawa

" Neovide config
let g:neovide_transparency=0.90
let g:neovide_cursor_antialiasing=v:true

map ` :NvimTreeToggle<Cr>
map < :BufferLineCyclePrev<Cr>
map > :BufferLineCycleNext<Cr>
map E :CocCommand clangd.inlayHints.toggle<Cr>
map <C-p> :Telescope find_files<Cr>

autocmd VimEnter * NeoscrollEnableGlobalPM

lua << END

-- Search setup
require('hlslens').setup({
    calm_down = true,
    nearest_only = true,
    nearest_float_when = 'always'
})

-- Indent line setup
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- Smoothscroll
require('neoscroll').setup()

-- Startup
require'alpha'.setup(require'alpha.themes.dashboard'.config)

-- Cursorline
require('nvim-cursorline').setup {
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}

-- Bufferline
require("bufferline").setup{}

-- Statusline
require('lualine').setup{
sections = {
  lualine_a = {
    {
      'mode',
      icons_enabled = true,
      icon = nil,
      separator = "|",
      cond = nil,           -- Condition function, the component is loaded when the function returns `true`.
      color = nil, -- The default is your theme's color for that section and mode.
      type = nil,
      padding = 1, -- Adds padding to the left and right of components.
      fmt = nil,   -- Format function, formats the component's output.
    }
  }
}
}

-- Autopairs
require("nvim-autopairs").setup {}

-- Treesitter
require 'nvim-treesitter.install'.compilers = { "gcc" }

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "rust" },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}

END
