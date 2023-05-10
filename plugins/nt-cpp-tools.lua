return {
  {
    event = {
      "BufEnter *.cpp",
      "BufEnter *.cxx",
      "BufEnter *.cc",
    },
    "Badhi/nvim-treesitter-cpp-tools",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    name = "nt-cpp-tools",
    config = function()
      require("nt-cpp-tools").setup({
        preview = {
          quit = 'q',
          accept = '<CR>'
        },
        header_extension = 'hpp',
        source_extension = 'cpp',
      })
    end,
  }
}
