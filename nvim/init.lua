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
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.cmd('set re=0')

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

  -- mason
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
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
vim.cmd.colorscheme 'tokyonight'
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

local lang_list = {
  "lua_ls", "ts_ls", "vue_ls", "svelte", "bashls"
}

-- Mason
require("mason-lspconfig").setup {
  automatic_enable = {
    lang_list
  },
  ensure_installed = lang_list
}

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
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
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


vim.lsp.config('vue_ls', {
  -- add filetypes for typescript, javascript and vue
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  init_options = {
    vue = {
      -- disable hybrid mode
      hybridMode = false,
    },
    typescript = {
      tsdk = "/home/dev/.nvm/versions/node/v22.14.0/lib/node_modules/typescript/lib"
    },
  },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false,
      }
    }
  }
})


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
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  for _, client in ipairs(clients) do
    if client.name == "ts_ls" then
      client:exec_cmd({
        title = "Organize Import",
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(bufnr) },
      }, { bufnr = bufnr })
      vim.notify("Import Organized", vim.log.levels.INFO)
      return
    end
  end

  vim.notify("Organize Imports: No suitable LSP client found.", vim.log.levels.WARN)
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
      vim.notify("File formatted", vim.log.levels.INFO)
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
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
