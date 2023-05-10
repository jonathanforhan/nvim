return {
  {
    'simrat39/rust-tools.nvim',
    event = { "BufEnter *.rs" },
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap'
    },
    config = function()
      require('rust-tools').setup()
    end
  }
}
