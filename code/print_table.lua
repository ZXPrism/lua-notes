local function printTable(tbl)
    for k, v in pairs(tbl) do
        print(type(v), k)
    end
end

io.write("Input table name: ")
printTable(_G[io.read("l")])
