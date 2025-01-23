-- on 2025-01-23
-- use `lua geometry.lua > output.pbm` to save the image

local function disk(cx, cy, radius)
    return function(x, y)
        return (x - cx) ^ 2 + (y - cy) ^ 2 <= radius ^ 2
    end
end

local function complement(r)
    return function(x, y)
        return not r(x, y)
    end
end

local function union(r1, r2)
    return function(x, y)
        return r1(x, y) or r2(x, y)
    end
end

local function intersection(r1, r2)
    return function(x, y)
        return r1(x, y) and r2(x, y)
    end
end

local function diff(r1, r2)
    return function(x, y)
        return r1(x, y) and not r2(x, y)
    end
end

local function translate(r, dx, dy)
    return function(x, y)
        return r(x - dx, y - dy)
    end
end

local function plot(r, width, height)
    io.write("P1\n", width, " ", height, "\n")

    for i = 0, height - 1 do
        local y = (2 * i - height) / height
        for j = 0, width - 1 do
            local x = (j * 2 - width) / width
            io.write(r(x, y) and "1" or "0")
        end
        io.write("\n")
    end
end

local d = disk(0, 0, 1)
plot(diff(d, translate(d, 0.3, -0.2)), 500, 500)
