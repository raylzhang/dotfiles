--[[
在 Neovim 中使用以下方法设置快捷键：

vim.api.nvim_set_keymap() 全局快捷键
vim.api.nvim_buf_set_keymap() Buffer 快捷键

一般情况下，都是定义使用全局快捷键， Buffer 快捷键一般是在某些异步回调函数里指定，
例如某插件初始化结束后，会有回调函数提供 Buffer，这个时候我们可以只针对这一个 Buffer 设置快捷键。

全局快捷键设置：
vim.api.nvim_set_keymap('模式', '按键', '映射为', 'options')

模式：
n Normal 模式
i Insert 模式
v Visual 模式
t Terminal 模式
c Command 模式
o Operator 模式，例如 d, y, >, < 等

options：
大部分会设置为 { noremap = true, silent = true }。noremap 表示不会重新映射，
比如你有一个映射 A -> B , 还有一个 B -> C，这个时候如果你设置 noremap = false 的话，
表示会重新映射，那么 A 就会被映射为 C。silent 为 true，表示不会输出多余的信息。
--]]
-- ==============
-- === 基础设置 ===
-- ==============
-- 保存本地变量
--local map = vim.api.nvim_set_keymap
local function map(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    -- @cast keys LazyKeysHandler
    -- do not create the keymap if a lazy keys handler exists
    if not keys.active[keys.parse({ lhs, mode = mode }).id] then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
    end
end

local opt = { noremap = true, silent = true } -- 复用 opt 参数
-- ================
-- === 系统快捷键 ===
-- ================
-- 退出
map("n", "q", ":q<CR>", opt)
map("n", "qq", ":q!<CR>", opt)
map("n", "Q", ":qa!<CR>", opt)

-- save file
--map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", opt)
map("n", "<leader>w", "<cmd>w<cr>", opt)

-- add undo break-points
map("i", ",", ",<c-g>u", opt)
map("i", ".", ".<c-g>u", opt)
map("i", ";", ";<c-g>u", opt)

-- toggle options
-- ===
-- map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
-- ===
local util = require("util")
map("n", "<leader>us", function() util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ud", util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() util.toggle("conceallevel", false, { 0, conceallevel }) end,
    { desc = "Toggle Conceal" })
-- Others
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- ================
-- === 移动快捷键 ===
-- ================
-- 上下滚动
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- insert 模式下，移动到行首行尾
map("i", "<C-h>", "<ESC>I", opt)
map("i", "<C-l>", "<ESC>A", opt)
-- 其他模式下，移动到行首行尾
map({ "n", "v", "o" }, "<C-h>", "^", opt)
map({ "n", "v", "o" }, "<C-l>", "$", opt)

-- ================
-- === 操作快捷键 ===
-- ================
map("n", "<leader>v", "vi\"", opt) -- 选中引号内
map("n", "<C-a>", "gg<S-v>G", opt) -- 全选
map("v", "p", '"_dP', opt)         -- 粘贴时不会覆盖原有内容

-- move Lines
map("n", "<C-j>", "<cmd>m .+1<cr>==", opt)
map("n", "<C-k>", "<cmd>m .-2<cr>==", opt)
map("i", "<C-j>", "<esc><cmd>m .+1<cr>==gi", opt)
map("i", "<C-k>", "<esc><cmd>m .-2<cr>==gi", opt)
map("v", "<C-j>", ":m '>+1<cr>gv=gv", opt)
map("v", "<C-k>", ":m '<-2<cr>gv=gv", opt)

-- better indenting
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- TODO 这样写无效果，下面写法可行
--map("n", "<", "v<g", opt)
--map("n", ">", "v>g", opt)
map("n", "<", "v<", opt)
map("n", ">", "v>", opt)

-- search
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- ================
-- === 窗口快捷键 ===
-- ================
-- 取消 s 默认功能
--map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "<leader>wv", ":vsp<CR>", opt)
map("n", "<leader>wh", ":sp<CR>", opt)
-- 关闭当前
map("n", "<leader>wc", "<C-w>c", opt)
-- 关闭其他
map("n", "<leader>wo", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)

-- windows resize
map("n", "<Up>", "<cmd>resize +2<cr>", opt)
map("n", "<Down>", "<cmd>resize -2<cr>", opt)
map("n", "<Left>", "<cmd>vertical resize -2<cr>", opt)
map("n", "<Right>", "<cmd>vertical resize +2<cr>", opt)
-- 等比例
--map("n", "s=", "<C-w>=", opt)

-- Terminal相关
map("n", "<leader>tv", ":sp | terminal<CR>", opt)
map("n", "<leader>th", ":vsp | terminal<CR>", opt)
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- buffers
-- ===
--map({ "n", "i" }, "<A-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--map("n", "<leader>k", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
--map({ "n", "i" }, "<A-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
--map("n", "<leader>j", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- ===
-- Delete window in `mini.bufremove`
--map("n", "<leader>D", "<C-W>c", { desc = "Delete window" })
