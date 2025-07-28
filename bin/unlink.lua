local shell = require("shell")
local link = require("link")
local fs = require("filesystem")

local args, ops = shell.parse(...)

if #args == 0 then
  io.write("Usage: unlink <target>\n")
  return 1
end

local link = args[1]
local target = shell.resolve(link)

local ok, err, tmp = link.remove(link)
if not ok and not tmp then
  io.stdout:write("unlink: " .. err)
end
