list = {next = nil, value = "Hello"}

local function print_list (list)
    local iterator = list
    while iterator do
        print(iterator.value)
        print(iterator.next)
        iterator = iterator.next
    end
end

print_list(list)

List = {}

function List.new ()
    return {first = 0, last = -1}
end

function List.pushfirst (list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end

function List.pushlast (list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

function List.popfirst (list)
    local first = list.first
    if first > list.last then error("list is empty") end
    local value = list[first]
    list[first] = nil -- For being GCed
    list.first = first + 1
    return value
end

function List.poplast (list)
    local last = list.last
    if first > list.last then error("list is empty") end
    local value = list[last]
    list[last] = nil -- for being GCed
    list.last = last - 1
    return value
end


mylist = List.new()
for i = 1, 10 do
    List.pushlast(mylist, i)
end

for i = 1, 10 do
    print(List.popfirst(mylist, i))
end
