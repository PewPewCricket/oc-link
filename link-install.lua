local shell = require("shell")

shell.execute("mkdir /etc/link.d")
shell.execute("wget https://raw.githubusercontent.com/PewPewCricket/oc-link/main/link.lua /etc/rc.d/link.lua")
shell.execute("rc link enable")
