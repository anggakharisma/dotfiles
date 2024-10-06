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

require("lazy").setup({
  "neovim/nvim-lspconfig",
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts) require 'lsp_signature'.setup(opts) end,
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "rose-pine/neovim",     name = "rose-pine" },
  "craftzdog/solarized-osaka.nvim",
  "hrsh7th/vim-vsnip",
  'norcalli/nvim-colorizer.lua',
  "mfussenegger/nvim-dap",
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
  "jay-babu/mason-nvim-dap.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  'mfussenegger/nvim-jdtls',
  'onsails/lspkind.nvim',
  "ahmedkhalf/project.nvim",
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
  },
  { "catppuccin/nvim",          name = "catppuccin", priority = 1000 },
  { "ellisonleao/gruvbox.nvim", priority = 1000,     config = true,  opts = ... },

  "rebelot/kanagawa.nvim",
  "EdenEast/nightfox.nvim",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},

  },

  -- default
  {
    'freddiehaddad/feline.nvim',
    opts = {},
    config = function(_, opts)
    end
  },
  "nvim-lua/plenary.nvim",
  "williamboman/mason-lspconfig.nvim",
  "nvim-telescope/telescope.nvim",
  "BurntSushi/ripgrep",
  "williamboman/mason.nvim",
  "nvimdev/lspsaga.nvim",
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "tpope/vim-commentary",
  "tpope/vim-sleuth",
  "lewis6991/gitsigns.nvim",
  "nvim-treesitter/nvim-treesitter",
  'nvim-treesitter/nvim-treesitter-context',
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      source_selector = {
        winbar = false,
        statusline = false
      },
      filesystem = {
        hijack_netrw_behavior = 'open_default'
      }
    },
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },

  { 'akinsho/git-conflict.nvim', version = "*", config = true },
  -- {
  --   'romgrk/barbar.nvim',
  --   dependencies = {
  --     'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
  --     'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  --   },
  --   init = function()
  --     vim.g.barbar_auto_setup = false
  --     local map = vim.api.nvim_set_keymap
  --     local opts = { noremap = true, silent = true }

  --     -- Move to previous/next
  --     map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
  --     map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
  --   end,
  --   opts = {
  --     -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
  --     -- animation = true,
  --     -- insert_at_start = true,
  --     -- …etc.
  --   },
  -- },
});

-- editor config
vim.g.mapleader = ','
vim.o.background = 'dark'

vim.cmd('set number relativenumber');
vim.opt.nu = true

vim.opt.history = 500
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.swapfile = false

vim.cmd('set expandtab tabstop=4 shiftwidth=4')
vim.cmd('set clipboard+=unnamedplus')
vim.cmd('set re=0')

-- vim.cmd('set list')
-- vim.cmd('set lcs+=space:·')

vim.cmd('set undofile')
vim.cmd('set undodir=~/.vim/undodir')
vim.cmd('set textwidth=80')
vim.cmd('set wrapmargin=80')
vim.cmd('set wrap')
vim.cmd('set fo+=t')
vim.cmd('set linebreak')

vim.cmd('set foldmethod=syntax')
vim.cmd('set foldnestmax=10')
vim.cmd('set nofoldenable')
vim.cmd('set foldlevel=2')

-- color
vim.opt.termguicolors = true
-- vim.cmd.colorscheme "catppuccin-mocha"
-- vim.cmd.colorscheme "tokyonight-night"
-- vim.cmd.colorscheme "gruvbox"
-- vim.cmd.colorscheme 'terafox'
-- vim.cmd.colorscheme 'sorbet'
-- vim.cmd.colorscheme 'solarized-osaka'
vim.cmd.colorscheme 'rose-pine'

vim.cmd("set background=dark")
vim.cmd("syntax enable")
vim.cmd('au ColorScheme * hi Normal ctermbg=none guibg=none')
vim.cmd('hi Normal guibg=none')
vim.cmd('hi NonText guibg=none')
vim.cmd('hi SignColumn guibg=NONE')
vim.cmd('set signcolumn=yes:1');

-- editor highlight config
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'grey', bold = false })
vim.api.nvim_set_hl(0, 'LineNr', { fg = 'white', bold = true })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'grey', bold = false })

vim.api.nvim_set_hl(0, 'Visual', { bg = '#454545', bold = false })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none', bold = false })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#1f44a7', bold = false })
-- vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = 'NONE', bold = false })
-- vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'NONE', bold = false })

