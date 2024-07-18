local fs = require("filesystem")
local lib = {}

function lib.fileToTable(filename)
  local file = io.open(filename, "r")
  local fileData = {}
  for i in file:lines() do
    table.insert(fileData, i)
  end
  file:close()
  return fileData
end

function lib.findData(target, table)
  for i, v in pairs(table) do
    index = string.find(v, target)
    if index ~= nil then
      return i
    end
  end
  return false
end

return lib