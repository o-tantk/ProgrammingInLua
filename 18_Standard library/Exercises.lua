local function isPowerOfTwo (n)
    local pow = (math.log(n) / math.log(2.0))
    return (pow - math.ceil(pow)) == 0
end

print(isPowerOfTwo(2.0))
print(isPowerOfTwo(4.0))
print(isPowerOfTwo(256.0))
print(isPowerOfTwo(3.0))