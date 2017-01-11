print(_ENV, _G)

--[[
a = 15          -- 전역 변수 생성.
_ENV = {g = _G} -- 현재 환경을 변경.
a = 1           -- _ENV 필드 생성.
g.print(a)      --> 1
g.print(g.a)    --> 15
--]]

a = 1
local newgt = {}    -- 새로운 환경 생성.
setmetatable(newgt, {__index = _G})
_ENV = newgt        -- 설정한다.
print(a)            --> 1

a = 10
print(a)        --> 10
print(_G.a)     --> 1
_G.a = 20
print(_G.a)     --> 20

----

_ENV = {_G = _G}
local function foo ()
    _G.print(a)     -- '_ENV._G.print(_ENV.a)'로 컴파일 됨.
end
a = 10      -- _ENV.a
foo()       --> 10
_ENV = {_G = _G, a = 20}
foo()       --> 20

----

a = 2
do
    local _ENV = {print = _G.print, a = 14}
    print(a)    --> 14
end
_G.print(a)     --> 2

----

local function factory (_ENV)
    return function ()
        return a    -- "전역" a
    end
end

f1 = factory{a = 6}
f2 = factory{a = 7}
_G.print(f1())     --> 6
_G.print(f2())     --> 7