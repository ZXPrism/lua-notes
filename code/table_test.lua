sunday = "monday"; monday = "sunday"
t = { sunday = "monday", [sunday] = monday }
print(t.sunday, t[sunday], t[t.sunday])

--[[ analysis
t = {}
t["subday"] = "monday"
t["monday"] = "sunday"
t.sunday --> "monday"
t[sunday] --> t["monday"] --> "sunday"
t[t.subday] --> t["monday"] --> "sunday"
result: monday sunday sunday
]]
