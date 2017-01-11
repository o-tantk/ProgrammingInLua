Account = { balance = 0 }

function Account:deposit (v)
    self.balance = self.balance + v
end

function Account:withdraw (v)
    if v > self.balance then error "Insufficient funds" end
    self.balance = self.balance - v
end

function Account:new (o)
    o = o or {} -- 사용자가 테이블을 전달하지 않았다면 하나 만든다.
    setmetatable(o, self)
    self.__index = self
    return o
end

a = Account:new{balance = 0}
a:deposit(100.00) -- getmetatable(a).__index.deposit(a, 100.00)
print(a.balance)
a:withdraw(50.00) -- getmetatable(a).__index.withdraw(a, 50.00)
print(a.balance)
a.balance = 0
print(a.balance)

SpecialAccount = Account:new()
s = SpecialAccount:new { limit = 1000.00 } -- limit은 마이너스 통장 한계.
s:deposit(100.00) -- getmetatable(s).__index.__index.deposit(a, 100.00)
print(s.balance)

function SpecialAccount:getLimit ()
    return self.limit or 0
end

function SpecialAccount:withdraw (v)
    if v - self.balance >= self:getLimit() then
        error "Insufficient funds"
    end
    self.balance = self.balance - v
end

s:withdraw(1000.00) -- getmetatable(s).__index.withdraw(50.00)
print(s.balance)

-- s의 마이너스 한계만 수정.
function s:getLimit ()
    return self.balance * 0.10
end

s:deposit(1000.00)
print(s.balance)
s:withdraw(110.00)