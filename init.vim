" settings to bootstrap dein
let g:settings = {}
let g:settings.cache_dir = expand('~/.config/nvim')
let g:settings.plugins_dir = g:settings.cache_dir . '/dein'
let g:settings.plugin_manager_dir = g:settings.plugins_dir . '/repos/github.com/Shougo/dein.vim'

" bootstrap dein
if !filereadable(g:settings.plugin_manager_dir . '/README.md')
  if executable('git')
    echo "Installing dein.vim ..."
    execute printf('!git clone %s://github.com/Shougo/dein.vim --depth 1',
        \ (exists('$http_proxy') ? 'https' : 'git'))
        \ expand(g:settings.plugin_manager_dir)
  else
      echohl WarningMsg | echom "You need to install git!" | echohl None
  endif
endif

" let vim load dein
if has('vim_starting')
  exec 'set runtimepath^='.g:settings.plugin_manager_dir
endif

if dein#load_state(g:settings.plugins_dir)
  call dein#begin(g:settings.plugins_dir)
  call dein#add(g:settings.plugin_manager_dir)
  call dein#add("iCyMind/NeoSolarized")
  call dein#end()
  call dein#save_state()
endif

" automatically install missing plugins
if dein#check_install()
  call dein#install()
endif

" basic visual options
set cursorline
set lazyredraw
set termguicolors
set background=dark
set ruler
set scrolloff=8
set showcmd
set showmatch

colorscheme NeoSolarized

" whitespace options
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set shiftround
set smartindent

" clipboard options
set clipboard=unnamedplus
inoremap jj <esc>
inoremap kk <esc>

filetype plugin indent on
