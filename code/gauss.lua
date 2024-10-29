-- p(x) = 1 / sqrt(2 * pi) * exp(-x^2 / 2)

cnt = {}
maxCnt = 0
N = 10

math.randomseed(os.time())

for _ = 1, 100000 do
    repeat
        x = 2 * N * (math.random() - 0.5)
        v = 1 / math.sqrt(2 * math.pi) * math.exp(-x ^ 2 / 2)
        y = math.random()
    until v > y

    res = math.floor(x)
    cnt[res] = (cnt[res] or 0) + 1
    if cnt[res] > maxCnt then
        maxCnt = cnt[res]
    end
end

for i = -N, N do
    freq = (cnt[i] or 0) / maxCnt
    len = math.ceil(freq * 10)
    io.write(string.format("%03d: ", i))
    for j = 0, len do
        io.write('#')
    end
    io.write('\n')
end
