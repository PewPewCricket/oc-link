local shell =require("shell")

local args = shell.parse(...)
local targetDir = args[1] or "/"

local function get(file)
  shell.execute("wget https://raw.githubusercontent.com/PewPewCricket/oc-link/refs/heads/main/" .. file .. " " .. targetDir .. file)
end

get("lib/link.lua")
get("etc/rc.d/link.lua")
get("bin/ln.lua")
get("usr/man/ln")

shell.execute("rc link enable")

print("installation complete.")
