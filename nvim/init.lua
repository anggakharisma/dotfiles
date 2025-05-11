-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

-- Basic editor configuration
vim.g.mapleader = ','
vim.o.background = 'dark'
vim.opt.nu = false
vim.opt.rnu = false
vim.g.have_nerd_font = true
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.history = 500
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.swapfile = false
vim.opt.termguicolors = true -- Important for colorizer and other color-related plugins
vim.opt.clipboard = "unnamedplus"

-- Tab and indentation settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.cmd('set re=0') -- Use new regexp engine

-- Undo settings
vim.o.undofile = true
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')

-- Text wrapping
vim.opt.textwidth = 80
vim.opt.wrapmargin = 80
vim.opt.wrap = true
vim.opt.linebreak = true
vim.cmd('set fo+=t')

-- Folding settings
vim.opt.foldmethod = 'syntax'
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 2

-- UI settings
vim.opt.signcolumn = 'yes:1'
vim.cmd("let &fcs='eob: '")

-- Plugin configuration with lazy.nvim
require("lazy").setup({
  -- LSP related plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "ray-x/lsp_signature.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "onsails/lspkind.nvim",
      "nvimdev/lspsaga.nvim",
    }
  },

  -- Mini plugins collection
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.statusline').setup()
      require('mini.icons').setup()
      require('mini.ai').setup()
    end
  },

  -- LSP signature help
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end
  },

  -- Lua development
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Color schemes
  { "rose-pine/neovim",              name = "rose-pine" },
  { "craftzdog/solarized-osaka.nvim" },
  { "catppuccin/nvim",               name = "catppuccin", priority = 1000 },
  { "ellisonleao/gruvbox.nvim",      priority = 1000,     config = true },
  { "rebelot/kanagawa.nvim" },
  { "EdenEast/nightfox.nvim" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  -- Snippets
  { "hrsh7th/vim-vsnip" },

  -- Color highlighter
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup({
        '*',             -- Highlight all files
      }, {
        RGB = true,      -- #RGB hex codes
        RRGGBB = true,   -- #RRGGBB hex codes
        names = true,    -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true,   -- CSS rgb() and rgba() functions
        hsl_fn = true,   -- CSS hsl() and hsla() functions
        css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
      -- Autocommand to enable colorizer on FileType event
      vim.cmd([[
        augroup ColorizeInit
          autocmd!
          autocmd FileType * ColorizerAttachToBuffer
        augroup END
      ]])
    end
  },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      require('mason-nvim-dap').setup({
        automatic_installation = true,
        ensure_installed = { 'node2', 'delve' },
        handlers = {
          function(config) require('mason-nvim-dap').default_setup(config) end,
        },
      })
    end
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    }
  },

  -- Java
  { 'mfussenegger/nvim-jdtls' },

  -- Project management
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require('project_nvim').setup({
        manual_mode = true
      })
    end
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('todo-comments').setup()
      vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
      vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })
    end
  },

  -- Diagnostics viewer
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },

  -- Required dependencies and utilities
  { "nvim-lua/plenary.nvim" },
  { "BurntSushi/ripgrep" },

  -- Formatting
  {
    "stevearc/conform.nvim",
    config = function(_, opts)
      require("conform").setup(opts)
    end
  },
  {
    "zapling/mason-conform.nvim",
    config = function(_, opts)
      require("mason-conform").setup(opts)
    end
  },

  -- Code editing helpers
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  { "tpope/vim-fugitive" },
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
  { "tpope/vim-sleuth" },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup {
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
          untracked = { text = '┆' },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = { follow_files = true },
        attach_to_untracked = true,
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 500,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)
          map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line { full = true } end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end
  },
  { "akinsho/git-conflict.nvim",              version = "*", config = true },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-treesitter.configs').setup {
        sync_install = false,
        auto_install = true,
        ensure_installed = { "typescript" },
        highlight = { enable = true },
      }
    end
  },
  { 'nvim-treesitter/nvim-treesitter-context' },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      source_selector = {
        winbar = false,
        statusline = false
      },
      filesystem = {
        hijack_netrw_behavior = 'open_default'
      }
    },
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            "vendor"
          }
        }
      }
    end
  },
})

-- Colorscheme configuration
vim.cmd.colorscheme 'carbonfox'
vim.cmd("syntax enable")
vim.cmd('au ColorScheme * hi Normal ctermbg=none guibg=none')

-- Highlight customization
vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'NonText', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'gray', bold = false })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'NONE', bold = true })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'gray', bold = false })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none', bold = false })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#1f44a7', bold = false })

