local results = {}
setmetatable(results, {__mode = "v"}) -- 값을 약한 참조로 만든다.

function mem_loadstring (s)
    local res = results[s]
    if res == nil then          -- 결과가 있다면
        res = assert(load(s))   -- 새로운 결과를 만들고,
        results[s] = res        -- 다음에 재사용할 수 있도록 저장.
    end
    return res
end

function createRGB (r, g, b)
    local key = r .. "-" .. g .. "-" .. b
    local color = results[key]
    if color == nil then
        color = {red = r, blue = b, green = g}
        results[key] = color
    end
    return color
end