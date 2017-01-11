-- 기본값을 가진 프로토타입을 생성한다.
local prototype = {x = 0, y = 0, width = 100, height = 100}
local mt = {}

-- 생성자 함수를 선언한다.
local function new (o)
    setmetatable(o, mt)
    return o
end

--[[
mt.__index = function (_, key)
    return prototype[key]
end
--]]
mt.__index = prototype

w = new{x = 10, y = 20}
print(w.width) --> 100

----

--[[
local mt = {__index = function (t) return t.___ end}
function setDefault (t, d)
    t.___ = d
    setmetatable(t, mt)
end
--]]
local key = {} -- 고유 키. (테이블 번호를 키로 사용하는 것)
local mt = {__index = function (t) return t[key] end}
function setDefault (t, d)
    t[key] = d
    setmetatable(t, mt)
end

tab = {x=10, y=20}
print(tab.x, tab.z)
setDefault(tab, 0)
print(tab.x, tab.z)

----

local t = {} -- 어딘가에서 생성된 원본 테이블.
local _t = t -- 원본 테이블을 직접 접근하지 않기 위해 보관한다.
local t = {} -- 프록시를 생성한다.

-- 메타테이블을 생성한다.
local mtable = {
    __index = function (t, k)
        print("*access to element " .. tostring(k))
        return _t[k] -- 원본 테이블에 접근.
    end,

    __newindex = function (t, k, v)
        print("*update of element " .. tostring(k) .. " to " .. tostring(v))
        _t[k] = v -- 원본 테이블 갱신.
    end,

    __pairs = function ()
        return next, _t, nil
    end
}
setmetatable(t, mtable)

t[1] = "world"
t[2] = "hello"
for _, v in pairs(t) do
    print(_, v)
end

----

local index_original = {}           -- 내부에서 사용할 인덱스 생성.
local mt = {                        -- 메타테이블 생성.
    __index = function(t, k)
        print("*Access to element " .. tostring(k))
        return t[index_original][k] -- 원본 테이블에 접근.
    end,

    __newindex = function(t, k, v)
        print("*Update of element " .. tostring(k) .. " to " .. tostring(v))
        t[index_original][k] = v             -- 원본 테이블 갱신.
    end,

    __pairs = function(t)
        return function(t, k)
            return next(t[index_original], k)
        end, t
    end
}

local function track (t)
    local proxy = {}
    proxy[index_original] = t
    setmetatable(proxy, mt)
    return proxy
end

local t = {}
t = track(t)
t[1] = "My"
t[2] = "Song"
for _, v in pairs(t) do
    print(v)
end

local readOnly_mt = {}
readOnly_mt.__index = function (t, k)
    return t[k]
end
readOnly_mt.__newindex = function (t, k, v)
    error("Attempt to update a read-only table", 2)
end

local function readOnly (t)
    local proxy = {}
    --[[
    local mt = {
        __index = t,
        __newindex = function (t, k, v)
            error("Attempt to update a read-only table", 2)
        end
    }
    setmetatable(proxy, mt)
    --]]
    setmetatable(proxy, readOnly_mt)
    return proxy
end

local t = {1, 2}
t = readOnly(t)
t[1] = 3