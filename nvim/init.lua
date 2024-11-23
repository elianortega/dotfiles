-- <leader> key
vim.g.mapleader = ' '

-- Install plugins
require('plugins')

-- open config
vim.cmd('nmap <leader>c :e ~/.config/nvim/init.lua<cr>')

-- save
vim.cmd('nmap <leader>s :w<cr>')

-- yank line
vim.cmd('nmap Y yy')

-- paste without overwritting
vim.keymap.set('v', 'p', 'P')

-- redo
vim.keymap.set('n', 'U', '<C-r>')

-- clear search highlighting
vim.keymap.set('n', '<Esc>', ':nohlsearch<cr>')

-- skip folds
vim.cmd('nmap j gj')

vim.cmd('nmap k gk')

-- sync system clipboard
vim.opt.clipboard = 'unnamedplus'

-- search ignoring case
vim.opt.ignorecase = true

-- disable "ignorecase" option if the search patter contains upper case characters
vim.opt.smartcase = true

-- remap J to 5j
vim.keymap.set('n', 'J', '5j')

-- remap K to 5k
vim.keymap.set('n', 'K', '5k')

-- NAVIGATION

if vim.g.vscode then
    -- VSCode extension
    
else
    -- ordinary Neovim
end


-- comments
-- Shift K open docs
-- double shift k to focus and scroll
-- gg to to the top of docs
-- G to go to the bottom of docs 
-- g shift H to open references of the