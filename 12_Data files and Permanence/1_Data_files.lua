local count = 0
function Entry ()
    count = count + 1
end
dofile("12_Data files and Permanence\\data")
print("number of entries: " .. count)

----

local authors = {}
function Entry (b)
    if b.author then
        authors[b.author] = true
    end
end
dofile("12_Data files and Permanence\\data")
for name in pairs(authors) do
    print(name)
end