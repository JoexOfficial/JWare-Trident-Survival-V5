--|| BYPASSES | SPOOFS ||--
HitboxSpoof = {}
LongNeckSpoof = {}
GrassSpoof = {}
XRaySpoof = {}
NightVisionSpoof = {}
FovSpoof = {}
FogSpoof = {}
ShadowSpoof = {}
CloudsSpoof = {}

--|| BLOCKS AC READS ||--
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldIndex = mt.__index
mt.__index = newcclosure(function(self, key)

    --Hitbox
    if HitboxSpoof[self] then
        if key == "Size" then
            if self.Name == "Head" then
                return Vector3.new(1.672248125076294, 0.835624098777771, 0.835624098777771)
            elseif self.Name == "Torso" then
                return Vector3.new(0.6530659198760986, 2.220424175262451, 1.4367451667785645)
            end
        elseif key == "Transparency" then
            return 0
        elseif key == "CanCollide" then
            return true
        end
    end

    --LongNeck
    if LongNeckSpoof[self] then
        if key == "UpperLimit" then
            return 3
        elseif key == "LowerLimit" then
            return 1.649999976158142
        end
    end

    --Grass
    if GrassSpoof[self] and key == "Decoration" then
        return true
    end

    --XRay
    if XRaySpoof[self] and key == "Transparency" then
        return 0
    end

    --NightVision
    if NightVisionSpoof[self] and key == "ExposureCompensation" then
        return 0
    end

    --FOV
    if FovSpoof[self] then
        if key == "FieldOfView" then
            return 70
        elseif key == "DiagonalFieldOfView" then
            return 127.76887512207031
        elseif key == "MaxAxisFieldOfView" then
            return 102.44786071777344
        end
    end

    --Fog
    if FogSpoof[self] and key == "FogEnd" then
        return 900
    end

    --Shadow
    if ShadowSpoof[self] and key == "GlobalShadows" then
        return true
    end

    --Clouds
    if CloudsSpoof[self] and key == "Enabled" then
        return true
    end

    return oldIndex(self, key)
end)

--|| BLOCKS AC WRITES ||--
local oldNewIndex = mt.__newindex
mt.__newindex = newcclosure(function(self, key, value)

    --Hitbox
    if HitboxSpoof[self] then
        if (key == "Size" or key == "Transparency" or key == "CanCollide") and not checkcaller() then
            return
        end
    end

    --LongNeck
    if LongNeckSpoof[self] then
        if (key == "UpperLimit" or key == "LowerLimit") and not checkcaller() then
            return
        end
    end

    --Grass
    if GrassSpoof[self] then
        if (key == "Decoration") and not checkcaller() then
            return
        end
    end

    --XRay
    if XRaySpoof[self] then
        if (key == "Transparency") and not checkcaller() then
            return
        end
    end

    --NighVision
    if NightVisionSpoof[self] then
        if (key == "ExposureCompensation") and not checkcaller() then
            return
        end
    end

    --FOV
    if FovSpoof[self] then
        if (key == "FieldOfView" or key == "DiagonalFieldOfView" or key == "MaxAxisFieldOfView") then
            if checkcaller() then
                return oldNewIndex(self, key, value)
            else
                return
            end
        end
    end

    --Fog
    if FogSpoof[self] and key == "FogEnd" then
        if checkcaller() then
            return oldNewIndex(self, key, value)
        else
            return
        end
    end

    --Shadow
    if ShadowSpoof[self] then
        if (key == "GlobalShadows") and not checkcaller() then
            return
        end
    end

    --Clouds
    if CloudsSpoof[self] then
        if (key == "Enabled") and not checkcaller() then
            return
        end
    end

    return oldNewIndex(self, key, value)
end)

setreadonly(mt, true)
