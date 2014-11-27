ext.appscript = function(...)
  local args = {n = select('#', ...), ...}
  local cmd = "/usr/bin/osascript"
  for i = 1, #args do
    cmd = cmd .. " -e '" .. args[i]:gsub("'", "\'") .. "'"
  end
  return hydra.exec(cmd, true)
end
