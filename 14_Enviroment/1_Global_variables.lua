local function getfield (f)
    local v = _G
    for w in string.gmatch(f, "[%w_]+") do
        v = v[w]
    end
    return v
end

a = { b = { c = { d }}}
a.b.c.d = 1
print(getfield("a.b.c.d"))

local function setfield (f, v)
    local t = _G                -- 전역 테이블에서 시작.
    for w, d in string.gmatch(f, "([%w_]+)(%.?)") do
        if d == "." then        -- 마지막 이름이 아닌가?
            t[w] = t[w] or {}   -- 존재하지 않으면 테이블을 만든다.
            t = t[w]            -- 테이블을 얻는다.
        else                    -- 마지막 이름.
            t[w] = v            -- 할당한다.
        end
    end
end

setfield("t.x.y", 10)
print(t.x.y)
print(getfield("t.x.y"))

----

setmetatable(_G, {
    __newindex = function (_, n)
        error("Attempt to wrtie to undeclared variable " .. n, 2)
    end,
    __index = function (_, n)
        error("Attempt to read undeclared variable " .. n, 2)
    end,
})

--print(b)

rawset(_G, "declare", function (name, initval)
    rawset(_G, name, initval or false)
end)

declare("c", 99)

print(rawget(_G, "c"))

----

local declaredNames = {}

setmetatable(_G, {
    __newindex = function (t, n, v)
        if not declaredNames[n] then
            local w = debug.getinfo(2, "S").what
            if w ~= "main" and w ~= "C" then
                error("Attempt to write to undeclared variable " .. n, 2)
            end
            declaredNames[n] = true
        end
        rawset(t, n, v) -- Do the actual set.
    end,

    __index = function (_, n)
        if not declaredNames[n] then
            error("Attempt to read undeclared variable " .. n, 2)
        else
            return nil
        end
    end,
})

main_variable = "!!"
print(main_variable)