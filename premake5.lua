--[[
	A simple project definition for glfw_dx.
	In the main application premake5.lua define a workspace,
	and after that use the `include` function to include this project.
	
	The beginning of your main project may look as such:

```
workspace "ExampleWS"
	...
	...	

include "glfw_dx"

projects "ExampleApp"
	links {"glfw_dx", ...}
	includedirs {"./glfw_dx/include", ...}
	...
```
--]]

project "glfw_dx"
	-- This project (for now) is exclusively statically linked.
	kind "StaticLib"

	-- Source definitions
	files {
		"./src/*.c"
	}
	
	links {}

	objdir "./bin/obj/%{cfg.buildcfg}"
	targetdir "./bin/%{cfg.buildcfg}"

	-- Operating system detection
	if os.target() == "linux" then
		local handle = io.popen("echo $XDG_SESSION_TYPE")
		if handle:read("l") == "x11" then
			print("using x11")
			defines {
				"_GLFW_X11"
			}
		else
			print("using wayland [not implemented]")
			defines {
				"_GLFW_WAYLAND"
			}
			os.exit() -- NEEDS TO BE TESTED
		end
		handle:close()
	else
		print("only supporting linux x11. sorry")
	end

-- EOF	
