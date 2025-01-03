# vim-airline-themes-browser
vim-airline-themes-browser is a supplementary plugin for [vim-airline-themes](https://www.github.com/vim-airline/vim-airline-themes) that provides a simple way to browse and select all available themes.

## Installation
Use your favorite plugin manager to install
I recommend using [vim-plug](https://github.com/junegunn/vim-plug):
```
plug 'njfletcher215/vim-airline-themes-browser'
```

## Usage
Use ':BrowseAirlineThemes' or ':AirlineThemes' to open the theme browser window.<br/>
While in the theme browser window, press <Enter> to select a theme, 'a' to apply a theme without closing the window, or 'q' to close the window without applying a theme.
Press '?' for help.<br/>
<br/>
**NOTE**: the theme will not persist after exiting vim. If you want to permanently change the theme, add the following line to your .vimrc:
```
let g:airline_theme = '<theme_name>'
```
