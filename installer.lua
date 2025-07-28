local shell =require("shell")
local fs = require("filesystem")

local args = shell.parse(...)
local targetDir = args[1] or "/"

local function get(file)
  shell.execute("wget https://raw.githubusercontent.com/PewPewCricket/oc-link/refs/heads/master/" .. file .. " " .. targetDir .. file)
end

fs.remove("/bin//ln.lua")

get("lib/link.lua")
get("etc/rc.d/link.lua")
get("bin/ln.lua")
get("bin/unlink.lua")
get("usr/man/ln")
get("usr/man/unlink")

shell.execute("rc link enable")

print("installation complete.")
