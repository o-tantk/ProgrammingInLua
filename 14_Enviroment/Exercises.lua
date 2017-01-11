-- Exercise 14.2
--[[
local foo
do
    local _ENV = _ENV
    function foo () print(X) end
end
X = 13
_ENV = nil  -- local _ENV에 참조되어 있기 때문에 컴파일 에러.
foo()       --> 13
X = 0
--]]

----

-- Exercise 14.3
local print = print
function foo (_ENV, a)
    print(a + b)
end
foo({b = 14}, 12)   --> 26
foo({b = 10}, 1)    --> 11