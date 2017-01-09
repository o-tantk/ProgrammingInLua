local N = 8

local function isplaceok (a, n, c)
    for i = 1, n - 1 do
        if (a[i] == c)
            or (a[i] - i == c - n)
            or (a[i] + i == c + n)
        then
            return false
        end
    end
    return true
end

local function printsolution (a)
    for i = 1, N do
        for j = 1, N do
            io.write(a[i] == j and "X" or "-", " ")
        end
        io.write("\n")
    end
    io.write("\n")
end

local function permgen (a, n)
    n = n or #a
    if n <= 1 then
        coroutine.yield(a)
    else
        for i = 1, n do
            a[n], a[i] = a[i], a[n]
            permgen(a, n - 1)
            a[n], a[i] = a[i], a[n]
        end
    end
end

local function permutations (a)
    local co = coroutine.create(function () permgen(a) end)
    return function ()
        local code, res = coroutine.resume(co)
        return res
    end
end

for p in permutations {1, 2, 3, 4, 5, 6, 7, 8} do
    local isok = true
    for i = 1, N do
        if not isplaceok(p, i, p[i]) then
            isok = false
            break
        end
    end
    if isok then
        printsolution(p)
        break
    end
end
