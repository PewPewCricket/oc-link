local shell = require("shell")

shell.execute("mkdir /etc/link.d")
shell.execute("wget url /etc/rc.d/link.lua")
shell.execute("rc link enable")