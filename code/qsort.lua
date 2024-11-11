local function gen_array(n)
    res = {}
    for i = 1, n do
        res[i] = math.random(1, 1000)
    end
    return res
end

local function print_array(arr)
    for _, ele in ipairs(arr) do
        io.write(ele, " ")
    end
    print()
end

local function check(arr)
    local n = #arr
    for i = 2, n do
        if arr[i - 1] > arr[i] then
            return false
        end
    end
    return true
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

print(check({ 1, 2, 3, 4, 5 }))
print(check({ 1, 2, 3, 5, 4 }))

local arr = gen_array(100)

print_array(arr)
print(check(arr))

qsort(arr, 1, #arr)

print_array(arr)
print(check(arr))
