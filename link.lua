local shell = require("shell")
local link = require("link")
local ftable = require("tools/ftable")
local fs = require("filesystem")
local args, ops = shell.parse(...)

if ops.r then     --Remove a symlink
  if args[1] == nil then
    shell.execute("man link")
  elseif ftable.findData(shell.resolve(args[1]), ftable.fileToTable("/etc/link.d/links.list")) ~= nil then
    link.remove(shell.resolve(args[1]))
    print(string.format("removed link from list: %s", shell.resolve(args[1])))
  elseif fs.exists(shell.resolve(args[1])) and fs.isLink(shell.resolve(args[1])) then
    fs.remove(shell.resolve(args[1]))
    print(string.format("removed temporary link: %s", shell.resolve(args[1])))
  else
    io.stderr:write(string.format("link not found: %s", shell.resolve(args[1])))
  end
elseif ops.t then --Create a temporary symlink
  if args[1] == nil or args[2] == nil then
    shell.execute("man link")
  elseif fs.exists(shell.resolve(args[1])) then
    io.stderr:write(string.format("file already exists: %s", shell.resolve(args[1])))
  elseif fs.exists(shell.resolve(args[2])) then
    link.createTemp(shell.resolve(args[1]), shell.resolve(args[2]))
    print(string.format("created temporary link: %s > %s", shell.resolve(args[1]), shell.resolve(args[2])))
  else
    io.stderr:write(string.format("can't link to file: %s", shell.resolve(args[2])))
  end
else              --Create a permanant symlink
  if args[1] == nil or args[2] == nil then
    shell.execute("man link")
  elseif fs.exists(shell.resolve(args[1])) then
    io.stderr:write(string.format("file already exists: %s", shell.resolve(args[1])))
  elseif fs.exists(shell.resolve(args[2])) then
    link.create(shell.resolve(args[1]), shell.resolve(args[2]))
    print(string.format("added link to list: %s > %s", shell.resolve(args[1]), shell.resolve(args[2])))
  else
    io.stderr:write(string.format("can't link to file: %s", shell.resolve(args[2])))
  end
end