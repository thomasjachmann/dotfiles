local function reload()
  hydra.reload()
  hydra.alert("Hydra config reloaded", 1)
end

function load(...)
  local files = {n = select('#', ...), ...}
  for i = 1, #files do
    local file = hydra.userfile(files[i])
    dofile(file)
    pathwatcher.new(file, reload):start()
  end
end

pathwatcher.new(hydra.userfile("init"), reload):start()
pathwatcher.new(hydra.userfile("loader"), reload):start()
