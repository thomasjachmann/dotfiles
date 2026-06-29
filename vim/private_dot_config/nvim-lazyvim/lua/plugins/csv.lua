return {
  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    ft = { "csv" },
    config = function(_, opts)
      require("csvview").setup(opts)

      Snacks.toggle({
        name = "CSV View",
        get = function()
          return require("csvview").is_enabled(0)
        end,
        set = function(state)
          if state then
            -- see https://github.com/hat0uma/csvview.nvim/blob/5c22774c3ecc7f8883af5d143b366e45b1f0875d/plugin/csvview.lua#L4
            require("csvview").enable(0, {
              parser = { delimiter = "," },
              view = { display_mode = "border" },
            })
          else
            require("csvview").disable(0)
          end
        end,
      }):map("<leader>uv")
    end,
  },
}
