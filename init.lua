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

-- Use system clipboard.
vim.cmd("set clipboard=unnamedplus")

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
vim.cmd("set foldmethod=syntax")
vim.cmd("set foldnestmax=1")
vim.cmd("set foldclose=all")

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
vim.cmd("nnoremap <F4> \"=strftime(\"%s\")<CR>P")

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
-- Set up nvim-cmp.
local cmp = require('cmp')

cmp.setup({
    formnnting = {
        format = function(entry, vim_item)
            -- Kind
            vim_item.kind = string.format('| %s', vim_item.kind)
            -- Source
            vim_item.menu = ({
                buffer = "Buffer",
                nvim_lsp = "LSP",
                vsnip = "Snippet",
                path = "Path",
            })[entry.source.name]
            return vim_item
        end
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
        }
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'codeium',  priority = 50 },
        { name = 'nvim_lsp', priority = 40 },
        { name = 'vsnip',    priority = 30 },
        { name = 'buffer',   priority = 20 },
        { name = 'path',     priority = 10 },
    })
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
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = vim.fn.bufnr(),
    callback = function()
        vim.lsp.buf.format({ timeout_ms = 3000 })
    end,
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- Rust.
lspconfig.rust_analyzer.setup {
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy"
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
}

-- Lua.
lspconfig.lua_ls.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                    'vim',
                    'require'
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
}

-- Set up condeium
require("codeium").setup({})
