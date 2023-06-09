-- 前两行是调用lua/config中的options.lua和lazy.lua（注意不需要后缀名，且默认路径为lua/）
-- 之后调用vim.api.nvim_create_autocmd()函数，执行autocmds，懒启动lua/config中的autocmds.lua和keymaps.lua

require("config.options")
require("config.lazy")

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("config.autocmds")
        require("config.keymaps")
    end,
})
