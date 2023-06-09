--[[
这里用到的分类有

vim.g.{name}: 全局变量
vim.b.{name}: 缓冲区变量
vim.w.{name}: 窗口变量
vim.bo.{option}: buffer-local 选项
vim.wo.{option}: window-local 选项

一般来说，全部设置在 vim.opt 下也是可以的，例如 vim.opt.number = true
只是我们设置到了比较详细位置而已，具体每个变量的分类可以在 :help 文档中查看。
--]]
-- === 全局配置 ===
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.encoding = "utf-8"
vim.g.tex_flavor = "latex"           -- 针对.tex文件
vim.g.markdown_recommended_style = 0 -- 0: github, 1: pandoc, 2: plain

-- 全局参数
local opt = vim.opt
local indent = 4

-- ===============
-- === 系统配置 ===
-- ===============
opt.fileencoding = "utf-8" -- The encoding written to file

-- Lua语言相关配置
--opt.shortmess = opt.shortmess .. 'c'
opt.shortmess:append({ W = true, I = true, c = true })

-- 保存
-- opt.autowrite = true                                                -- 自动保存
-- opt.confirm = true                                                  -- 保存前确认
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" } -- 保存会话时保存的内容，具体解释见 :help 'sessionoptions'

-- 禁止创建备份文件
opt.backup = false      -- 不创建备份文件，例如强制退出时不产生swap文件
opt.writebackup = false -- 不创建备份文件
opt.swapfile = false    -- 不创建交换文件
--opt.updatetime = 200    -- Save swap file every 200 ms
--opt.undofile = true     -- 开启撤销文件
--opt.undolevels = 10000  -- 最大撤销次数
opt.autoread = true -- 当文件被外部程序修改时，自动加载

-- 支持系统剪切板
opt.clipboard = "unnamedplus"

opt.mouse = "a"        -- 鼠标支持
opt.timeoutlen = 500   -- 设置连击等待时间，例如映射esc为jj，两个j之间时间小于等于timeoutlen则判定为快捷键
opt.history = 500      -- Sets how many lines of history VIM has to remember
opt.startofline = true -- 当为true时，一些命令将光标移动到该行的第一个非空白处。 关闭时，光标将保留在同一列中（如果可能）

-- ===============
-- === 样式配置 ===
-- ===============
--opt.background = "dark"
opt.termguicolors = true   -- 开启24位颜色
opt.winminwidth = 5        -- 最小窗口宽度，0-12
opt.number = true          -- 显示行号
opt.relativenumber = true  -- 显示相对行号
opt.signcolumn = "yes"     -- 显示左侧图标指示列
opt.colorcolumn = "80"     -- 右侧参考线，超过表示代码太长了，考虑换行（Line length marker）
opt.expandtab = true       -- 使用空格代替制表符
opt.cursorline = true      -- 高亮当前行
opt.ignorecase = true      -- 搜索时忽略大小写
opt.smartcase = true       -- 搜索时忽略大小写，除非包含大写（小写匹配大小写，大写只匹配大写）
opt.hlsearch = true        -- 搜索时高亮显示
opt.inccommand = "nosplit" -- 命令行实时显示替换结果
opt.cmdheight = 2          -- 命令行高为2，提供足够的显示空间
opt.laststatus = 0         -- 隐藏状态栏
opt.showmode = false       -- 使用增强状态栏插件后不再需要vim的模式提示（Dont show mode since we have a statusline）

--[[
    0：不显示标签栏
    1：这是默认设置，意思是，在创建标签页后才显示标签栏
    2：总是显示标签栏
 ]]
opt.showtabline = 2
--[[
    true：允许隐藏被修改过的buffer，否则会报 E37: No write since last change 错误，
    false：强制你保存当前buffer后才允许切换到其他的 buffer
]]
opt.hidden        = true

-- jkhl 移动时光标周围保留8行
opt.scrolloff     = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context

-- 不可见字符的显示，这里把空格显示为一个点（Show some invisible characters eg. tabs...）
opt.list          = true  -- 显示特殊字符
opt.listchars     = "space:·" -- 空格显示为一个点
--opt.conceallevel = 3      -- 隐藏特殊字符，例如双引号、单引号以及markdown相关特殊字符

-- >> << 时移动长度
opt.shiftwidth    = indent -- Size of an indent
opt.shiftround    = true -- Round indent to multiple of 'shiftwidth'

-- ===============
-- === 编辑配置 ===
-- ===============
opt.wrap          = false -- 不自动换行
opt.incsearch     = true -- 边输入边搜索
opt.showmatch     = true -- 显示匹配括号

--[[
    光标移动到行首或行尾时，自动跳转到下一行或上一行

    b：在 Normal 或 Visual 模式下按删除(Backspace)键
    s：在 Normal 或 Visual 模式下按空格键
    h：在 Normal 或 Visual 模式下按 h 键。
    l：在 Normal 或 Visual 模式下按 l 键。
    <：在 Normal 或 Visual 模式下按左方向键。
    >：在 Normal 或 Visual 模式下按右方向键。
    [：在 Insert 或 Replace 模式下按左方向键。
    ]：在 Insert 或 Replace 模式下按右方向键。
 ]]
opt.whichwrap = 'h,l,<,>,[,]'

opt.tabstop = indent                               -- Number of spaces tabs count for
opt.softtabstop = indent                           -- Number of spaces tabs count for while editing

opt.smartindent = true                             -- 智能缩进
opt.autoindent = true                              -- 自动缩进，新行对齐当前行
opt.formatoptions = "jcroqlnt"                     -- 自动格式化，具体解释见 :help fo-table
opt.completeopt = "menu,menuone,noselect,noinsert" -- 补全增强（自动补全不自动选中）

-- 'pumheight'、'ph'、'pumheight'、'ph'数值型（缺省为0）全局决定用于插入模式补全的弹出菜单显示项目的最大数目。如果为零，有多少空间就用多少。
opt.pumblend = 10
opt.pumheight = 10

-- split window 从下边和右边出现
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
--[[
    版本原因无法使用
    The value of this option determines the scroll behavior when opening, closing or resizing horizontal splits.
    Possible values are:
    cursor：Keep the same relative cursor position.
    screen：Keep the text on the same screen line.
    topline：Keep the topline the same.
]]
--opt.splitkeep = "screen"

opt.spell = true                -- 拼写检查
opt.spelllang = { "en", "cjk" } -- 拼写检查语言：英语和中文
opt.spelloptions = "camel"      -- Enable camel case

-- ============
-- === 命令 ===
-- ============
opt.grepformat = "%f:%l:%c:%m"     -- 设置grep命令的输出格式
opt.grepprg = "rg --vimgrep"       -- 设置grep命令

opt.wildmenu = true                -- 命令行全菜单
opt.wildmode = "longest:full,full" -- Command-line completion mode，具体见 :help 'wildmode'
