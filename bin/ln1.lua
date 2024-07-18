local shell = require("shell")
local link = require("link")
local futils = require("tools/futils")
local fs = require("filesystem")
local args, ops = shell.parse(...)

local args = shell.parse(...)
if #args == 0 or #args > 2 then
  io.write("Usage: ln <target> [<name>]\n")
  return 1
end

local target_name = args[1]
local target = shell.resolve(target_name)
local link = nil

-- remove a symlink
if ops.r then
  if futils.findData(target, futils.fileToTable("/etc/link.lst")) ~= nil then
    link.remove(target)
    print(string.format("removed link from list: %s", target))
  elseif fs.exists(target) and fs.isLink(target) then
    fs.remove(target)
    print(string.format("removed temporary link: %s", target))
  else
    io.stderr:write(string.format("link not found: %s", target))
  end
-- create a symlink
else
  if #args == 1 then
    link = --
  if fs.exists(link) then
    io.stderr:write(string.format("file already exists: %s", link))
  elseif fs.exists(target) then
    link.create(target, link)
    print(string.format("added link to list: %s > %s", link), target))
  else
    io.stderr:write(string.format("can't link to file: %s", target))
  end
end
