return {
  "neovim/nvim-lspconfig",
  opts = {
    diagnostics = {
      enabled = false,
      virtual_text = false,
      -- signs = true,
      -- virtual_lines = true,
      virtual_lines = {
        -- TODO: would be nice to add a delay here, see https://github.com/neovim/neovim/discussions/33326
        current_line = true,
      },
    },
  },
}
