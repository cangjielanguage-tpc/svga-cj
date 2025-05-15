<p align="center">
<img src="./doc/assets/logo.jpg" width="70%" >
</p>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.30.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-88%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>简介

本仓库是使用仓颉语言重写 zlib 库，参考 https://github.com/madler/zlib

### 特性

- 🚀 支持压缩和解压功能

- 💪 支持流式压缩

- 🛠️ 支持设置压缩头信息（仅支持 GZIP 压缩文件类型）

- 🌍 支持压缩开始前预设字典

##    <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 架构

### 类和接口说明：

#### Zlib
    - compress： 压缩数据
    - uncompress： 解压数据

#### Stream
    - isInbufEmpty： 判断输入缓冲区的数据是否消耗完
    - isHaveOutData：输出缓冲区是否有数据
    - getOutDataLength：返回输出缓冲区中数据长度
    - setInBuf：设置输入缓冲区
    - setOutBuf：设置输出缓冲区
    - getTotalIn ：返回总输入数据字节数
    - getTotalOut： 返回总输出数数据字节数

#### Deflate
    - 继承Stream，可直接使用 Stream 相关接口
    - deflateInit： 初始化压缩参数、状态、内部缓冲区
    - deflate： 执行压缩任务
    - deflateEnd： 压缩完成后检查状态
    - deflateBound： 根据源数据大小返回压缩数据最大尺寸
    - setDictionary： 压缩开始前预设字典（deflateInit 之后，deflate 之前调用）
    - setGzipHeader： 压缩文件类型选择GZIP时，用来设置gzip格式头信息（deflateInit 之后，deflate 之前调用）

#### Inflate
    - 继承Stream，可直接使用 Stream 相关接口
    - inflateInit： 初始化解压参数、状态、内部缓冲区
    - inflate： 执行解压任务
    - inflateEnd： 解压完成后检查状态
    - setDictionary： 设置字典，inflateInit 之后 inflate 之前调用 或 inflate 返回 Z_NEED_DICT 后调用
    - getGzipHeader： 解压 gzip 格式文件数据后，调用此接口获取 gzip 格式信息

### 源码目录：

```shell
.
├── README.md
├── doc
│   ├── assets     
│   ├── zlib.pdf
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

- `doc` 是库的设计文档、提案、库的使用文档、LLT 用例覆盖报告（有些压缩情况无法实际测到，所以未到90%）
- `src` 是库源码目录
- `test` 是存放测试用例，包括 HLT 用例、LLT 用例和 UT 用例

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/>编译运行

### 编译

```shell
cpm build
```

### 示例1

zlib 使用示例

```cangjie
from test import zlib.*
from std import collection.* 
from std import io.*

main() { 
    var fileName: String = "../../../../README.md"
    var data: Array<UInt8> = readFile(fileName) 
    // wrap: ZLIB success
    testCompressAndUncompress(data)     
}

func testCompressAndUncompress(data: Array<UInt8>): Unit {
    let buf: ArrayList<UInt8> = Zlib.compress(data)
    let arr: Array<UInt8> = Array<UInt8>(buf.size(), { i => buf[i] })
    let result: ArrayList<UInt8> = Zlib.uncompress(arr)
    checkResult(data, result, "testCompressAndUncompress")     
}
func readFile(path: String): Array<UInt8> { 
    var data = Array<UInt8>()
    var fs = FileStream(path, ReadOnly)
    var readnum: Int64 = 0
    if (fs.openFile()) {
        var size = fs.seek(0, EndPos)
        fs.seek(0, BeginPos)
        data = Array<UInt8>(size, item: 0)
        readnum = fs.read(data, 0, size)
        if (readnum != size) {
            println("read file failed: ${path}\n")
        }
    }
    return data
}   
func compareBuffer(input: Array<UInt8>, uncompr: ArrayList<UInt8>): Bool {
    if (input.size() != uncompr.size()) {
        return false
    }
    for (i in 0..input.size()) {
        if (input[i] != uncompr[i]) {
            return false
        }
    }
    return true
}
func checkResult(input: Array<UInt8>, uncompr: ArrayList<UInt8>, desc: String): Unit {
    if (compareBuffer(input, uncompr)) {
        print("successed: ${desc}\n")
    } else {
        print("failed: ${desc}\n")
    }
}
```

运行结果如下

```
successed: testCompressAndUncompress
```

### 示例2

Deflate 和 Inflate 使用示例

```cangjie
from test import zlib.*
from std import collection.* 
from std import io.*


