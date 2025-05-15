<div align="center">
<h1>zlib4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v1.0.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.58.3-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-91%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>简介

本仓库支持 zlib 格式的压缩和解压缩。

### 特性

- 🚀 支持压缩和解压功能

- 💪 支持流式压缩

## <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 架构

### 源码目录：

```shell
.
├── README.md
├── doc
│   ├── assets     
│   ├── cjcov
│   ├── design.md
│   ├── feature_api.md
├── src
│   └── deflate.cj
│   └── inflate.cj
│   └── stream.cj
│   └── zlib.cj
│   └── zutil.cj
└── test   
    ├── HLT
    ├── LLT
    └── UT
```

- `doc` 存放库的设计文档、提案、库的使用文档、LLT 用例覆盖报告
- `src` 存放库源码的目录
- `test` 存放测试用例，包括 HLT 用例、LLT 用例和 UT 用例

### 类和接口说明：

详情见 [API](./doc/feature_api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译

```shell
cjpm build
```

### 功能示例

#### zlib 使用示例

```cangjie
import zlib4cj.*
import std.collection.* 
import std.io.*
import std.os.posix.*
import std.fs.*

main() { 
    var path: String = getcwd()
    var fileName: String = "${path}/README.md"
    var data: Array<UInt8> = readFile(fileName) 

    // wrap: ZLIB success
    if(testCompressAndUncompress(data) != 0) {
        return -1
    } 
    return 0
}

func testCompressAndUncompress(data: Array<UInt8>): Int64 {
    let buf: ArrayList<UInt8> = Zlib.compress(data, wrap: ZLIB)
    let arr: Array<UInt8> = Array<UInt8>(buf.size, { i => buf[i] })
    let result: ArrayList<UInt8> = Zlib.uncompress(arr, wrap: ZLIB)
    return checkResult(data, result, "testCompressAndUncompress")     
}
func readFile(path: String): Array<UInt8> { 
    var data = Array<UInt8>()
    var fs = File(path, OpenOption.Open(true, false) )
    var readnum: Int64 = 0
    if (fs.canRead()) {
        data = fs.readToEnd()
    }
    return data
}   
func compareBuffer(input: Array<UInt8>, uncompr: ArrayList<UInt8>): Bool {
    if (input.size != uncompr.size) {
        return false
    }
    for (i in 0..input.size) {
        if (input[i] != uncompr[i]) {
            return false
        }
    }
    return true
}
func checkResult(input: Array<UInt8>, uncompr: ArrayList<UInt8>, desc: String): Int64 {
    if (compareBuffer(input, uncompr)) {
        return 0
    } else {
        return -1
    }
}
```

运行结果如下：

```cangjie
0
```

## 约束与限制

在下述版本验证通过：

    Cangjie Version: 0.59.6

## 开源协议

本项目基于 [个人：(C) 1995-2022 Jean-loup Gailly and Mark Adler](./LICENSE) ，请自由的享受和参与开源。

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/>参与贡献

欢迎给我们提交 PR，欢迎给我们提交 issue，欢迎参与任何形式的贡献。
   ,