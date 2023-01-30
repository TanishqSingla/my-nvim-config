# Usage

## Step-1: Copy the nvim folder to nvim config directory
For linux it is `~/config`
For windows it is `%APPDATA%`
Or your configured nvim folder

## Step-2: Source `packer.lua`
Use netrw(builtin file explorer) and navigate to packer.lua, source the file using `:so` command and then run command
```
:PackerSync
```
This will install all the plugins

## Step-3: Reopen nvim
Reopening vim will start lsp and configure the plugins automatically

# Keybindings
- Open/Focus file explorer: `<leader>bf`
- Close file explorer: `<leader>bx`
- Find files `<leader>ff`
- Search term in files: `<leader>fs` (make sure to install ripgrep)
- Toggle Terminal: `<C-\>`

## Conventions
- `<leader>`: space key
- `<CR>`: Enter key
- `<C-*>`: `*` represents any key here which is preceded by pressing control key
