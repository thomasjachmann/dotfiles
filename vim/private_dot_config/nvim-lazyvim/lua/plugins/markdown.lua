return {
  { -- extend lazyvim's markdown plugin configuration
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        -- signs = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        width = "block",
      },
      code = {
        sign = true,
        width = "full",
        language_icon = true,
        border = "thin",
      },
      checkbox = {
        enabled = true,
        bullet = true, -- don't hide the bullet point before a checkbox for less wiggle
      },
      pipe_table = {
        border_enabled = false, -- disable top bottom borders for less wiggle
      },
    },
  },
  { -- add plugin to edit (add/modify/format) markdown tables
    "SCJangra/table-nvim",
    ft = "markdown",
  },
}
