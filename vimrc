"BASIC SETUP
"Désactiver la compatibilité avec Vi
set nocompatible

"Activer gestion des plugins Native de vim8
packloadall

"Modifications du vimrc actives à la sauvegarde du $MYVIMRC
autocmd! bufwritepost $MYVIMRC source %

"Modification de l'emplacement par défaut du viminfo
set viminfo+=n~/.vim/viminfo

"Définition de <Leader>
let mapleader = "²"

"Activation des extensions du vimrc dans le dossier ~/.vim/config/
runtime! config/**/*.vim

"Activation de la souris
set mouse=a
