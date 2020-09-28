" ========================================================================================
" BASIC SETUP
" ========================================================================================
 
" -[ DÉSACTIVER LA COMPATIBILITÉ AVEC VI ]----------------------------------------------
set nocompatible

" -[ "ACTIVER GESTION DES PLUGINS NATIVE DE VIM8 ]----------------------------------------
packloadall

" -[ MODIFICATIONS DU VIMRC ACTIVES À LA SAUVEGARDE DU $MYVIMRC ]------------------------
autocmd! bufwritepost $MYVIMRC source %

" -[ RACC. SAVE MANUELLE DE LA PAGE ACTUELLE => SOURCE $MYVIMRC ]-------------------------
map <silent> <F2> <Esc>:write <bar> :source $MYVIMRC<CR>

" -[ MODIFICATION DE L'EMPLACEMENT PAR DÉFAUT DU VIMINFO ]-------------------------------
set viminfo+=n~/.vim/viminfo

" -[ DÉFINITION DE <LEADER> ]------------------------------------------------------------
let mapleader = "²"

" -[ ACTIVATION DES EXTENSIONS DU VIMRC DANS LE DOSSIER ~/.VIM/CONFIG/ ]------------------
runtime! config/**/*.vim

" -[ ACTIVATION DE LA SOURIS ]------------------------------------------------------------
set mouse=a

 
" ========================================================================================
" OPTIONNALS SETTINGS
" ========================================================================================
 
" =[ INDENTATION ]========================================================================
set autoindent            | " Préserve l'indentation de la ligne précédente
set smartindent           | " Petit plus...

" =[  AFFICHAGE ]=========================================================================
set title             	  | " Affiche le titre des fenêtres et terminaux en bas à gauche
set number 		          | " Affiche le numéro des lignes
set ruler                 | " Affiche barre bas à droite la position du curseur
set wrap		          | " Lorsque la ligne est trop longue, l'affiche en dessous

" =[ BEEP/ALERTE ]========================================================================
set belloff=all    	      | " Désactive toutes les alertes sonnores et visuelles

" =[ DIFFSPLIT EN VERTICAL (DEFAUT HORIZONTAL...PAS PRATIQUE) ]===========================
set diffopt=vertical      | " Permet comparaison cote à cote des fichiers

" =[ EMPLACEMENT DU CURSEUR LORS DU SCROLL ]==============================================
set scrolloff=5           | " Garde toujours le curseur à 5lignes du bord de la fenêtre

" =[ COLORATION ]=========================================================================
syntax enable             | " Activation de la coloration syntaxique

" =[ TAB ET LIMITES DU TEXTE ]============================================================
set expandtab             | " Remplace la tabulation par des espaces
set tabstop=4    	      | " Remplace la tabulation par 4 espaces
set shiftwidth=4          | " Elimine le bud d'indentation 8espaces...

" =[ LIMITATION DE LARGEUR DU TEXTE ]=====================================================
set textwidth=90          | " Par defaut, indépendemment du filetype, largeur max = 99!

" =[ RECHERCHES ET SURLIGNAGES DANS LE TEXTE ]============================================
set incsearch             | " Active la recherche et surlignage pendant la saisie du texte
set hlsearch              | " Active le surlignage des correspondance   
set ignorecase            | " Permet d'ignorer la case...
set smartcase             | " ... mais si on met une maj dans la recherche la prend en compte

 
" ========================================================================================
" GENERAL MAPPINGS
" ========================================================================================
 
" =[ TABULATION ]=========================================================================
map tn : tabn<CR>         | " Passe à l'onglet vim suivant
map tp : tabp<CR>         | " Passe à l'onglet vim précédent
map th : tab help<Space>  | " Ouvre dans un nouvel onglet une page d'aide
map tm : tabm<Space>      | " Décalle vers la droite + et vers la gauche - l'onglet actuel
map tt : tabnew<Space>    | " Ouvre un nouvel onglet 
map ts : tab split<Space> | " Ouvre dans un nouvel onglet un fichier existant
noremap te : tabe<Space>  | " Ouvre dans un nouvel onglet un fichier existant

" =[ :SAVE ]==============================================================================
noremap <c-z> :update<CR>
vnoremap <c-z> <c-c>:update<CR>
inoremap <c-z> <c-o>:update<CR>

" =[ :NOHL : CTRL+N PERMET D'ARRÊTER LE SURLIGNAGE ACTIF  ]==============================
noremap <c-n> :nohl<CR>
vnoremap <c-n> <c-c>:nohl<CR>
inoremap <c-n> <c-o>:nohl<CR>

" =[ :SORT : CTRL+T PERMET DE TRIER L'ENSEMBLE DES LIGNES SELECTIONNÉES ]================
vnoremap <leader>t :sort<CR>

" =[ SEARCH&REPLACE ]=====================================================================
noremap ;; :%s:::gic<left><left><left><left><left>
vnoremap ;; :s:::gic<left><left><left><left><left>

 
" ========================================================================================
" CONFIGURATION PLUGINS
" ========================================================================================
 
" =[ GRUVBOX ]============================================================================
" -[ DÉCLARATION DU THÈME ]-------------------------------------------------------------
set t_Co=256
set background=dark
colorscheme gruvbox

" -[ FONCTION AFFICHANT LA COLONE LIMITE QUAND ELLE EXISTE ]------------------------------
" Si textwidth est déclarée, accorde colorcolumn avec sa valeur
" Sinon met la limite à 80 (pour 79)
function! SetColorColumnPerFile()
    "Récupération de la valeur de textwidth dans var-locale:textaille
    let l:textaille = substitute(trim(execute(":set textwidth?")),"textwidth=","","")
    if l:textaille == 0
        setlocal colorcolumn=80
    else
        execute(":setlocal colorcolumn=".l:textaille)
    endif
endfunction
"Lancement automatique à chaque chargement
augroup colorcolumn
    autocmd!
    autocmd BufEnter * call SetColorColumnPerFile()
augroup end
