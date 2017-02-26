{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    (neovim.override {

      vimAlias = true;

      configure = {
        customRC = ''

          " set up powerline
          let g:airline_powerline_fonts = 1
          let g:airline_theme = 'tomorrow'
          " set up NERDTree
          nnoremap <C-t> :NERDTreeToggle <CR>

          " set up ctrl-p
          let g:ctrlp_working_path_mode = 'ra' " I think this starts search in the current directory, then looks for a .git (project root)
          let g:ctrlp_map = '<c-p>'
          let g:ctrlp_cmd = 'CtrlP'

          " Theme
          colorscheme spacegray
          set background=dark
          let g:spacegray_underline_search = 1
          let g:spacegray_italicize_comments = 1


          " set up font indentation markers
          let g:indent_guides_enable_on_vim_startup = 1
          hi IndentGuidesOdd  ctermbg=black
          hi IndentGuidesEven ctermbg=darkgrey

          " Hide highlights for spelling and underline them instead
          hi clear SpellBad
          hi clear SpellCap
          hi clear SpellRare
          hi SpellBad cterm=underline,bold
          hi SpellCap cterm=underline

          " config=======================================================================

          set number " toggle with <C-n>

          set autochdir " change the dir to the working initial file

          set clipboard=unnamedplus " Clipboard integration (requires xsel or xclip to be installed.)

          let &colorcolumn="81,121,".join(range(161,999),",") " Creates vertical lines
          set list lcs=trail:·,tab:»· " show whitespace

          setlocal spell spelllang=en_us " Enable spell checking (<z=> on misspelled word)


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
            "Spacegray-vim"
            "youcompleteme"
            "vim-addon-nix"
            "calendar-vim"  
            "The_NERD_tree" 
            "vim-airline" 
            "vim-airline-themes"
            "vim-gitgutter"
            "vim-indent-guides"
            "ctrlp-vim"
            "neocomplete-vim"
            "rust-vim"
            "vim-racer"
            "latex-live-preview"
            "rainbow_parentheses"
            "vim-colorschemes"
          #  "gruvbox"
            ]; }
        ];
      };
    })
  ];
}
