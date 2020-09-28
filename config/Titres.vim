" ========================================================================================
" MISE EN FORME DES TITRES 
" ========================================================================================
" Ce petit 'plugin' permet la mise en forme des titres des différents script en prennant
" en compte la taille maximal du texte ainsi que le commentstring du langage.

" Il s'utilise en mode Normal, une fois le nom du titre saisi sans avoir mis le
" commentstring, placer le cuseur sur la ligne puis faire [²]+[x] pour mettre en forme 
" un titre x... pour l'instant x est compris entre 1 et 3...

" ========================================================================================
" DÉCLARATION DES FUNCTIONS
" ========================================================================================
 
" =[ FONCTIONS UTILITAIRES ]==============================================================
" -[ FONCTION RETOURNANT LA LARGEUR MAXIMAL DU TEXTE ]------------------------------------
function! Textwidth()
    let l:rcmd = trim(execute(":set textwidth?"))
    let l:taille = substitute(rcmd,"textwidth=","","")
    return l:taille
endfunction

" -[ FONCTION DETECTANT LE SYMBOLE DE COMMENTAIRE ]---------------------------------------
function! DefCom()
    if (&filetype =="vim")
        let l:comm = '"'
    elseif ((&filetype =="c") || &filetype =="c++")
        let l:comm = '//'
    elseif (&filetype =="python")
        let l:comm = '#'
    else
        let l:rcmd = execute(":set commentstring?")
        let l:inter = substitute(rcmd,"commentstring=","","")
        let l:comm = trim(substitute(inter,"%s","",""))
    endif
    return comm
endfunction

" =[ FONCTIONS TITRES DÉCORATIVES ]======================================================
" -[ FONCTION TITRE 1 ]-------------------------------------------------------------------
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

" -[ FONCTION TITRE 2  ]------------------------------------------------------------------
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
