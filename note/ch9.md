# 9 - 闭包
- 在 Lua 中，函数是第一类值（对象），即，它和一般的 `number` `string` 等值具有同等地位。比如：
  - 函数可以被保存在表中
  - 函数可以作为另一个函数的返回值返回
  - 一个函数可以作为参数传递给其他函数。
- Lua 的所有函数本质上都是**匿名函数**。

    ```lua
    function foo() end
    ```

    实际上是 

    ```lua
    foo = function() end
    ```

    的简写形式。

## 函数式编程示例一：导数
```lua
function derivative(f, delta)
    delta = delta or 1e-4
    return function (x)
        return (f(x + delta) - f(x)) / delta
    end
end
```

`derivative(f, delta)` 函数将创建一个新函数，它接收坐标 `x` 返回函数 `f` 在这一点的导数。

相比于传统的 `derivative(f, delta, x)`，这样的写法更加灵活。

## 词法定界
在 Lua 中，定义在外层函数 A 内部的函数 B 可以访问 A 内定义的所有局部变量以及 A 的参数，这样的特性被称为**词法定界**。

对于 C/C++ 等语言，这样的写法是错误的，因为外层函数返回之后，其中的局部变量空间便被回收了，如果内层函数试图去操作这些局部变量，就可能触发段错误。

在 Lua 中则不然。对于下面的代码：
```lua
function A()
    local cnt = 0
    return function ()
        cnt = cnt + 1
        return cnt
    end
end
```

- 即便 `A` 已经返回，调用该返回值（函数）依然是合法的
- 每次调用 `A` 所得到的函数所维护的变量 `cnt` 都是**独立的**

## 函数式编程示例二：几何区域显示系统
见 [geometry.lua](../code/geometry.lua)
