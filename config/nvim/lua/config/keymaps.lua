-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local unmap = vim.keymap.del

-- Move to window using the <ctrl> hjkl keys
map("n", "<left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<M-down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<M-up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<M-down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<M-up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<M-down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<M-up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Remove defaults
unmap("n", "<A-j>")
unmap("n", "<A-k>")
unmap("i", "<A-j>")
unmap("i", "<A-k>")
unmap("v", "<A-j>")
unmap("v", "<A-k>")
