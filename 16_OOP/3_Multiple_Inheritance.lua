require "16_OOP\\1_Class"

-- 테이블의 목록 'plist'에서 'k'를 찾는다.
local function search (k, plist)
    for i = 1, #plist do
        local v = plist[i][k] -- 'i'번째 부모 클래스에서 찾는다.
        if v then return v end
    end
end

function createClass ( ... )
    local c = {}    -- 새로운 클래스.
    local parents = { ... }

    -- 메서드를 부모의 목록에서 찾는다.
    setmetatable(c, {__index = function(t, k)
        local v = search(k, parents)
        t[k] = v    -- 다음을 위해 저장해 둠.
        return v
    end})

    -- 'c' 스스로 메타테이블이 되도록 설정.
    c.__index = c

    -- 이 새로운 클래스의 생성자 정의.
    function c:new (o)
        o = o or {}
        setmetatable(o, c)
        return o
    end

    return c    -- 새로운 클래스 반환.
end

Named = {}
function Named:getname ()
    return self.name
end

function Named:setname ()
    self.name = n
end

NamedAccount = createClass(Account, Named)

account = NamedAccount:new{name = "Paul"}
print(account:getname())    --> Paul

----

function newAccount (initialBalance)
    local self = {
        balance = initialBalance,
        LIM = 10000.00,
    }

    local extra = function ()
        if self.balance > self.LIM then
            return self.balance * 0.10
        else
            return 0
        end
    end

    local withdraw = function (v)
        self.balance = self.balance - v
    end

    local deposit = function (v)
        self.balance = self.balance + v
    end

    local getBalance = function ()
        return self.balance + extra()
    end

    return {
        withdraw = withdraw,
        deposit = deposit,
        getBalance = getBalance
    }
end

acc1 = newAccount(100.00)
acc1.withdraw(40.00)
print(acc1.getBalance())    --> 60.00
print(acc1.balance)         --> nil

----

function newObject (value)
    return function (action, v)
        if action == "get" then
            return value
        elseif action == "set" then
            value = v
        else
            error("Invalid action")
        end
    end
end

d = newObject(0)
print(d("get")) --> 0
d("set", 10)
print(d("get")) --> 10