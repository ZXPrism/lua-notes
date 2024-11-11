# 5 - 表

## 概览

表是 Lua 中唯一的内置数据结构，它的行为类似哈希表，但其特殊之处在于 key 和 value 的类型都可以是任意的。

例：

```lua
a = {}
a[1] = 123
a["x"] = 456
```

-类似 Python，程序只能操纵表的引用（指向表的指针），表本身和保存该表的变量没有固定的关系。当一个表没有任何变量引用时，它会被 GC 回收。

和 Python 的不同之处在于，其他的基本类型（如 `number`）等是按值传递的。

Lua 中许多的基础设施是以表的形式提供的，如全局变量被存放在名为 `_G` 的表中，`os`、`string` 等标准库所提供的函数实际上存放在同名的表中。


## 表的基本操作
### 建表
- `a = {}` 可以创建一个空白的表，其中变量 `a` 存储了新创建的表的引用
- `a = nil` 将删除这个表，因为此时没有任何变量引用该表

### 添加/修改元素
- `a[KEY] = VALUE `
  - 搭配 or 运算符，如：`a[KEY] = (a[KEY] or 0) + 1`
- `a.KEY = VALUE`：等价于 `a["KEY"] = VALUE`
  - 这里 `KEY` 不能是数字
  - 如 `a.xyz = 123` 等价于 `a["xyz"] = 123`
  - 一般只有在把表当作结构体使用时，才会采取这种简写法

## 表构造器（Table Constructor）
表构造器提供了更加灵活的建表方式。

### List-Style 写法
`days = {"Sunday", "Monday", "...", ...}`

等价于：

```lua
days = {}
days[1] = "Sunday"
days[2] = "Monday"
days[3] = "..."
...
```

**注意**：下标从 `1` 开始


### Record-Style 写法
`a = {x = 10, y = 20}`

等价于：

```lua
a = {}
a.x = 10
a.y = 20
```

### 混合写法
```lua
polyline = { color = "blue",
             thickness = 2,
             {x = 0, y = 0},
             {x = -10, y = 0},
            }
```

### 通用写法
```lua
opnames = {["+"] = "add", ["-"] = "sub"}
```


## 数组与空洞（hole）
### 数组
- 数组是基于表实现的。按照惯例，数组的下标应从 1 开始
- 使用长度操作符 `#` 通常可以获得数组的元素个数
  - 使用 `a[#a] = nil` 来删除最后一个元素
  - 使用 `a[#a + 1] = xxx` 在末尾添加一个元素

### 空洞
- 给数组中的某个元素赋值 `nil` 会产生**空洞**，此时长度操作符的结果可能会不正确，如：

    ```lua
    a = {1, 2, 3, 4}
    a[2] = nil
    print(#a) -- 输出 4，但实际应为 3
    ```

- 不存在空洞的数组称为序列（sequence）



## 表的遍历
### `pairs`
使用 `pairs` 函数来遍历表中**所有**的键值对，如：

```lua
a = { 1, xx = 123, 2, 3, k = "xyz" }
for k, v in pairs(a) do
    print(k, v)
end
```

输出：

```
1       1
2       2
3       3
k       xyz
xx      123
```

不保证输出元素的顺序在多次运行时一致。

### `ipairs`
- 使用 `ipairs` 函数来按顺序遍历表
- 如果表中包含多种类型的键，只会按顺序遍历键为整数的部分（数组部分）
- 如果数组部分存在空洞，则遍历可能会被截断，如:

    ```lua
    a = { 1, xx = 123, 2, 3, k = "xyz" }
    a[1] = nil
    for k, v in ipairs(a) do
        print(k, v)
    end
    ```

    将不会产生任何输出，因为空洞位于数组的开头。


## 表标准库
- `table.insert` 在**序列**的指定位置插入一个新元素，其它元素后移
  - 不指定位置，则插入到序列的末尾
- `table.remove` 删除**序列**指定位置元素，并将后面的元素前移以填补空洞
  - 不指定位置，则删除序列末尾的元素
- `table.move(a, f, e, t)` 将**序列**中从位置 `f` 到 `e` 的元素移动到位置 `t` 上
- `table.concat(a)` 将**序列**中的元素依次连接在一起，返回构成的字符串