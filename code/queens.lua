N = 8

perm = {}
vis = {}
cnt = 0

function print_solution()
    for r = 1, N do
        for c = 1, N do
            io.write(perm[r] == c and 'X' or '-', c == N and '\n' or ' ')
        end
    end
    io.write('\n')
end

function dfs(k)
    if k == N + 1 then
        -- check if current permutation is a valid solution
        main, sub = {}, {}
        check = true

        for i = 1, N do
            mainIdx = 5 - perm[i] + i
            subIdx = perm[i] + i
            if main[mainIdx] or sub[subIdx] then
                check = false
                break
            end
            main[mainIdx] = true
            sub[subIdx] = true
        end

        if check then
            print_solution()
            cnt = cnt + 1
        end
    end

    for i = 1, N do
        if not vis[i] then
            vis[i] = true
            perm[k] = i
            dfs(k + 1)
            vis[i] = false
        end
    end
end

dfs(1)

print(string.format("--> %d different solutions in total", cnt))
