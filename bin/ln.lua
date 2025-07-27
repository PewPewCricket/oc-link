local shell = require("shell")
local link = require("link")
local fs = require("filesystem")

local args, ops = shell.parse(...)

if #args == 0 or #args > 2 then
  io.write("Usage: ln <target> [name]\n")
  return 1
end

local target_name = args[1]
local target = shell.resolve(target_name)

local linkpath
if #args > 1 then
  linkpath = shell.resolve(args[2])
else
  linkpath = fs.concat(shell.getWorkingDirectory(), fs.name(target))
end

if fs.exists(linkpath) then
  io.stderr:write(string.format("file already exists: %s", linkpath))
elseif fs.exists(target) then
  link.create(target, linkpath)
  if not ops.v then
    print(string.format("added link to list: %s > %s", linkpath, target))
  end
else
  io.stderr:write(string.format("can't link to file: %s", target))
end
