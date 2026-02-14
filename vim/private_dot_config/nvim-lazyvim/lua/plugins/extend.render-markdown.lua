return {
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
    },
    pipe_table = {
      border_enabled = false, -- disable top bottom borders for less wiggle
    },
  },
}