-- CMP highlighting
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

-- Configure completion
local cmp = require('cmp')
local lspkind = require("lspkind")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
      vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "",
        treesitter = "",
        path = "[Path]",
        buffer = "",
        zsh = "[ZSH]",
        vsnip = "",
        spell = "暈",
      })[entry.source.name]

      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-s>'] = cmp.mapping.complete({ reason = cmp.ContextReason.Auto }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = 'buffer' } }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- LSP Configuration
local lspLists = {
  "ts_ls", "rust_analyzer", "gopls", "lua_ls", "prismals",
  "emmet_ls", "cssls", "volar", "intelephense", "tailwindcss",
  "dockerls", "yamlls", "clangd", "eslint", "jsonls",
  "jedi_language_server", "omnisharp", "html", "volar", "svelte", "astro"
}

-- Mason setup
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = lspLists,
  automatic_installation = true
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, buffer)
  if client.resolved_capabilities ~= nil then
    client.resolved_capabilities.document_formatting = true
  end
  vim.lsp.inlay_hint.enable(true)
end

-- Setup each LSP
for _, server in ipairs(lspLists) do
  require('lspconfig')[server].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

local lspconfig = require('lspconfig')

local mason_registry = require('mason-registry')
local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
lspconfig.ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

-- No need to set `hybridMode` to `true` as it's the default value
lspconfig.volar.setup {}

-- Additional LSP setups
require('lspconfig').lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

require('lspconfig').stimulus_ls.setup {}

-- LSP signature setup
require("lsp_signature").setup({
  bind = true,
  handler_opts = {
    border = "rounded"
  }
})

-- LspSaga setup
require('lspsaga').setup({})

-- Function to organize imports
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

-- LSP keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
    vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
    vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')

    vim.keymap.set('n', '<space>oo', organize_imports, opts)
    vim.keymap.set('n', '<leader>oc', function()
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end, opts)

    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', '<cmd>Lspsaga rename<CR>', opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', '<cmd>Lspsaga code_action<CR>', opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>fo', function()
      require('conform').format()
      vim.lsp.buf.format { async = true }
    end, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Diagnostic configuration
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    },
  },
})

-- Special handlers for Telescope
vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Global keymaps
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Tab completion in insert mode
vim.cmd('inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"')

-- Window resize
map('n', '<M-k>', ':resize -2<CR>')
map('n', '<M-j>', ':resize +2<CR>')
map('n', '<M-l>', ':vertical resize -2<CR>')
map('n', '<M-h>', ':vertical resize +2<CR>')

-- Buffer navigation
map('n', '<tab>', ":if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>")
map('n', '<s-tab>', ":if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>")

-- Escape from insert mode
map('i', 'kk', '<Esc>')

-- Window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Save and quit
map('n', '<leader>s', ':w<CR>')
map('n', '<leader>w', ':w<CR>')
map('n', '<C-q>', ':q!<CR>')

-- Terminal escape
vim.keymap.set('t', '<Esc><Esc>', "<C-\\><C-n>", { silent = true })

-- Java specific
vim.cmd("nnoremap <leader>oo <Cmd>lua require'jdtls'.organize_imports()<CR>")

-- Neotree toggle
map('n', '<leader>nn', ":Neotree toggle<CR>")
map('n', '<C-n>', ":Neotree toggle<CR>")

-- Clear search highlighting
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Trouble plugin keymaps
vim.keymap.set('n', '<leader>tx', "<cmd>Trouble diagnostics toggle<CR>")
vim.keymap.set('n', '<leader>tX', "<cmd>Trouble diagnostics toggle filter.buf=0<CR>")
vim.keymap.set('n', '<leader>ts', "<cmd>Trouble symbols toggle focus=false<CR>")
vim.keymap.set('n', '<leader>tl', "<cmd>Trouble lsp toggle focus=false win.position=right<CR>")
vim.keymap.set('n', '<leader>tL', "<cmd>Trouble loclist toggle<CR>")
vim.keymap.set('n', '<leader>tQ', "<cmd>Trouble qflist toggle<CR>")
vim.keymap.set('n', '<leader>tr', "<cmd>TodoTrouble<CR>")
vim.keymap.set('n', '<leader>tp', "<cmd>TodoTelescope<CR>")

-- Toggle line numbers
vim.keymap.set('n', '<leader>tn', function()
  vim.opt.nu = not vim.opt.nu:get()
  vim.opt.rnu = not vim.opt.rnu:get()
end)

-- Telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
