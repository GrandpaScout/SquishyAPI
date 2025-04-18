---@type SquAssets
local squassets = require("./SquAssets")

---@class SquAPI
local squapi = {}

---Contains all registered arms
---@type SquAPI.Arm[]
squapi.arms = {}

--TODO: Class-ify this, the SquAssets does not create proper class instances so they cannot be extended.
--      The SquAssets library may have to be modified to allow this.

---@Xclass SquAPI.Leg
squapi.arm = {}


---ARM MOVEMENT - Will make an element mimic the rotation of a vanilla arm, but allows you to control the strength. Good for different length arms.
---@param element ModelPart The element you want to apply the movement to.
---@param strength? number Defaults to `1`, how much it rotates.
---@param isRight? boolean Defaults to `false`, if this is the right arm or not.
---@param keepPosition? boolean Defaults to `true`, if you want the element to keep it's position as well.
---@return SquAPI.Arm
function squapi.newArm(element, strength, isRight, keepPosition)
  ---@class SquAPI.Arm
  local self = squassets.vanillaElement:new(element, strength, keepPosition)

  -- INIT -------------------------------------------------------------------------
  if isRight == nil then isRight = false end
  self.isRight = isRight

  -- CONTROL -------------------------------------------------------------------------

  --inherits functions from squassets.vanillaElement

  -- UPDATES -------------------------------------------------------------------------

  ---Returns the vanilla arm rotation and position vectors
  ---@return Vector3 #Vanilla arm rotation
  ---@return Vector3 #Vanilla arm position
  function self:getVanilla()
    if self.isRight then
      self.rot = vanilla_model.RIGHT_ARM:getOriginRot()
    else
      self.rot = vanilla_model.LEFT_ARM:getOriginRot()
    end
    self.pos = -vanilla_model.LEFT_ARM:getOriginPos()
    return self.rot, self.pos
  end

  table.insert(squapi.arms, self)
  return self
end

---For compatibility
---@param element ModelPart The element you want to apply the movement to.
---@param strength? number Defaults to `1`, how much it rotates.
---@param isRight? boolean Defaults to `false`, if this is the right arm or not.
---@param keepPosition? boolean Defaults to `true`, if you want the element to keep it's position as well.
---@return SquAPI.Arm
function squapi.arm:new(element, strength, isRight, keepPosition)
  return squapi.newArm(element, strength, isRight, keepPosition)
end

---@diagnostic disable-next-line: undefined-global
if not SQUAPI_NoAutoUpdate then
  events.render:register(function(dt)
    for _, arm in ipairs(squapi.arms) do
      arm:render(dt)
    end
  end, "SquAPI_Arm")
end

return squapi
