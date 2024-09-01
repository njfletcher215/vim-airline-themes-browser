if exists('g:loaded_airline_themes_browser')
    finish
endif
let g:loaded_airline_themes_browser = 1

function! BrowseAirlineThemes()
    " Find the vim-airline-themes plugin directory
    let airline_themes_dir = ''
    for path in split(&runtimepath, ',')
        if path =~ 'vim-airline-themes'
            let airline_themes_dir = path . '/autoload/airline/themes'
            break
        endif
    endfor

    if empty(airline_themes_dir)
        echoerr "Could not find the vim-airline-themes plugin directory"
        return
    endif

    " Get list of theme files
    let theme_files = glob(airline_themes_dir . '/*.vim', 0, 1)

    " Extract theme names from filenames
    let themes = []
    for file in theme_files
        let theme_name = fnamemodify(file, ':t:r')
        call add(themes, theme_name)
    endfor

    " Sort themes alphabetically
    call sort(themes)

    " Create the content for the new buffer
    let content = themes

    " Create a new split window and buffer silently
    silent! execute 'keepalt 5split airline-themes-browser'
    silent! execute 'buffer airline-themes-browser'

    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal nowrap
    setlocal cursorline
    setlocal nobuflisted

    " Populate the buffer with theme names
    setlocal modifiable
    silent! call setline(1, content)
    setlocal nomodifiable

    " Move cursor to the first theme
    normal! 2G

    " Set up key mappings
    nnoremap <buffer> <silent> a :call ApplySelectedTheme()<CR>
    nnoremap <buffer> <silent> q :bdelete!<CR>
    nnoremap <buffer> <silent> <CR> :call ApplySelectedTheme()<CR> :bdelete!<CR>
    nnoremap <buffer> <silent> ? :call ToggleHelpText()<CR>

    " Set the statusline
    setlocal statusline=%!AirlineThemeBrowserStatusLine()

    function! ApplySelectedTheme()
        let theme = getline('.')
        silent! execute 'AirlineTheme ' . theme
        redraw
        setlocal statusline=%!AirlineThemeBrowserStatusLine()
    endfunction

    function! AirlineThemeBrowserStatusLine()
        return 'Airline Theme Browser | Press ? for help'
    endfunction

    function! ToggleHelpText()
        echohl Statement
        echo "Airline Theme Browser Help:"
        echohl None
        echo "Enter     : Apply selected theme and quit"
        echo "a         : Apply selected theme and keep browsing"
        echo "q         : Quit the browser"
        echo "To make the selected theme persistent, add 'let g:airline_theme=<theme>' to your vimrc"
    endfunction

endfunction

command! BrowseAirlineThemes call BrowseAirlineThemes()
command AirlineThemes call BrowseAirlineThemes()
