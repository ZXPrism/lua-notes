# 8 - 补充知识

## 代码块（block）
类似 C/C++ 等语言中的 “作用域”。在 Lua 中，包括：

- 控制结构的主体（如 if、while、for 语句）
- 函数的主体
- 代码段（变量被声明时所在的文件）


## 控制结构
- `if .. then .. (elseif .. ..) else .. end`
- `while .. do .. end` = while
- `repeat .. until ..` = do while
- *(numerical for)* `for var = from, to(, step) do .. end`
- *(generic for)* `for var1, var2, .. in var3`
- `goto LABEL`
    - 使用 `::LABEL::` 来定义标签
    - 常用于实现**有限状态机**，因为 Lua 没有 switch 语句
