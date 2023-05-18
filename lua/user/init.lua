return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use
  colorscheme = "tokyonight",

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          "c",
          "cpp",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- hacky fix for clangd warning (non-important)
    local notify = vim.notify
    vim.notify = function(msg, ...)
      if msg:match("warning: multiple different client offset_encodings") then
        return
      end
      notify(msg, ...)
    end

    -- Set up custom filetypes
    vim.filetype.add {
      extension = {
        vert = "glsl",
        frag = "glsl",
        tesc = "glsl",
        tese = "glsl",
        geom = "glsl",
        comp = "glsl",
      },
      --   filename = {
      --     ["Foofile"] = "fooscript",
      --   },
      --   pattern = {
      --     ["~/%.config/foo/.*"] = "fooscript",
      --   },
    }
    vim.cmd [[hi DiagnosticVirtualTextError guibg=clear]]
    vim.cmd [[hi DiagnosticVirtualTextWarn guibg=clear]]
    vim.cmd [[hi DiagnosticVirtualTextHint guibg=clear]]
    vim.cmd [[hi DiagnosticVirtualTextInfo guibg=clear]]
    vim.cmd [[hi DiagnosticVirtualTextOk guibg=clear]]
    vim.cmd [[hi Visual guibg=#24283b]]

    vim.cmd [[autocmd BufEnter *      :setlocal tabstop=4 shiftwidth=4]]
    vim.cmd [[autocmd BufEnter *.s    :setlocal tabstop=8 shiftwidth=8]]
    vim.cmd [[autocmd BufEnter *.asm  :setlocal tabstop=8 shiftwidth=8]]
    vim.cmd [[autocmd BufEnter *.ts*  :setlocal tabstop=2 shiftwidth=2]]
    vim.cmd [[autocmd BufEnter *.js*  :setlocal tabstop=2 shiftwidth=2]]
    vim.cmd [[autocmd BufEnter *.lua  :setlocal tabstop=2 shiftwidth=2]]
    vim.cmd [[autocmd BufEnter *.html :setlocal tabstop=2 shiftwidth=2]]
    vim.cmd [[autocmd BufEnter *.css  :setlocal tabstop=2 shiftwidth=2]]
    vim.cmd [[autocmd BufEnter *.xml  :setlocal tabstop=2 shiftwidth=2]]

    vim.cmd [[augroup tmux | au!]]
    vim.cmd [[autocmd BufEnter,FocusGained * :call writefile(["nvim_buffer='" . expand("%:p") . "'"], "/home/jon/.config/tmux/plugins/tmux-essentials/data/nvim_buffer")]]
    vim.cmd [[autocmd VimLeave,BufLeave,FocusLost * :call writefile(["nvim_buffer=''"], "/home/jon/.config/tmux/plugins/tmux-essentials/data/nvim_buffer")]]

    vim.cmd [[autocmd BufEnter * :set colorcolumn=81]]
    vim.cmd [[autocmd BufEnter * :hi VirtColumn guifg=#24283b]]
  end,
}