-- keybind key config keymap
vim.cmd('inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"')

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


vim.cmd('nnoremap <M-k>    :resize -2<CR>')
vim.cmd('nnoremap <M-j>    :resize +2<CR>')
vim.cmd('nnoremap <M-l>    :vertical resize -2<CR>')
vim.cmd('nnoremap <M-h>    :vertical resize +2<CR>')

vim.cmd("nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>")
vim.cmd(
  "nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>")

-- cmp config setup
-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

local cmp = require 'cmp'
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
local lspkind = require "lspkind"

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", lspkind.presets.default[vim_item.kind], vim_item.kind)
      vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "",
        treesitter = "",
        path = "[Path]",
        buffer = "",
        zsh = "[ZSH]",
        vsnip = "",
        spell = "暈",
      })[entry.source.name]

      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
    ['<CR>'] = cmp.mapping.confirm({
      select = false
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

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


local lspLists = { "ts_ls", "rust_analyzer", "gopls", "lua_ls", "prismals", "emmet_ls", "cssls", "volar",
  "intelephense", "tailwindcss", "dockerls", "yamlls", "clangd", "eslint", "jsonls", "jedi_language_server", "omnisharp" }

-- mason config
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = lspLists
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, buffer)
  if client.resolved_capabilities ~= nil then
    client.resolved_capabilities.document_formatting = true
  end
  -- if client.server_capabilities.inlayHintProvider then
  -- vim.lsp.diagnostic.enable(buffer, true)
  -- end
end

for _, server in ipairs(lspLists) do
  require('lspconfig')[server].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

require 'lspconfig'.stimulus_ls.setup {}


local cfg = {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  }
} -- add your config here
require "lsp_signature".setup(cfg)
-- lspsaga config
require('lspsaga').setup({
})

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
    vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')
    vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')

    vim.keymap.set('n', '<space>oo', organize_imports, opts)
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
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- trouble
vim.keymap.set('n', '<leader>tx', "<cmd>Trouble diagnostics toggle<cr>", {})
vim.keymap.set('n', '<leader>tX', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {})
vim.keymap.set('n', '<leader>ts', "<cmd>Trouble symbols toggle focus=false<cr>", {})
vim.keymap.set('n', '<leader>tl', "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {})
vim.keymap.set('n', '<leader>tL', "<cd>Trouble loclist toggle<cr>", {})
vim.keymap.set('n', '<leader>tQ', "<cmd>Trouble qflist toggle<cr>", {})

-- telescope config
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules", "vendor", ".git"
    }
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}
local builtin = require('telescope.builtin');
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- escape on normal mode
map('i', 'kk', '<Esc>')
-- Move around splits
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

map('n', '<leader>s', ':w<CR>')
map('n', '<leader>w', ':w<CR>')
map('n', '<C-q>', ':q!<CR>')

local signs = {
  Error = " ",
  Warn = " ",
  Hint = "",
  Info = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require('gitsigns').setup {
  signs                        = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir                 = {
    follow_files = true
  },
  attach_to_untracked          = true,
  current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts      = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority                = 6,
  update_debounce              = 100,
  status_formatter             = nil,   -- Use default
  max_file_length              = 40000, -- Disable if file is longer than this (in lines)
  preview_config               = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },

  on_attach                    = function(bufnr)
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

vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})

require 'colorizer'.setup()
require 'project_nvim'.setup({
  manual_mode = true
})

vim.cmd("let &fcs='eob: '")

map('n', '<leader>nn', ":Neotree toggle<cr>")
map('n', '<C-n>', ":Neotree toggle<cr>")

require 'nvim-treesitter.configs'.setup {

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,

  ignore_install = {},

  highlight = {
    enable = true,
  },
}

vim.cmd("nnoremap <leader>oo <Cmd>lua require'jdtls'.organize_imports()<CR>")


local line_ok, feline = pcall(require, "feline")
if not line_ok then
  return
end

local custom_theme = {
  fg = "fg",
  bg = "bg",
  green = "lightgreen",
  yellow = "yellow",
  purple = "purple",
  orange = "#d19a66",
  peanut = "#f6d5a4",
  red = "#e06c75",
  aqua = "#61afef",
  darkblue = "#1b1b27",
  dark_red = "#f75f5f",
}

