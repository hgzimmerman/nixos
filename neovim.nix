{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    (neovim.override {

      vimAlias = true;

      configure = {
        customRC = ''

          " set up powerline
          let g:airline_powerline_fonts = 1
          let g:airline_theme = 'gruvbox'
          " set up NERDTree
          nnoremap <C-t> :NERDTreeToggle <CR>

          " set up ctrl-p
          let g:ctrlp_working_path_mode = 'ra' " I think this starts search in the current directory, then looks for a .git (project root)
          let g:ctrlp_map = '<c-p>'
          let g:ctrlp_cmd = 'CtrlP'

          if executable('rg')
            set grepprg=rg\ --color=never
            let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
            let g:ctrlp_use_caching = 0
          endif
          
          " set up deoplete
          let g:deoplete#enable_at_startup = 1

          " deoplete rust/racer
          let g:deoplete#sources#rust#racer_binary='/home/hzimmerman/.cargo/bin/racer'
          let g:deoplete#sources#rust#rust_source_path='/home/hzimmerman/rust/src'

          " Theme
          " colorscheme spacegray
          colorscheme gruvbox
          set background=dark
         let g:gruvbox_invert_indent_guides=1

         " let g:spacegray_underline_search = 1
         " let g:spacegray_italicize_comments = 1


          " set up font indentation markers
          let g:indent_guides_enable_on_vim_startup = 1
          " hi IndentGuidesOdd  ctermbg=Black
          " hi IndentGuidesEven ctermbg=DarkGrey

          " Hide highlights for spelling and underline them instead
          hi clear SpellBad
          hi clear SpellCap
          hi clear SpellRare
          hi SpellBad cterm=underline,bold
          hi SpellCap cterm=underline

          let g:ycm_autoclose_preview_window_after_insertion = 0
          let g:ycm_python_binary_path = '/usr/bin/env python3'

          " config=======================================================================

          set guicursor= " fixes terminator
          
          set number " toggle with <C-n>

          set autochdir " change the dir to the working initial file

          set clipboard=unnamedplus " Clipboard integration (requires xsel or xclip to be installed.)

          let &colorcolumn="81,121,".join(range(161,999),",") " Creates vertical lines
          set list lcs=trail:·,tab:»· " show whitespace

          setlocal spell spelllang=en_us " Enable spell checking (<z=> on misspelled word)

          set mouse=a


          " remap ; to :
          nnoremap ; :
          nnoremap : ;

          :imap <M-Space> <Esc> " remap Alt+Space to ESC
          :inoremap <C-CR> <Esc> "remap Shift+Enter to ESC

          set expandtab " Set tab to input spaces
          set shiftwidth=4 " Set number of spaces for indentation
          set tabstop=4    " Set number of spaces for a tab

          "escape from sudo
          cmap w!! w !sudo tee > /dev/null %

          set cursorline cursorcolumn " set a vertical line along where the cursor is


          " Neovim has a problem regarding backspace = <C-H>, so when backspace is entered, do <C-H>
          if has('nvim')
            nmap <BS> <C-W>h
          endif

          " rebind the switch pane commands
          nnoremap <C-J> <C-W><C-J>
          nnoremap <C-K> <C-W><C-K>
          nnoremap <C-L> <C-W><C-L>
          nnoremap <C-H> <C-W><C-H>

          " Remember last position
          if has("autocmd")
            au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
          endif
          '';
          vam.pluginDictionaries = [
            { names = [
          #  "Spacegray-vim"
          # "youcompleteme"
            "vim-addon-nix"
            "calendar-vim"  
            "The_NERD_tree" 
            "vim-airline" 
            "vim-airline-themes"
            "vim-gitgutter"
            "vim-indent-guides"
            "ctrlp-vim"
            #"neocomplete-vim"
            #"deoplete"
            "deoplete-rust"
            "deoplete-nvim"
            "rust-vim"
            #"vim-racer"
            "latex-live-preview"
            "rainbow_parentheses"
            "vim-colorschemes"
            "Supertab"
            "gruvbox"
            ]; }
        ];
      };
    })
  ];
}
