local function toggleAutolaunch()
  autolaunch.set(not autolaunch.get())
end

menu.show(function()
    return {
      {title = "Reload Config", fn = hydra.reload},
      {title = "Open at Login", checked = autolaunch.get(), fn = toggleAutolaunch},
      {title = "-"},
      {title = "About", fn = hydra.showabout},
      {title = "Quit Hydra", fn = os.exit},
    }
end)
