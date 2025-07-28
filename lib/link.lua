local fs = require("filesystem")

local listFile = "/etc/link.lst"

local link = {}

local function fileToTable(filename)
    local t = {}
    local file, err = io.open(filename, "r")
    if not file then
      return nil, err
    else
        for line in file:lines() do
            table.insert(t, line)
        end
        file:close()
    end
    return t
end

local function strsplit(str, separator)
    local escaped_separator = separator:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
    local pattern = string.format("(.+)%s(.+)", escaped_separator)
    local part1, part2 = str:match(pattern)
    return part1, part2
end

-- Create a link
link.create = function(link, linkto)
  link = fs.canonical(link)
  linkto = fs.canonical(linkto)
  if not fs.exists(listFile) then
    local handle, err = io.open(listFile, "w")
    if not handle then
      return nil, err
    else
      handle.close()
    end
  end
  
  local list, err = io.open(listFile, "a")
  if not list then
    return nil, err
  else
    local ok, err = list:write(link .. ">" .. linkto .. '\n')
    if not ok then
      list.close()
      return nil, err
    else
      fs.link(linkto, link)
      return true
    end
  end
end

-- Delete a link
link.remove = function(target)
  target = fs.canonical(target)
  if not fs.exists(target) then
    return nil, err, true
  else
    fs.remove(target)
  end
  local lines, err = fileToTable(listFile)
  if not data 
    return nil, err
  else
    io.open(listFile, "w"):close()
    local list = io.open(listFile, "a")
    for line in lines do
      local link, linkto = strsplit(line, '>')
      if not link == target then
        list:write(line .. '\n')
      end
    end
    return true
  end
end

-- Restore all links in list
link.restore = function()
  local lines, err = fileToTable(listFile)
  if not data 
    return nil, err
  else
    for line in lines do
      local link, linkto = strsplit(line, '>')
      fs.link(linkto, link)
    end
    return true
  end
end

return link
