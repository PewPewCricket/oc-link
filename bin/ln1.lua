local shell = require("shell")
local ld = require("ld")
local futils = require("tools/futils")
local fs = require("filesystem")
local args, ops = shell.parse(...)

if ops.r then     --Remove a symlink
  if args[1] == nil then
    shell.execute("man ld")
  elseif futils.findData(shell.resolve(args[1]), futils.fileToTable("/etc/ld.lst")) ~= nil then
    ld.remove(shell.resolve(args[1]))
    print(string.format("removed link from list: %s", shell.resolve(args[1])))
  elseif fs.exists(shell.resolve(args[1])) and fs.isLink(shell.resolve(args[1])) then
    fs.remove(shell.resolve(args[1]))
    print(string.format("removed temporary link: %s", shell.resolve(args[1])))
  else
    io.stderr:write(string.format("link not found: %s", shell.resolve(args[1])))
  end
else              --Create a permanant symlink
  if args[1] == nil or args[2] == nil then
    shell.execute("man ld")
  elseif fs.exists(shell.resolve(args[2])) then
    io.stderr:write(string.format("file already exists: %s", shell.resolve(args[1])))
  elseif fs.exists(shell.resolve(args[1])) then
    ld.create(shell.resolve(args[1]), shell.resolve(args[2]))
    print(string.format("added link to list: %s > %s", shell.resolve(args[2]), shell.resolve(args[1])))
  else
    io.stderr:write(string.format("can't link to file: %s", shell.resolve(args[1])))
  end
end
