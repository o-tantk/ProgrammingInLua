Set = {}
local mt = {}
mt.__metatable = "This is metatable for Set."

-- 지정된 리스트의 값을 이용해서 새로운 집합을 생성.
function Set.new (l)
    local set = {}
    setmetatable(set, mt)
    for _, v in ipairs(l) do
        set[v] = true
    end
    return set
end

function Set.union (a, b)
    if getmetatable(a) ~= getmetatable(b) then
        error("Attempt to 'add' a set with a not-set value.", 2)
    end
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = true
    end
    for k in pairs(b) do
        res[k] = true
    end
    return res
end
mt.__add = Set.union

function Set.intersection (a, b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end
mt.__mul = Set.intersection

function Set.subtract (a, b)
    local res = Set.new{}
    for k in pairs(a) do
        if not b[k] then
            res[k] = true
        end
    end
    return res
end
mt.__sub = Set.subtract

function Set.length(s)
    local count = 0;
    for k in pairs(s) do
        count = count + 1
    end
    return count
end
mt.__len = Set.length

-- 집합의 포함 관계.
mt.__le = function (a, b)
    for k in pairs(a) do
        if not b[k] then return false end
    end
    return true
end

mt.__lt = function (a, b)
    return a <= b and not (b <= a)
end

mt.__eq = function (a, b)
    return a <= b and b <= a
end

-- 집합을 문자열로 표현.
function Set.tostring (set)
    local l = {}    -- 집합의 모든 원소를 담아 둘 리스트.
    for e in pairs(set) do
        l[#l + 1] = e
    end
    return "{" .. table.concat(l, ", ") .. "}"
end
mt.__tostring = Set.tostring

-- 집합을 출력한다.
function Set.print (s)
    print(Set.tostring(s))
end

local s1 = Set.new{10, 20, 30, 50}
local s2 = Set.new{30, 1}
print(getmetatable(s1))
print(getmetatable(s2))

local s3 = s1 + s2
print(getmetatable(s3))
Set.print(s3)

local s4 = s3 * s1
Set.print(s4)

Set.print(s1 - s2)
print(#s1)

-- Error!
--s1 = s1 + 8

s5 = Set.new{2, 4}
s6 = Set.new{4, 10, 2}
print(s5 <= s6)         -- true
print(s5 < s6)          -- true
print(s5 >= s5)         -- true
print(s5 > s5)          -- false
print(s5 == s6 * s5)    -- true