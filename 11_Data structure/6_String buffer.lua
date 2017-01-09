local t = {}
for line in io.lines("lorem_ipsum.txt") do
    t[#t + 1] = line
end
t[#t + 1] = "" -- 끝에 구분자를 넣도록 하는 꼼수.
local s = table.concat(t, "\n")

print(s)