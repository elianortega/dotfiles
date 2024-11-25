-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)
-- Setup lazy.nvim
require('lazy').setup({{
  'vscode-neovim/vscode-multi-cursor.nvim',
  event = 'VeryLazy',
  cond = not not vim.g.vscode,
  opts = {},
}, 
'folke/flash.nvim',
'tpope/vim-surround',
'easymotion/vim-easymotion'
})

local cursors = require('vscode-multi-cursor')

vim.keymap.set({'n','x', 'i'}, '<c-d>', function()
  cursors.addSelectionToNextFindMatch()
end)

vim.keymap.set({'n','x', 'i'}, '<cs-d>', function()
  cursors.addSelectionToPreviousFindMatch()
end)

vim.keymap.set({'n','x', 'i'}, '<cs-l>', function()
  cursors.selectHighlights()
end)

vim.keymap.set({'n'}, '<c-d>', 'mciw*:nohl<cr>', {
 remap = true, 
})


