vim.cmd([[
syntax on
filetype plugin indent on

let mapleader=' '
]])

-- Netrw banner.
vim.cmd("let g:netrw_banner = 0")
-- Disable netrw history from being created in ~/.vim/.netrwhist.
vim.cmd("let g:netrw_dirhistmax = 0")
-- Thin flat listing.
vim.cmd("let g:netrw_liststyle = 0")
-- Set width of 25% of current window width.
vim.cmd("let g:netrw_winsize = 25")
-- Open files from netrw in a previous window, unless we're opening the current dir.
vim.cmd([[
if argv(0) ==# '.'
	let g:netrw_browse_split = 0
else
	let g:netrw_browse_split = 4
	endif
	]])
-- Ignore case when sorting.
vim.cmd("let g:netrw_sort_options = 'i'")

-- Clipboard
vim.cmd('nnoremap <yy> :call system("wl-copy", @")<CR>')

-- Line numbers
vim.cmd("set number")
vim.cmd("set relativenumber")

-- Encodings
vim.cmd("set encoding=utf-8")
vim.cmd("set fileencoding=utf-8")
vim.cmd("set fileencodings=utf-8")

-- Mouse off
vim.cmd("set mouse=")

-- Indentation
vim.cmd("set autoindent")
vim.cmd("set nosmartindent")
vim.cmd("set smarttab")
vim.cmd("set expandtab")

-- Indentation lengths
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set softtabstop=4")
vim.cmd("set textwidth=80")

-- Folding
-- Disable for now because it doesn't work nicely with chatgpt.
-- vim.cmd("set foldmethod=syntax")
-- vim.cmd("set foldnestmax=1")
-- vim.cmd("set foldclose=all")

-- Disable viminfo logging
vim.cmd("set viminfo=")

-- Disable saves
vim.cmd("set nobackup")
vim.cmd("set noswapfile")

-- Disable sign column, this removes diagnostic highlighting but if there's an
-- error I will notice and jump to it.
vim.cmd("set signcolumn=no")

-- Delay between switching modes
vim.cmd("set ttimeoutlen=10")
vim.cmd("set ttyfast")

-- Text formatting
-- Underline the current line with equal in normal mode
vim.cmd("nnoremap <F5> yyp<c-v>$r=")
vim.cmd("nnoremap <F6> 80A-<ESC>0")
vim.cmd("nnoremap <F7> 80A=<ESC>0")

-- Insert current time
vim.cmd('nnoremap <F4> "=strftime("%s")<CR>P')

-- Trim lines of white space.
vim.cmd("autocmd BufWritePre * :%s/\\s\\+$//e")

-- Completion
vim.cmd("set completeopt=menu,menuone,preview,noselect,noinsert")

-- Custom indentation settings
vim.cmd("autocmd FileType make setlocal ts=8 sw=8 sts=0 noet")
vim.cmd("autocmd FileType PKGBUILD setlocal ts=2 sw=2 sts=2 et")

-- Disable arrows in all modes
vim.cmd("noremap <Up> <Nop>")
vim.cmd("noremap <Down> <Nop>")
vim.cmd("noremap <Left> <Nop>")
vim.cmd("noremap <Right> <Nop>")

vim.cmd("inoremap <Up> <Nop>")
vim.cmd("inoremap <Down> <Nop>")
vim.cmd("inoremap <Left> <Nop>")
vim.cmd("inoremap <Right> <Nop>")

vim.cmd("vnoremap <Up> <Nop>")
vim.cmd("vnoremap <Down> <Nop>")
vim.cmd("vnoremap <Left> <Nop>")
vim.cmd("vnoremap <Right> <Nop>")

-- Switching windows
vim.cmd("noremap <C-j> <C-w>j")
vim.cmd("noremap <C-k> <C-w>k")
vim.cmd("noremap <C-l> <C-w>l")
vim.cmd("noremap <C-h> <C-w>h")

-- vim -b : edit binary using xxd-format!
vim.cmd([[
	augroup Binary
	au!
	au BufReadPre  *.bin let &bin=1
	au BufReadPost *.bin if &bin | %!xxd
	au BufReadPost *.bin set ft=xxd | endif
	au BufWritePre *.bin if &bin | %!xxd -r
	au BufWritePre *.bin endif
	au BufWritePost *.bin if &bin | %!xxd
	au BufWritePost *.bin set nomod | endif
	augroup END
	]])

-- Set colorscheme
vim.cmd("colorscheme gruvbox")
vim.cmd("set bg=dark")
vim.cmd("highlight Normal ctermbg=NONE")

-- PLUGIN CONFIGURATIONS
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug('tpope/vim-repeat')
Plug('fatih/vim-go')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/vim-vsnip')
Plug('Exafunction/codeium.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('zbirenbaum/copilot-cmp')
Plug('zbirenbaum/copilot.lua')
Plug('nvim-telescope/telescope.nvim')
Plug('MunifTanjim/nui.nvim')

vim.call("plug#end")

-- Set up copilot
require("copilot").setup({
    panel = {
        enabled = false,
        auto_refresh = false,
        keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
        },
        layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
        },
    },
    suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
    },
    filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
    copilot_node_command = "node", -- Node.js version must be > 18.x
    server_opts_overrides = {},
})

require("copilot_cmp").setup({})

-- Set up nvim-cmp.
local cmp = require("cmp")

cmp.setup({
    formnnting = {
        format = function(entry, vim_item)
            -- Kind
            vim_item.kind = string.format("| %s", vim_item.kind)
            -- Source
            vim_item.menu = ({
                copilot = "copilot",
                buffer = "Buffer",
                nvim_lsp = "LSP",
                vsnip = "Snippet",
                path = "Path",
            })[entry.source.name]
            return vim_item
        end,
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },
    window = {
        completion = {
            border = "rounded",
            winhighlight = "Normal:CompletionNormal",
        },
        documentation = {
            border = "rounded",
            winhighlight = "Normal:CompletionNormal",
        },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = "copilot",  priority = 50 },
        { name = "nvim_lsp", priority = 40 },
        { name = "vsnip",    priority = 30 },
        { name = "buffer",   priority = 20 },
        { name = "path",     priority = 10 },
    }),
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--     sources = cmp.config.sources({
--         { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--     }, {
--         { name = 'buffer' },
--     })
-- })

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = vim.fn.bufnr(),
    callback = function()
        vim.lsp.buf.format({ timeout_ms = 3000 })
    end,
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil

        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

-- Rust.
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
            inlayHints = {
                chainingHints = { enable = true },
                closingBraceHints = { enable = false },
                parameterHints = { enable = false },
                renderColons = false,
                typeHints = { enable = false },
            },
        },
    },
})

-- Lua.
lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    "vim",
                    "require",
                },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
})
