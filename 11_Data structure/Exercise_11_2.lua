local function read_reserved (reserved)
    for word in io.lines("reserved.txt") do
        reserved[word] = true
    end
end

local function allwords ()
    local auxwords = function ()
        for line in io.lines("../lorem_ipsum.txt") do
            for word in string.gmatch(line, "%w+") do
                coroutine.yield(word)
            end
        end
    end
    return coroutine.wrap(auxwords)
end

local reserved = {}
read_reserved(reserved)

local counter = {}
for w in allwords() do
    if not reserved[w] then 
        counter[w] = (counter[w] or 0) + 1
    end
end

local words = {}
for w in pairs(counter) do
    words[#words + 1] = w
end

table.sort(words, function (w1 ,w2)
    return counter[w1] > counter[w2] or
            counter[w1] == counter[w2] and w1 < w2
end)

print("Print word frequency:")
for i = 1, (tonumber(arg[1]) or 20) do
    print(words[i] .. " - " .. counter[words[i]])
end
