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
  -- colorscheme = "tokyonight",
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
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "clangd"
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

    vim.cmd [[autocmd BufEnter *.vert :setlocal ft=glsl]]
    vim.cmd [[autocmd BufEnter *.frag :setlocal ft=glsl]]
    vim.cmd [[autocmd BufEnter *.tesc :setlocal ft=glsl]]
    vim.cmd [[autocmd BufEnter *.tese :setlocal ft=glsl]]
    vim.cmd [[autocmd BufEnter *.geom :setlocal ft=glsl]]
    vim.cmd [[autocmd BufEnter *.comp :setlocal ft=glsl]]

    vim.cmd [[hi DiagnosticVirtualTextError guibg=clear]]
    vim.cmd [[hi DiagnosticVirtualTextWarn guibg=clear]]
    vim.cmd [[hi DiagnosticVirtualTextHint guibg=clear]]

    vim.cmd [[autocmd BufEnter * :setlocal tabstop=4 shiftwidth=4]]
    vim.cmd [[autocmd BufEnter *.ts* :setlocal tabstop=2 shiftwidth=2]]
    vim.cmd [[autocmd BufEnter *.js* :setlocal tabstop=2 shiftwidth=2]]
    vim.cmd [[autocmd BufEnter *.lua :setlocal tabstop=2 shiftwidth=2]]
    vim.cmd [[autocmd BufEnter *.html :setlocal tabstop=2 shiftwidth=2]]

    vim.cmd [[augroup tmux | au!]]
    vim.cmd [[autocmd BufEnter,FocusGained * :call writefile(["vim_buf='" . expand("%:p") . "'"], "/home/jon/.vim/buf")]]
    vim.cmd [[autocmd VimLeave,BufLeave,FocusLost * :call writefile(["vim_buf=''"], "/home/jon/.vim/buf")]]

    vim.cmd [[autocmd BufEnter * :set colorcolumn=81]]
    vim.cmd [[autocmd BufEnter * :hi VirtColumn guifg=#24283b]]
  end,
}
