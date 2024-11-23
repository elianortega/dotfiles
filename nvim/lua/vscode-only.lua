local vscode = require('vscode')



vim.keymap.set({"n"}, "<leader>v", function()
  vscode.action("workbench.action.splitEditor")
end)

-- Move to the left pane
vim.keymap.set({"n"}, "<leader>h", function()
  vscode.action("workbench.action.navigateLeft")
end)

-- Move to the right pane
vim.keymap.set({"n"}, "<leader>l", function()
  vscode.action("workbench.action.navigateRight")
end)

-- Trigger quick actions menu
vim.keymap.set({"n"}, "<leader>w", function()
  vscode.action("editor.action.quickFix")
end)

-- Format the whole document
vim.keymap.set({"n"}, "<leader>f", function()
  vscode.action("editor.action.formatDocument")
end)