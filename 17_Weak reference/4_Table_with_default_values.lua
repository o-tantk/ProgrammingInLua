local defaults = {}
setmetatable(defaults, {__mode = "k"})
local mt = {__index = function (t) return defaults[t] end}
local function setDefault (t, d)
    defaults[t] = d
    setmetatable(t, mt)
end

----

local metas = {}
setmetatable(metas, {__mode = "v"})
local function setDefault (t, d)
    local mt = metas[d]
    if mt == nil then
        mt = {__index = function () return d end}
        metas[d] = mt   -- 기억해두기.
    end
    setmetatable(t, mt)
end

local a = {}
setDefault(a, 0)
print(a.x)