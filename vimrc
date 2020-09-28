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

" Limitation de largeur du texte
set textwidth=99          | " Par defaut, indépendemment du filetype, largeur max = 99!

" Recherches et Surlignages dans le texte
set incsearch             | " Active la recherche et surlignage pendant la saisie du texte
set hlsearch              | " Active le surlignage des correspondance   
set ignorecase            | " Permet d'ignorer la case...
set smartcase             | " ... mais si on met une maj dans la recherche la prend en compte