local vi_mode_colors = {
  NORMAL = "green",
  OP = "green",
  INSERT = "yellow",
  VISUAL = "purple",
  LINES = "orange",
  BLOCK = "dark_red",
  REPLACE = "red",
  COMMAND = "aqua",
}

local c = {
  vim_mode = {
    provider = {
      name = "vi_mode",
      opts = {
        bg = "black",
        show_mode_name = true,
        padding = "center", -- Uncomment for extra padding.
      },
    },
    hl = function()
      return {
        fg = 'black',
        bg = require("feline.providers.vi_mode").get_mode_color(),
        style = "bold",
        name = "NeovimModeHLColor",
      }
    end,
    left_sep = "block",
    right_sep = "slant_right_2",
  },
  gitBranch = {
    provider = "git_branch",
    hl = {
      fg = "lightblue",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "block",
    right_sep = "block",
  },
  gitDiffAdded = {
    provider = "git_diff_added",
    hl = {
      fg = "green",
      bg = "darkblue",
    },
    left_sep = "block",
    right_sep = "block",
  },
  gitDiffRemoved = {
    provider = "git_diff_removed",
    hl = {
      fg = "red",
      bg = "darkblue",
    },
    left_sep = "block",
    right_sep = "block",
  },
  gitDiffChanged = {
    provider = "git_diff_changed",
    hl = {
      fg = "fg",
      bg = "darkblue",
    },
    left_sep = "block",
    right_sep = "right_filled",
  },
  separator = {
    provider = "",
  },
  fileinfo = {
    -- provider = {
    --   name = "file_info",
    --   opts = {
    --     type = "short",
    --   },
    -- },
    -- hl = {
    --   style = "bold",
    -- },
    -- left_sep = " ",
    -- right_sep = " ",
  },
  diagnostic_errors = {
    provider = "diagnostic_errors",
    hl = {
      fg = "red",
    },
  },
  diagnostic_warnings = {
    provider = "diagnostic_warnings",
    hl = {
      fg = "yellow",
    },
  },
  diagnostic_hints = {
    provider = "diagnostic_hints",
    hl = {
      fg = "aqua",
    },
  },
  diagnostic_info = {
    provider = "diagnostic_info",
  },
  lsp_client_names = {
    provider = "lsp_client_names",
    hl = {
      fg = "purple",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "left_filled",
    right_sep = "block",
  },
  file_type = {
    provider = {
      name = "file_type",
      opts = {
        filetype_icon = true,
        case = "titlecase",
      },
    },
    hl = {
      fg = "red",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "block",
    right_sep = "block",
  },
  file_encoding = {
    provider = "file_encoding",
    hl = {
      fg = "orange",
      bg = "darkblue",
      style = "italic",
    },
    left_sep = "block",
    right_sep = "block",
  },
  position = {
    provider = "position",
    hl = {
      fg = "green",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "block",
    right_sep = "block",
  },
  line_percentage = {
    provider = "line_percentage",
    hl = {
      fg = "aqua",
      bg = "darkblue",
      style = "bold",
    },
    left_sep = "block",
    right_sep = "block",
  },
  scroll_bar = {
    provider = "scroll_bar",
    hl = {
      fg = "lightblue",
      style = "bold",
    },
  },
}

local left = {
  c.vim_mode,
  c.gitBranch,
  c.gitDiffAdded,
  c.gitDiffRemoved,
  c.gitDiffChanged,
  c.separator,
}

local middle = {
  c.fileinfo,
  c.diagnostic_errors,
  c.diagnostic_warnings,
  c.diagnostic_info,
  c.diagnostic_hints,
}

local right = {
  c.file_type,
  c.file_encoding,
  c.position,
  c.line_percentage,
  c.scroll_bar,
}

local components = {
  active = {
    left,
    middle,
    right,
  },
  inactive = {
    left,
    middle,
    right,
  },
}

require('feline').setup({
  components = components,
  theme = custom_theme,
  vi_mode_colors = vi_mode_colors,
})

require("neo-tree").setup({
  source_selector = {
    winbar = false,
    statusline = false
  }
})

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })


require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end


require('mason-nvim-dap').setup({
  automatic_installation = true,
  ensure_installed = { 'node2', 'delve' },
  handlers = {
    function(config)
      -- all sources with no handler get passed here
      -- Keep original functionality
      require('mason-nvim-dap').default_setup(config)
    end,
  },
})
