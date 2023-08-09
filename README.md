# Usage

## Requirements
- Install Neovim with latest stable version (v8.0 and above).
- Install Packer (Follow [docs](https://github.com/wbthomason/packer.nvim))
### Additional dependencies
**For Linux**
- `tar`
- `curl`
- A C compiler (I use gcc)

**For Windows**
For windows there is a possibility that your Treesitter config might not work and I have also encountered problems with installing LSP, but was able to get around it eventually (might be pure luck but can't guarantee).
- A C compiler -  I end up installing msvc and followed the link mentioned right below, was able to make it work. If it doesn't work don't lose hope and search for your error in relevant communities.
- [Follow this important link!](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support)

## Step-1: Copy the nvim folder to nvim config directory
- For linux it is `~/.config` (create if not present)
- For windows it is `%APPDATA%`
Or your configured nvim folder

## Step-2: Source `packer.lua`
Use netrw(builtin file explorer, with command `Ex`) and navigate to packer.lua, source the file using `:so` command and then run command
```
:PackerSync
```
This will install all the plugins

## Step-3: Reopen nvim
Reopening vim will start lsp and configure the plugins automatically

# Keybindings
Apart from these keybindings I am using the defaults that comes with extensions so refer their default settings.
- Open/Focus file explorer: `<leader>bf`
- Close file explorer: `<leader>bx`
- Find files `<leader>ff`
- Search term in files: `<leader>fs` (make sure to install ripgrep)
- Toggle Terminal: `<C-\>`

## Conventions
- `<leader>`: space key
- `<CR>`: Enter key
- `<C-*>`: `*` represents any key here which is preceded by pressing control key
