" settings to bootstrap dein
let g:settings = {}
let g:settings.config_dir = expand('~/.config/nvim')
let g:settings.plugins_dir = g:settings.config_dir . '/dein'
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
  call dein#add("simnalamburt/vim-mundo")
  call dein#add("vimlab/split-term.vim")
  call dein#add("tmux-plugins/vim-tmux-focus-events")
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('w0rp/ale')
  call dein#add('lotabout/skim', { 'build': './install --bin' })
  call dein#add('lotabout/skim.vim')
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
set splitbelow
set splitright
set mouse=a

colorscheme NeoSolarized

" search options
set ignorecase smartcase

" whitespace options
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set shiftround
set smartindent
filetype plugin indent on

" clipboard options
set clipboard=unnamedplus

" file and backup options

set autochdir
set autoread

" undo configuration
set undofile
let &undodir = g:settings.config_dir . '/undo'
let g:mundo_right = 1
nnoremap U :MundoToggle<CR>

" Remember cursor position between vim sessions
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif

" python3 bootstrap
let g:settings.python_dir = g:settings.config_dir . '/python'
let g:settings.python3_venv_dir = g:settings.python_dir . '/python3_env'
let g:python3_host_prog = g:settings.python3_venv_dir . '/bin/python'

if !filereadable(g:python3_host_prog)
  if executable('python3')
    echo "Installing python3 neovim integration..."
    if !isdirectory(g:settings.python3_venv_dir)
      call mkdir(g:settings.python3_venv_dir, "p")
    endif
    execute '!python3 -m venv '
        \ expand(g:settings.python3_venv_dir)
    execute printf('!%s -m pip install neovim jedi',
        \ g:python3_host_prog)
  else
      echohl WarningMsg | echom "You need to install python3!" | echohl None
      let g:python3_host_prog = ''
  endif
endif

" deoplete
let g:deoplete#enable_at_startup = 1

" bindings
"
nnoremap ]<Space> o<Esc>
nnoremap [<Space> O<Esc>
inoremap jj <esc>
inoremap kk <esc>
