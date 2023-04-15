-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(
            bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
    ["Q"] = { "<nop>", desc = "Prime told me to do this" },
    -- Quick Jump --
    ["L"] = { "J" },
    ["J"] = { "5j" },
    ["K"] = { "5k" },
    ["<C-0>"] = { ":ClangdSwitchSourceHeader<CR>" },
    -- Terminal
    ["<C-\\>"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
    -- Switch Header/Source --
    ["<leader>m"] = { ":ClangdSwitchSourceHeader<CR>", desc = "switch source-header" }
  },
  v = {
    -- Move Block --
    ["<C-j>"] = { ":m '>+1<CR>gv=gv" },
    ["<C-k>"] = { ":m '<-2<CR>gv=gv" },
    -- Quick Jump --
    ["J"] = { "5j" },
    ["K"] = { "5k" },
    -- Member Function --
    ["<leader>m"] = { ":TSCppDefineClassFunc<CR>:ClangdSwitchSourceHeader<CR>", desc = "nt-cpp-tools plugin" }
  },
  t = {
    ["<C-\\>"] = { "<cmd>ToggleTerm<cr>", desc = "ToggleTerm close" }
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