main() { 
    var fileName: String = "../../../../README.md" 
    var data: Array<UInt8> = readFile(fileName)
    // Normal data test setDictionary
    testDictionary(data)      
}

func testDictionary(data: Array<UInt8>): Unit { 
    compressAndUncompressSetD(data, "UInt Array func") 
    compressAndUncompressSetD(data, "deflate inflate zlib") 
}
func compressAndUncompressSetD(data: Array<UInt8>, strDictionary: String): Unit { 
    let buf: Array<UInt8> = compressSetDictionary(data, strDictionary) 
    let retbuf: ArrayList<UInt8> = uncompressSetDictionary(buf, strDictionary) 
    checkResult(data, retbuf, "test dictionary: " + strDictionary) 
}
func compressSetDictionary(inbuf: Array<UInt8>, strDictionary: String): Array<UInt8> { 
    var deflate: Deflate = Deflate() 
    if (deflate.deflateInit() != Z_OK) { 
        println("error compressSetDictionary() -> deflateInit(): ${deflate.message}") 
    }
    var outlen: Int64 = deflate.deflateBound(inbuf.size()) 
    var outbuf: Array<UInt8> = Array<UInt8>(outlen, item: 0) 
    deflate.setInBuf(inbuf) 
    deflate.setOutBuf(outbuf) 
    if (deflate.setDictionary(strDictionary.toUtf8Array()) != Z_OK) {
        println("error compressSetDictionary() -> setDictionary(): ${deflate.message}") 
    }
    if (deflate.deflate(Z_FINISH) != Z_STREAM_END) { 
        println("error compressSetDictionary() -> deflate(): ${deflate.message}") 
    }
    var retbuf: Array<UInt8> = outbuf[0..deflate.getOutDataLength()] 
    return retbuf 
}
func uncompressSetDictionary(inbuf: Array<UInt8>, strDictionary: String): ArrayList<UInt8> { 
    var retbuf: ArrayList<UInt8> = ArrayList<UInt8>() 
    var outbuf: Array<UInt8> = Array<UInt8>(inbuf.size(), item: 0) 
    var inflate: Inflate = Inflate() 
    inflate.setInBuf(inbuf) 
    inflate.setOutBuf(outbuf) 
    if (inflate.inflateInit() != Z_OK) { 
        println("error uncompressSetDictionary() -> inflateInit(): ${inflate.message}") 
    }
    var ret: UInt32
    while (true) { 
        ret = inflate.inflate(Z_NO_FLUSH) 
        match { 
            case ret == Z_NEED_DICT =>
                if (inflate.setDictionary(strDictionary.toUtf8Array()) != Z_OK) { 
                    println("error uncompressSetDictionary() -> setDictionary(): ${inflate.message}") 
                } 
            case ret == Z_OK => 
                if (inflate.isHaveOutData()) { 
                    retbuf.addAll(outbuf[0..inflate.getOutDataLength()]) 
                    inflate.resetOutBuf() 
                } 
            case ret == Z_STREAM_END => 
                if (inflate.isHaveOutData()) {
                    retbuf.addAll(outbuf[0..inflate.getOutDataLength()]) 
                    inflate.resetOutBuf() 
                }
                break 
            case _ => 
                println("error uncompressSetDictionary() -> inflate(): ${inflate.message}") 
                break 
        } 
    }
    return retbuf 
}
func readFile(path: String): Array<UInt8> { 
    var data = Array<UInt8>()
    var fs = FileStream(path, ReadOnly)
    var readnum: Int64 = 0
    if (fs.openFile()) {
        var size = fs.seek(0, EndPos)
        fs.seek(0, BeginPos)
        data = Array<UInt8>(size, item: 0)
        readnum = fs.read(data, 0, size)
        if (readnum != size) {
            println("read file failed: ${path}\n")
        }
    }
    return data
}   
func compareBuffer(input: Array<UInt8>, uncompr: ArrayList<UInt8>): Bool {
    if (input.size() != uncompr.size()) {
        return false
    }
    for (i in 0..input.size()) {
        if (input[i] != uncompr[i]) {
            return false
        }
    }
    return true
}
func checkResult(input: Array<UInt8>, uncompr: ArrayList<UInt8>, desc: String): Unit {
    if (compareBuffer(input, uncompr)) {
        print("successed: ${desc}\n")
    } else {
        print("failed: ${desc}\n")
    }
}
```

运行结果如下

```
successed: test dictionary: UInt Array func 
successed: test dictionary: deflate inflate zlib
```



## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/>参与贡献

[@chinesebear](https://gitee.com/chinesebear)
