# 7 - 输入输出

> 一般只使用标准 I/O。
> 文件 I/O 和系统调用等与外部交互的功能通常由宿主程序实现。

## 简单 I/O 模型
- 包含一个*当前输入流（current input stream）* 和 *当前输出流（current output stream）*
    - 默认为 `stdin` 和 `stdout`
    - 使用 `io.input(file-name)` 更改输入流（为文件，且以只读模式打开）
    - 使用 `io.output(file-name)` 更改输出流（为文件）
- 使用 `io.write(a, b, c, ..)` 向当前输出流打印数据
  - 和 `print` 的区别
    - `print` 通常用于调试，而且**仅支持 `stdout`**
    - `print` 会自动为参数调用 `tostring`，而 `io.write` 强制要求参数为字符串
  - 使用 `string.format` 来控制格式
- 使用 `io.read(option)` 来从当前输入流读取数据
  - `option` 的可能取值有：
    - `"a"`：读取整个文件
    - `"l"`：读取一行，丢弃换行符
    - `"L"`：读取一行，保留换行符
    - `"n"`：读取一个数值，会跳过可能的空格，此时返回值为 `number`
    - `num`：读取 `num` 个字符
  - 如果读取不到需要的值或已到文件末尾（EOF），返回 `nil`
  - 支持**可变参数**，如 `io.read("n", "n")` 返回两个读取的整数
- 使用 `io.lines(size)` 迭代器来遍历输入的所有行
  - `size` 为可选参数，如果不加则遍历行，加了则**遍历 `size` 大小的块**


## 完整 I/O 模型
- 使用 `io.open(filename, option)` 打开一个文件，返回其句柄 `f`
  - 如果发生错误，除了返回 `nil` 以外，还会返回错误信息和错误码
    - 可以用 `assert` 接收错误信息，如 `assert(io.open(file, "r"))`
  - 使用 `f:read(option)` 读取数据
  - 使用 `f:write(..)` 写入数据
- 使用 `io.input()` （不带参数）获得当前输入流
  - `io.read()` 本质上是 `io.input():read()`
- 使用 `io.output()`（不带参数）获得当前输出流
  - `io.write()` 本质上是 `io.output():write()`


## 系统调用
- `os.exit(exitcode)` 以指定返回值终止程序执行
- `os.execute(cmd)` 用于系统调用
