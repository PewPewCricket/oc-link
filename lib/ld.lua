local fs = require("filesystem")
local ftable = require("tools/ftable")
local lib = {}

function lib.remove(link)
  fs.remove(link)
  local fileData = ftable.fileToTable("/etc/link.d/links.list")
  local removeIndex = ftable.findData(link, fileData)
  table.remove(fileData, removeIndex)
  file = io.open("/etc/link.d/links.list", "w")
  for i, v in ipairs(fileData) do
    file:write(v .. "\n")
  end
  return true
end

function lib.createTemp(link, target)
  fs.link(target, link)
  return
end

function lib.create(link, target)
  fs.link(target, link)
  local file = io.open("/etc/link.d/links.list", "a")
  file:write(string.format("%s > %s\n", link, target))
  file:close()
  return
end

return lib
