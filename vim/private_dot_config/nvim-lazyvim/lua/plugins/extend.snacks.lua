return {
  "folke/snacks.nvim",
  opts = {
    gitbrowse = {
      config = function(opts, _)
        -- recognize self-hosted gitlab instances as long as there's gitlab somewhere in the URL
        opts.url_patterns["gitlab"] = opts.url_patterns["gitlab%.com"]
      end,
    },
    picker = {
      sources = {
        -- show all files in pickers
        files = {
          hidden = true,
          ignored = true,
        },
        -- show all files in explorer
        explorer = {
          hidden = true,
          ignored = true,
        },
        -- show all files in grep
        grep = {
          hidden = true,
          ignored = true,
        },
      },
    },
  },
  -- see https://github.com/folke/snacks.nvim/discussions/1069
  -- keys = {
  --   {
  --     "<leader>sf",
  --     function()
  --       local Snacks = require("snacks")
  --       Snacks.picker({
  --         finder = "proc",
  --         cmd = "fd",
  --         args = { "--type", "d", "--exclude", ".git" },
  --         title = "Select search directory",
  --         layout = {
  --           preset = "select",
  --         },
  --         actions = {
  --           confirm = function(picker, item)
  --             picker:close()
  --             vim.schedule(function()
  --               Snacks.picker.grep({
  --                 cwd = item.file,
  --               })
  --             end)
  --           end,
  --         },
  --         transform = function(item)
  --           item.file = item.text
  --           item.dir = true
  --         end,
  --       })
  --     end,
  --     desc = "Search in dir",
  --   },
  -- },
}
