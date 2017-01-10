local reserved = {
    ["while"] = true, ["end"] = true, ["function"] = true, ["for"] = true, ["local"] = true,
}

local function serialize (o, ntab)
    ntab = ntab or 0
    if type(o) == "number" then
        io.write(o)
    elseif type(o) == "string" then
        io.write(string.format("%q", o))
    elseif type(o) == "table" then
        local function insert_tab ()
            for i = 1, ntab do
                io.write("\t")
            end
        end

        io.write("{\n")

        insert_tab(); io.write("\t")
        local sequence_check = {}
        for i, v in ipairs(o) do
            sequence_check[v] = true

            serialize(v, ntab + 1); io.write(", ")
        end
        io.write("\n")

        for k, v in pairs(o) do
            if not sequence_check[v] then
                if reserved[k] then
                    insert_tab(); io.write("\t["); serialize(k); io.write("] = ")
                else
                    insert_tab(); io.write("\t", k, " = ")
                end
                serialize(v, ntab + 1)
                io.write(",\n")
            end
        end
        insert_tab(); io.write("}")
    else
        error("Cannot serialize a " .. type(o))
    end
end

local temp = {'a', 'b', 'c'}
local temp2 = {1, 2, 3, temp}
serialize {5, 6, 7, a=12, b='Lua', key='another "one"', ["local"] = temp2}
print()

----

local function quote (s)
    -- 연속된 등호의 최대 길이를 찾는다.
    local n = -1
    for w in string.gmatch(s, "]=*]") do
        n = math.max(n, #w - 2) -- ']'를 제외한 등호의 수만 세기 위해 -2.
    end

    -- 등호가 n보다 1개 더 많도록 문자열을 생성
    local eq = string.rep("=", n + 1)

    -- 따옴표로 감싼 문자열 만들기
    return string.format(" [%s[\n%s]%s] ", eq, s, eq)
end

----

local function basicSerialize (o)
    if type(o) == "number" then
        return tostring(o)
    else -- 문자열이라고 가정.
        return string.format("%q", o)
    end
end

local function save(name, value, saved)
    saved = saved or {}                     -- 초기값.
    io.write(name, " = ")
    if type(value) == "number" or type(value) == "string" then
        io.write(basicSerialize(value), "\n")
    elseif type(value) == "table" then
        if saved[value] then                -- 값이 이미 저장되었는가?
            io.write(saved[value], "\n")    -- 기존 이름을 사용한다.
        else
            saved[value] = name             -- 다음을 위해 이름을 저장.
            io.write("{}\n")                -- 새로운 테이블 생성.
            for k, v in pairs(value) do     -- 테이블의 필드 저장.
                k = basicSerialize(k)
                local fname = string.format("%s[%s]", name, k)
                save(fname, v, saved)
            end
        end
    else
        error("Cannot save a " .. type(value))
    end
end

a = {x=1, y=2; {3, 4, 5}}
a[2] = a        -- 순환 구조
a.z = a[1]      -- 공유되는 하위 테이블

save("a", a)