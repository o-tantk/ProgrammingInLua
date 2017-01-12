o = {x = "hi"}
setmetatable(o, {__gc = function (o) print(o.x) end})
o = nil
collectgarbage() --> hi

----

o = {x = "hi"}
mt = {}
setmetatable(o, mt)
mt.__gc = function (o) print(o.x) end
o = nil
collectgarbage() --> 아무것도 출력되지 않는다. 왜?
-- 책에서는 마무리 대상이 되지 않았기 때문이라는데 구체적으로 언제 마무리 대상이 되는지 설명해 놓지 않아 이유를 알 수 없다.
-- 다만, 문맥을 보아 setmetatable을 호출할 때 __gc 필드가 존재해야 마무리 대상이 되는 듯 하다.

----

mt = {__gc = function(o) print(o[1]) end}
list = nil
for i = 1, 3 do
    list = setmetatable({i, link = list}, mt)
end
list = nil
collectgarbage()
--> 3
--> 2
--> 1

----

A = {x = "This is A"}
B = {f = A}
setmetatable(B, {__gc = function (o) print(o.f.x) end})
A, B = nil
collectgarbage()    --> This is A

----

do
    local mt = {__gc = function (o)
        -- 원하는 동작을 처리하고,
        print("New cycle")
        -- 다음 가비지 컬렉션이 완료되면 호출되도록 새 객체를 만든다.
        setmetatable({}, getmetatable(o))
    end}
    -- 첫 객체를 만든다.
    setmetatable({}, mt)
end
collectgarbage() --> New cycle
collectgarbage() --> New cycle
collectgarbage() --> New cycle

----

wk = setmetatable({}, {__mode = "k"})
wv = setmetatable({}, {__mode = "v"})
o = {}
wv[1] = o;  wk[o] = 10
setmetatable(o, {__gc = function (o)
    print(wk[o], wv[1])
end})
o = nil;
collectgarbage() --> 10 nil