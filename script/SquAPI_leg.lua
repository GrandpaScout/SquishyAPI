---@type SquAssets
local squassets = require("./SquAssets")

---@class SquAPI
local squapi = {}

---Contains all registered legs
---@type SquAPI.Leg[]
squapi.legs = {}

--TODO: Class-ify this, the SquAssets does not create proper class instances so they cannot be extended.
--      The SquAssets library may have to be modified to allow this.

---@Xclass SquAPI.Leg
squapi.leg = {}

---LEG MOVEMENT - Will make an element mimic the rotation of a vanilla leg, but allows you to control the strength. Good for different length legs or legs under dresses.
---@param element ModelPart The element you want to apply the movement to.
---@param strength? number Defaults to `1`, how much it rotates.
---@param isRight? boolean Defaults to `false`, if this is the right leg or not.
---@param keepPosition? boolean Defaults to `true`, if you want the element to keep it's position as well.
---@return SquAPI.Leg
function squapi.newLeg(element, strength, isRight, keepPosition)
  ---@class SquAPI.Leg
  local self = squassets.vanillaElement:new(element, strength, keepPosition)

  -- INIT -------------------------------------------------------------------------
  if isRight == nil then isRight = false end
  self.isRight = isRight

  -- CONTROL -------------------------------------------------------------------------

  -- UPDATES -------------------------------------------------------------------------

  ---Returns the vanilla leg rotation and position vectors
  ---@return Vector3 #Vanilla leg rotation
  ---@return Vector3 #Vanilla leg position
  function self:getVanilla()
    if self.isRight then
      self.rot = vanilla_model.RIGHT_LEG:getOriginRot()
      self.pos = vanilla_model.RIGHT_LEG:getOriginPos()
    else
      self.rot = vanilla_model.LEFT_LEG:getOriginRot()
      self.pos = vanilla_model.LEFT_LEG:getOriginPos()
    end
    return self.rot, self.pos
  end

  table.insert(squapi.legs, self)
  return self
end

---For compatibility
---@param element ModelPart The element you want to apply the movement to.
---@param strength? number Defaults to `1`, how much it rotates.
---@param isRight? boolean Defaults to `false`, if this is the right leg or not.
---@param keepPosition? boolean Defaults to `true`, if you want the element to keep it's position as well.
---@return SquAPI.Leg
function squapi.leg:new(element, strength, isRight, keepPosition)
  return squapi.newLeg(element, strength, isRight, keepPosition)
end

---@diagnostic disable-next-line: undefined-global
if not SQUAPI_NoAutoUpdate then
  events.render:register(function(dt)
    for _, leg in ipairs(squapi.legs) do
      leg:render(dt)
    end
  end, "SquAPI_Leg")
end

return squapi
