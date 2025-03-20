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
-- Bootstrap lazy.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
      'saghen/blink.cmp',
      -- optional: provides snippets for the snippet source
      dependencies = { 'rafamadriz/friendly-snippets' },

      -- use a release tag to download pre-built binaries
      version = '*',
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'default' },

        appearance = {
          -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
          -- Adjusts spacing to ensure icons are aligned
          nerd_font_variant = 'mono'
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
          default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = { implementation = "prefer_rust_with_warning" }
      },
      opts_extend = { "sources.default" }
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { 'saghen/blink.cmp' },
        config = function()
            -- Set up lspconfig.
            local capabilities = require("blink.cmp").get_lsp_capabilities()
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
            lspconfig.lua_ls.setup({ capabilities = capabilities })
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    }
})
