a = {}
for i = -5, 5 do
    a[i] = 0
end

print(#a)


N, M = 5, 5
mt = {}
for i = 1, N do
    mt[i] = {}
    for j = 1, M do
        mt[i][j] = 0
    end
end

mt[1][2] = 2

function mult(a, rowindex, k)
    local row = a[rowindex]
    for i, v in pairs(row) do
        row[i] = v * k
    end
end

mult(mt, 1, 2)

for i = 1, N do
    for j = 1, M do
        io.write(mt[i][j], " ")
    end
    io.write("\n")
end

