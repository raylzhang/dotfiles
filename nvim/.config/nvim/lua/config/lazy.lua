-- 前半部分是安装lazy.nvim，后半部分是简单的配置lazy.nvim

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    -- bootstrap lazy.nvim
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = { lazy = true, version = false }, -- always use the latest git commit
    install = { colorscheme = { "tokyonight", "gruvbox" } },
    checker = { enabled = true },                -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins（屏蔽一些nvim自带的插件）
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
