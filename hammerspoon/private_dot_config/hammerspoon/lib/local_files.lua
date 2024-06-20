local local_files = {}

function local_files.requireEach(dir, prefix, fn)
  for path in hs.fs.dir(hs.configdir .. "/" .. dir) do
    local name = path:match("^(" .. prefix ..".*)%.lua$")
    if name then
      local data = require(dir .. "." .. name)
      if fn then
        fn(data)
      end
    end
  end
end

return local_files
