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
  if not ops.q then
    print(string.format("removed link from list: %s", target))
  end
elseif fs.exists(target) and fs.isLink(target) then
  fs.remove(target)
  if not ops.q then
    print(string.format("removed link: %s", target))
  end
else
  io.stderr:write(string.format("target not found: %s", target))
end
