return {
  event = "BufEnter",
  "lukas-reineke/virt-column.nvim",
  config = function()
    require("virt-column").setup()
  end
}
