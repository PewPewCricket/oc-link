local fs = require("filesystem")

local function fileToTable(filename)
  local file = io.open(filename, "r")
  local fileData = {}
  for i in file:lines() do
    table.insert(fileData, i)
  end
  file:close()
  return fileData
end

local function findData(target, table)
  for i, v in pairs(table) do
    index = string.find(v, target)
    if index ~= nil then
      return i
    end
  end
  return false
end

function start()
  local fileData = fileToTable("/etc/link.d/links.list")
  local seperator = " > "
  local index = 0
  for j, v in pairs(fileData) do
    for i = 1, #v do
      local character = string.sub(v, i, i + #seperator - 1)
      if character == seperator then
        index = i
      end
    end
    fs.link(string.sub(v, index + #seperator, #v), string.sub(v, 1, index - 1)) 
  end
  print("link: symlinks created")
end

function stop()
  io.stderr:write("link: WARNING! service has stopped running, any created symlinks will not save after shutdown")
end

function remove(link)
  if not fs.exists(link) then
    io.stderr:write("target fiile not found: " .. link)
    return false
  end
  fs.remove(link)
  local fileData = fileToTable("/etc/link.d/links.list")
  local removeIndex = findData(link, fileData)
  for i, v in pairs(fileData) do
    i = removeIndex + 1
    fileData[i - 1] = fileData[i]
  end
  table.remove(fileData, #fileData)
  file = io.open("/etc/link.d/links.list", "w")
  for i, v in ipairs(fileData) do
    file:write(v .. "\n")
  end
  return true
end

function createTemp(link, target)
  if target == nil or target == "" then
    io.stderr:write("insufficent arguments")
    return false
  elseif not fs.exists(target) then
    io.stderr:write("target file not found: " .. target)
    return false
  else
    fs.link(target, link)
  end
end

function create(link, target)
  if target == nil or target == "" then
    io.stderr:write("insufficent arguments")
    return false
  elseif not fs.exists(target) then
    io.stderr:write("target file not found: " .. target)
    return false
  else
    fs.link(target, link)
    local file = io.open("/etc/link.d/links.list", "a")
    file:write(link .. " > " .. target .. "\n")
    file:close()
    return true
  end
end