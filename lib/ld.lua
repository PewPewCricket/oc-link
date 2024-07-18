local fs = require("filesystem")
local futils = require("tools/futils")
local lib = {}

function lib.remove(link)
  fs.remove(link)
  local fileData = futils.fileToTable("/etc/ld.lst")
  local removeIndex = futils.findData(link, fileData)
  table.remove(fileData, removeIndex)
  file = io.open("/etc/ld.lst", "w")
  for i, v in ipairs(fileData) do
    file:write(v .. "\n")
  end
  return true
end

function lib.create(target, link)
  fs.link(target, link)
  local file = io.open("/etc/ld.lst", "a")
  file:write(string.format("%s > %s\n", link, target))
  file:close()
  return
end

return lib
