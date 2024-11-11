function v1(...)
    for _, arg in ipairs({ ... }) do
        print(arg)
    end
    print()
end

function v2(...)
    for i = 1, select("#", ...) do
        print((select(i, ...)))
    end
    print()
end

function PlusOne(...)
    lst = { ... }
    for k, v in ipairs(lst) do
        lst[k] = v + 1
    end
    return table.unpack(lst)
end

v1(1, 2, nil, 3)
v2(1, 2, nil, 3)
print(PlusOne(1, 2, 3))
print(PlusOne(table.unpack({ 4, 5, 6 })))
