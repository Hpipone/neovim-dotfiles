 return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            ensure_installed = {
                "python",
                "astro",
                "c",
                "markdown",
                "markdown_inline",
                "cpp",
                "lua",
                "html",
                "go",
                "javascript",
                "css",
                "java",
                "json",
                "rust",
                "ron",
                "arduino",
                "php",
                "dart",
                "htmldjango",
                "dockerfile",
                "bash",
                "typescript"
            },
            auto_install = true,
        })
    end,
}
