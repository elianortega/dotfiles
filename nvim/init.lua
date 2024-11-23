-- <leader> key
vim.g.mapleader = ' '

-- Install plugins
require('plugins')

-- open config
vim.cmd('nmap <leader>c :e ~/.config/nvim/init.lua<cr>')

-- save
vim.cmd('nmap <leader>s :w<cr>')

-- close buffer
vim.cmd('nmap <leader>q :q<cr>')

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

-- Keep visual mode active after indenting
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })

-- Move selected lines down in visual mode with Shift-J
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Move selected lines up in visual mode with Shift-K
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

if vim.g.vscode then
    -- VSCode extension
  require('vscode-only')
    
else
    -- ordinary Neovim
end


-- comments
-- Shift K open docs
-- double shift k to focus and scroll
-- gg to to the top of docs
-- G to go to the bottom of docs 
-- g shift H to open references of the