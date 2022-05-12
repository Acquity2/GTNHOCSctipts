local component = require("component")
local sides = require("sides")
local string = require("string")
local serialization = require("serialization")

Somefunctions = {}
Recipe = {item = {}, fluid = {}, output = ""}
ItemList = {}
RecipeList = {recipe = {}, n = 0}

----------------------------------------------------------------------------------------------------------------------------------------------
function Recipe:new(o, item, fluid, output)   --合成表对象
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.item = item or {}
    o.fluid = fluid or {}
    o.output = output or "";
    return o
end

function Recipe:Item()
    return(serialization.serialize(self.item))
end

function Recipe:Fluid()
    return(serialization.serialize(self.fluid))
end

function Recipe:Output()
    return(self.output)
end

ItemList = Recipe:new()

function ItemList:new(o, allStacksTbl)   --输入箱子内物品列表对象
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    for k,v in pairs(allStacksTbl) do
        if v.label then
            o.item[k + 1] = {v.label,v.size,n = 2}
            o.item.n = k + 1
        end
    end
    return o
end

function RecipeList:flash(o, allStacksTbl)   --合成表表
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    for k,v in pairs(allStacksTbl) do
        if v.label then
            o[k + 1] = Recipe:new(nil, v.inputItems, v.inputFluids, v.output)
            self.n = self.n + 1
        end
    end
    return o
end

function RecipeList:Num()
    return self.n
end

----------------------------------------------------------------------------------------------------------------------------------------------
function getInputItemList(_side)
    return ItemList:new(nil,component.transposer.getAllStacks(_side).getAll())
end

----------------------------------------------------------------------------------------------------------------------------------------------
