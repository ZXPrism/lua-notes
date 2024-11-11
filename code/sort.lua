local function gen_array(n)
    res = {}
    for i = 1, n do
        res[i] = math.random(1, 1000)
    end
    return res
end

local function print_array(arr)
    io.write("[ ")
    for _, ele in ipairs(arr) do
        io.write(ele, " ")
    end
    io.write("]\n")
end

local function check(arr)
    local n = #arr
    for i = 2, n do
        if arr[i - 1] > arr[i] then
            print("\x1b[31mCheck: Array isn't sorted\x1b[0m")
            return
        end
    end
    print("\x1b[32mCheck: Array is sorted\x1b[0m")
end

local function partition(arr, l, r)
    local pivot = arr[math.random(l, r)]
    local i, j, k = l, l, r + 1
    while i < k do
        if arr[i] < pivot then
            arr[i], arr[j] = arr[j], arr[i]
            i = i + 1
            j = j + 1
        elseif arr[i] > pivot then
            k = k - 1
            arr[i], arr[k] = arr[k], arr[i]
        else
            i = i + 1
        end
    end
    return j - 1, k
end

local function qsort(arr, l, r)
    if l < r then
        local L, R = partition(arr, l, r)
        qsort(arr, l, L)
        qsort(arr, R, r)
    end
end

local function test_sort(sort_func)
    local arr = gen_array(20)

    io.write("Array to be sorted: ")
    print_array(arr)
    check(arr)

    sort_func(arr, 1, #arr)

    io.write("Array to be sorted: ")
    print_array(arr)
    check(arr)

    io.write('\n')
end

local function shell_sort(arr, l, r)
    local n = r - l + 1
    local d = n // 2
    while d >= 1 do
        for i = l + d, r do
            local tmp, j = arr[i], i - d
            while j >= l and arr[j] > tmp do
                arr[j + d] = arr[j]
                j          = j - d
            end
            arr[j + d] = tmp
        end
        d = d >> 1
    end
end

local function sift_down(arr, l, r)
    local cur = l
    local child = l << 1

    while child <= r do -- ! current node is a leaf !
        if child + 1 <= r and arr[child + 1] > arr[child] then
            child = child + 1
        end

        if arr[child] <= arr[cur] then
            return
        end

        arr[child], arr[cur] = arr[cur], arr[child]
        cur = child
        child = cur << 1
    end
end

local function heapsort(arr)
    local n = #arr
    for i = n // 2, 1, -1 do
        sift_down(arr, i, n)
    end
    for i = n, 2, -1 do
        arr[i], arr[1] = arr[1], arr[i]
        sift_down(arr, 1, i - 1)
    end
end

local function merge(arr, l, r)
    local tmp = {}
    local m = (l + r) >> 1
    local i, j, k = l, m + 1, l
    while i <= m and j <= r do
        if arr[i] < arr[j] then
            tmp[k] = arr[i]
            i = i + 1
        else
            tmp[k] = arr[j]
            j = j + 1
        end
        k = k + 1
    end
    while i <= m do
        tmp[k] = arr[i]
        i = i + 1
        k = k + 1
    end
    while j <= r do
        tmp[k] = arr[j]
        j = j + 1
        k = k + 1
    end
    for i = l, r do
        arr[i] = tmp[i]
    end
end

local function mergesort(arr, l, r)
    if l < r then
        local m = (l + r) >> 1
        mergesort(arr, l, m)
        mergesort(arr, m + 1, r)
        merge(arr, l, r)
    end
end


local function bubblesort(arr, l, r)
    for i = l, r do
        local flag = true
        for j = r, i + 1, -1 do
            if arr[j] < arr[j - 1] then
                arr[j], arr[j - 1] = arr[j - 1], arr[j]
                flag = false
            end
        end
        if flag then
            return
        end
    end
end

local function selection_sort(arr, l, r)
    for i = l, r do
        local mini = i
        for j = i + 1, r do
            if arr[j] < arr[mini] then
                mini = j
            end
        end
        arr[i], arr[mini] = arr[mini], arr[i]
    end
end


test_sort(qsort)
test_sort(shell_sort)
test_sort(heapsort)
test_sort(mergesort)
test_sort(bubblesort)
test_sort(selection_sort)
