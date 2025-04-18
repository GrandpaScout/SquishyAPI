--[[--------------------------------------------------------------------------------------
███████╗ ██████╗ ██╗   ██╗██╗███████╗██╗  ██╗██╗   ██╗     █████╗ ██████╗ ██╗
██╔════╝██╔═══██╗██║   ██║██║██╔════╝██║  ██║╚██╗ ██╔╝    ██╔══██╗██╔══██╗██║
███████╗██║   ██║██║   ██║██║███████╗███████║ ╚████╔╝     ███████║██████╔╝██║
╚════██║██║▄▄ ██║██║   ██║██║╚════██║██╔══██║  ╚██╔╝      ██╔══██║██╔═══╝ ██║
███████║╚██████╔╝╚██████╔╝██║███████║██║  ██║   ██║       ██║  ██║██║     ██║
╚══════╝ ╚══▀▀═╝  ╚═════╝ ╚═╝╚══════╝╚═╝  ╚═╝   ╚═╝       ╚═╝  ╚═╝╚═╝     ╚═╝
--]] --------------------------------------------------------------------------------------ANSI Shadow

-- Author: Squishy
-- Discord tag: @mrsirsquishy

-- Version: 1.1.0
-- Legal: ARR

-- Special Thanks to
-- @jimmyhelp for errors and just generally helping me get things working.
-- FOX (@bitslayn) for overhauling annotations and clarity, and for fleshing out some functionality(fr big thanks)

-- IMPORTANT FOR NEW USERS!!! READ THIS!!!

-- Thank you for using SquAPI! Unless you're experienced and wish to actually modify the functionality
-- of this script, I wouldn't recommend snooping around.
-- Don't know exactly what you're doing? this site contains a guide on how to use!(also linked on github):
-- https://mrsirsquishy.notion.site/Squishy-API-Guide-3e72692e93a248b5bd88353c96d8e6c5

-- this SquAPI file does have some mini-documentation on paramaters if you need like a quick reference, but
-- do not modify, and do not copy-paste code from this file unless you are an avid scripter who knows what they are doing.


-- Don't be afraid to ask me for help, just make sure to provide as much info as possible so I or someone can help you faster.






--setup stuff

-- Locates SquAssets, if it exists
-- Written by FOX
---@class SquAssets
local squassets
for _, path in ipairs(listFiles("/", true)) do
  if string.find(path, "SquAssets") then squassets = require(path) end
end
assert(squassets, "§4Missing SquAssets file! Make sure to download that from the GitHub too!§c")

---@class SquAPI
local squapi = {}


-- SQUAPI CONTROL VARIABLES AND CONFIG ----------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-- these variables can be changed to control certain features of squapi.


--when true it will automatically tick and update all the functions, when false it won't do that.  
--if false, you can run each objects respective tick/update functions on your own - better control.
squapi.autoFunctionUpdates = true


-- LOAD MODULES -----------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

local module_names = {
  "tail",
  "ear",
  "crouch",
  "bewb",
  "randimation",
  "eye",
  "hoverpoint",
  "leg",
  "arm",
  "smoothhead",
  "bouncewalk",
  "taur",
  "fphand",
  "animatetexture"
}

SQUAPI_NoAutoUpdate = not squapi.autoFunctionUpdates
for _, name in ipairs(module_names) do
  --- Search for `./SquAPI_*.lua` first, then attempt `./SquAPI/SquAPI_*.lua`
  local success, module = pcall(require, "./SquAPI_" .. name)
  if not success then success, module = pcall(require, "./SquAPI/SquAPI_" .. name) end

  if success then
    for key, value in pairs(module) do
      squapi[key] = value
    end
  end
end
SQUAPI_NoAutoUpdate = nil

return squapi
