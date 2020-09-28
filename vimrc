"BASIC SETUP
"Désactiver la compatibilité avec Vi
set nocompatible

"Activer gestion des plugins Native de vim8
packloadall

"Modifications du vimrc actives à la sauvegarde du $MYVIMRC
autocmd! bufwritepost $MYVIMRC source %

"Racc. Save manuelle de la page actuelle => source $MYVIMRC
map <silent> <F2> <Esc>:write <bar> :source $MYVIMRC<CR>

"Modification de l'emplacement par défaut du viminfo
set viminfo+=n~/.vim/viminfo

"Définition de <Leader>
let mapleader = "²"

"Activation des extensions du vimrc dans le dossier ~/.vim/config/
runtime! config/**/*.vim

"Activation de la souris
set mouse=a

"OPTIONNALS SETTINGS
"Indentation
set autoindent            | " Préserve l'indentation de la ligne précédente
set smartindent           | " Petit plus...

" Affichage
set title             	  | " Affiche le titre des fenêtres et terminaux en bas à gauche
set number 		          | " Affiche le numéro des lignes
set ruler                 | " Affiche barre bas à droite la position du curseur
set wrap		          | " Lorsque la ligne est trop longue, l'affiche en dessous

" Beep/Alerte
set belloff=all    	      | " Désactive toutes les alertes sonnores et visuelles

" Diffsplit en vertical (defaut horizontal...pas pratique)
set diffopt=vertical      | " Permet comparaison cote à cote des fichiers

" Emplacement du curseur lors du scroll
set scrolloff=5           | " Garde toujours le curseur à 5lignes du bord de la fenêtre

" Coloration
syntax enable             | " Activation de la coloration syntaxique

" Tab et limites du texte
set expandtab             | " Remplace la tabulation par des espaces
set tabstop=4    	      | " Remplace la tabulation par 4 espaces
set shiftwidth=4          | " Elimine le bud d'indentation 8espaces...

" Limitation de largeur du texte
set textwidth=90          | " Par defaut, indépendemment du filetype, largeur max = 99!

" Recherches et Surlignages dans le texte
set incsearch             | " Active la recherche et surlignage pendant la saisie du texte
set hlsearch              | " Active le surlignage des correspondance   
set ignorecase            | " Permet d'ignorer la case...
set smartcase             | " ... mais si on met une maj dans la recherche la prend en compte

" GENERAL MAPPINGS
"Tabulation
map tn : tabn<CR>         | " Passe à l'onglet vim suivant
map tp : tabp<CR>         | " Passe à l'onglet vim précédent
map th : tab help<Space>  | " Ouvre dans un nouvel onglet une page d'aide
map tm : tabm<Space>      | " Décalle vers la droite + et vers la gauche - l'onglet actuel
map tt : tabnew<Space>    | " Ouvre un nouvel onglet 
map ts : tab split<Space> | " Ouvre dans un nouvel onglet un fichier existant
noremap te : tabe<Space>  | " Ouvre dans un nouvel onglet un fichier existant

":save
noremap <c-z> :update<CR>
vnoremap <c-z> <c-c>:update<CR>
inoremap <c-z> <c-o>:update<CR>

":nohl : Ctrl+n permet d'arrêter le surlignage actif 
noremap <c-n> :nohl<CR>
vnoremap <c-n> <c-c>:nohl<CR>
inoremap <c-n> <c-o>:nohl<CR>

":sort : Ctrl+t permet de trier l'ensemble des lignes selectionnées
vnoremap <leader>t :sort<CR>

"Search&Replace
noremap ;; :%s:::gic<left><left><left><left><left>
vnoremap ;; :s:::gic<left><left><left><left><left>

" CONFIGURATION PLUGINS
" GRUVBOX
" Déclaration du thème
set t_Co=256
set background=dark
colorscheme gruvbox

" Fonction affichant la colone limite quand elle existe
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

" =============================================================================
" DÉCLARATION DES FUNCTIONS
" =============================================================================
 
" =[ FONCTIONS UTILITAIRES ]===================================================
" --- Fonction retournant la largeur maximal du texte -------------------------
function! Textwidth()
    let l:rcmd = trim(execute(":set textwidth?"))
    let l:taille = substitute(rcmd,"textwidth=","","")
    return l:taille
endfunction

" --- Fonction detectant le symbole de commentaire ----------------------------
function! DefCom()
    let l:rcmd = execute(":set commentstring?")
    let l:inter = substitute(rcmd,"commentstring=","","")
    let l:comm = trim(substitute(inter,"%s","",""))
    return comm
endfunction

" =[ FONCTIONS TITRES DÉCORATIVES ]===========================================
" --- Fonction titre 1  ------------------------------------------------------
function! Titre1(len,com,sym) 
    s/.*/\U&/
    let l:lnum = line(".")
    let l:ligne = getline(".")
    let l:li0 = setline (lnum ," " )
    let l:nbr = a:len - (len(a:com) + 1)
    let l:li1 = append ( lnum , a:com ." ".repeat(a:sym, nbr))
    let l:li2 = append ( lnum , a:com ." ".ligne)
    let l:li3 = append ( lnum , a:com ." ".repeat(a:sym, nbr))
    let l:li4 = append ( lnum + 3 ," " )
    + 4
endfunction
noremap <silent> <Leader>& :call Titre1(Textwidth(),DefCom(),"=")<CR>

" --- Fonction titre 2 -------------------------------------------------------
function! Titre2(len,com,sym)
    s/.*/\U&/ | " substitue toute la ligne par des majuscules
    let l:lnum = line(".")
    let l:text1 = getline(".")
    let l:texte2 = a:com." ".a:sym."[ ".text1." ]"
    let l:text = len(texte2)
    let l:reste = (a:len - len(texte2))
    let l:final = texte2 . repeat(a:sym, reste)
    let l:final2 = setline(lnum,final)
endfunction
noremap <silent> <Leader>é :call Titre2(Textwidth(),DefCom(),"=")<CR>
noremap <silent> <Leader>" :call Titre2(Textwidth(),DefCom(),"-")<CR>
