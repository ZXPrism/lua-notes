# 6 - 函数

## 概览
```lua
function incCount(n, useless)
    counter = (counter or 0) + (n or 1)
end
```

## 函数调用

### 参数过多
如果传递的参数多于定义时的参数个数，则多余的参数会被丢弃（一般不会遇到这种情况）

### 参数过少

如果传递的函数少于定义时的参数个数，则不足的参数被设为 `nil`
  - 可以基于这一机制实现默认参数或**函数重载的效果**（但 Lua 本身不支持重载）


## 多返回值
Lua 函数支持返回多个值

### 多重赋值
- 如果一个函数调用是一系列表达式中最后或是唯一的表达式，则它会产生尽可能多的返回值，如：

    ```lua
    -- foo() return 2, 3, 4
    x, y, z = 1, foo() -- x, y, z = 1, 2, 3
    ```

- 否则，只使用第一个返回值：

    ```lua
    x, y, z = foo(), 1 -- x, y, z = 2, 1, nil
    ```

在将一个函数的返回值作为调用另外一个函数的参数时同理（本质上也是多重赋值）。

### 注意
- 如果给函数调用加括号，则强制使用第一个返回值，如 `(foo())`


## 可变参数
- 使用 `...` 来声明可变参数，它可以接收任意多的参数
- `...` 的行为类似一个具有多返回值的函数，而**不是表**
  - 这就是为什么使用 `print(...)` 会直接输出可变参数，而非 `table: xxx`
- 只有通过 `{...}` 才能得到表

### 可变参数的遍历
- 使用 `ipairs`：

    ```lua
    function v1(...)
        for _, arg in ipairs({ ... }) do
            print(arg)
        end
    end
    ```

这一方法要求先使用 `{}` 建表，并且 `...` 中不能含有 `nil`，否则可能会出现前面提到的截断问题（参见 [5 - 表 / 数组与空洞](./ch5.md)）

- 使用 `select(i, ...)`（返回第 i 个元素以及之后所有的元素）：

    ```lua
    function v2(...)
        for i = 1, select("#", ...) do
            print((select(i, ...)))
        end
        print()
    end
    ```

这一方法不需要建立额外的表，而且不会遇到截断问题

## 解包（`table.unpack`）
- `table.unpack` 函数将一个列表转换为多个返回值
- 利用它，我们可以**动态**地实现函数调用以及多返回值，如：

    ```lua
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
    ```


输出：

```
2       3       4
5       6       7
```
