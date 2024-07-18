local fs = require("filesystem")
local link = require("link")
local ftable = require("tools/ftable")

function start()
  local fileData = ftable.fileToTable("/etc/link.d/links.list")
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
