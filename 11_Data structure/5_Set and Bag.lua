function Set (list)
    local set = {}
    for _, l in ipairs(list) do
        set[l] = true
    end
    return set
end

reserved = Set {"while", "end", "function", "local", }



Bag = {}

function Bag.insert (bag, element)
    bag[element] = (bag[element] or 0) + 1
end

function Bag.remove (bag, element)
    local count = bag[element]
    bag[element] = (count and count > 1) and count - 1 or nil
end

function Bag.print_all (bag)
    for value, count in pairs(bag) do
        print(value .. " - " .. count)
    end
    print()
end

mybag = {}
Bag.insert(mybag, "Hello")
Bag.insert(mybag, "Hello")
Bag.insert(mybag, "World")
Bag.print_all(mybag)
Bag.remove(mybag, "Hello")
Bag.print_all(mybag)
