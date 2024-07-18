local shell = require("shell")
local link = require("link")
local futils = require("tools/futils")
local fs = require("filesystem")
local args, ops = shell.parse(...)

local args = shell.parse(...)
if #args == 0 then
  io.write("Usage: unlink <target>\n")
  return 1
end

local target_name = args[1]
local target = shell.resolve(target_name)

-- Remove a link from the list
if futils.findData(target, futils.fileToTable("/etc/link.lst")) ~= nil then
  link.remove(target)
  print(string.format("removed link from list: %s", target))
elseif fs.exists(target) and fs.isLink(target) then
  fs.remove(target)
  print(string.format("removed temporary link: %s", target))
else
  io.stderr:write(string.format("link not found: %s", target))
end
