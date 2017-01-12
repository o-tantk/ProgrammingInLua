do
    local mem = {}
    setmetatable(mem, {__mode = "k"})
    function factory (o)
        local res = mem[o]
        if not res then
            res = function () return o end  -- 익명 함수 내에서 참조하게 되므로,
            mem[o] = res                    -- 결국 키값에 대해 약한 참조가 아니다.
        end
        return res
    end
end

-- 루아 5.2부터, 약한 참조 키와 강한 참조 값을 가지는 테이블은 Ephemeron table이다.
-- Ephemeron table에선, 키에 대한 접근성이 대응하는 값에 대한 접근성을 제어한다.
-- v가 직접적이든 간접적이든 k를 참조하더라도 결과적으로 테이블에서 제거된다.