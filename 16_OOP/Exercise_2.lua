require "16_OOP\\Exercise_1"

-- 저자가 원한 것은 16.2의 방법을 이용해서 Stack을 상속하고 필드를 공유해서 Queue를 만들라는 의미였겠지만,
-- 이미 Stack을 함수로 구현해서 은닉했으니 StackQueue는 대충 상속 모양만 나오게 구현했다. 그래서 bottom에 값이 있어도 empty는 true를 반환하는 문제가 있다.

function StackQueue ()
    local self = {}

    local insertBottom = function (value)
        self[#self + 1] = value
    end

    local class = { insertBottom = insertBottom }
    setmetatable(class, { __index = Stack() })
    return class
end

local sq = StackQueue()
sq.insertBottom(3)
print(sq.empty())   --> empty...???