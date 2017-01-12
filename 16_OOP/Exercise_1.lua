function Stack ()
    local self = {}

    local empty = function ()
        return not self[#self]
    end

    local push = function (value)
        self[#self + 1] = value
    end

    local pop = function ()
        if empty() then
            error("Stack is empty")
        end

        local v = self[#self]
        self[#self] = nil
        return v
    end

    local top = function ()
        return self[#self]
    end

    return { push = push, pop = pop, top = top, empty = empty }
end

local s = Stack()
--s.pop()
s.push(1)
print(s.pop())      --> 1
print(s.empty())    --> true
s.push(2)
print(s.top())      --> 2
print(s.pop())      --> 2