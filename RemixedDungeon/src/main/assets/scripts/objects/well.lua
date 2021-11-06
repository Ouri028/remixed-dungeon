---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by mike.
--- DateTime: 9/25/21 7:41 PM
---

local RPD = require "scripts/lib/commonClasses"

local object = require "scripts/lib/object"


return object.init{
    init = function(self, object, level, data)

        self.data = {water = data}

        local pos = object:getPos()

        if level:blobAmountAt(RPD.Blobs.WaterOfAwareness, pos) > 0 then
            self.data.water = 'WaterOfAwareness'
            return
        end

        if level:blobAmountAt(RPD.Blobs.WaterOfHealth, pos) > 0 then
            self.data.water = 'WaterOfHealth'
            return
        end

        if level:blobAmountAt(RPD.Blobs.WaterOfTransmutation, pos) > 0 then
            self.data.water = 'WaterOfTransmutation'
            return
        end

        if self.data.water and string.len(self.data.water) > 0 then
            RPD.glog("water |%s|", self.data.water)
            RPD.placeBlob(RPD.Blobs[self.data.water],pos,1, level)
        end

    end,

    bump = function(self, object, presser)
        RPD.glog("This well full of %s", self.data.water )
        if self.data.water then
            object:level():getBlobByName(self.data.water):affect()
            self.data.water = nil
        end
    end,

    stepOn = function(self, object, hero)
        return true
    end,

    --[[
    interact = function(self, object, hero)
        RPD.glog("This is a well %s", hero:name())
        return false
    end,
]]
    textureFile = function(self, object, level)
        if RPD.DungeonTilemap:kind(level) == 'xyz' then
            return "levelObjects/objects.png"
        else
            return level:getTilesTex()
        end
    end,

    image = function(self, object, level)
        if RPD.DungeonTilemap:kind(level) == 'xyz' then
            return 16 * 5 + object:level():objectsKind()
        else
            return RPD.DungeonTilemap:getDecoTileForTerrain(level, object:getPos(), RPD.Terrain.WELL)
        end
    end
}