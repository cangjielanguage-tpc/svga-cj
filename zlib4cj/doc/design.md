### 三方库设计说明

#### 1 需求场景分析

一个用于提供流式压缩和解压功能、整体压缩和解压功能。

#### 2 三方库对外提供的特性

（1） 支持流式压缩。

（2） 支持压缩和解压功能。

（3） 支持设置压缩头信息（仅支持 GZIP 压缩文件类型）。

（4） 支持压缩开始前预设字典。

#### 3 License分析

无

#### 4 依赖分析 

仓颉 std 下的 math、collection


#### 5 特性设计文档

##### 5.1 核心特性1 

###### 5.1.1 特性介绍

    支持流式压缩。

###### 5.1.2 实现方案

    采用两种算法模式，adler32、crc32数据校验

    a) LZ77 算法

    b) Huffman算法

###### 5.1.3 接口设计

💡 Stream 流压缩和解压缩基类。

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- |  --- | --- |
| init   | 无 | Unit | 初始化 Stream |
| isInbufEmpty   | 无 | Bool |  判断内部输出缓冲区是否为空，为空后，调用解压缩接口前需先重新设置输入数据  |
| isHaveOutData   | 无 | Bool | 检查输出缓冲区中是否有数据 |
| setInBuf   | buf: Array<UInt8> | Int64 | 设置输入缓冲区 |
| setInBuf   | buf: Array<UInt8>, start: Int64, len: Int64 | Int64 | 设置输入缓冲区 |
| setOutBuf   | buf: Array<UInt8> | Int64 | 设置输出缓冲区 |
| setOutBuf   | buf: Array<UInt8>, start: Int64, len: Int64 | Int64 | 设置输出缓冲区 |
| resetOutBuf   |无 | Unit | 重置输出缓冲区状态 |
| getOutDataLength   | 无 | Int64 | 返回输出缓冲区中数据长度 |
| getTotalOut   | 无 | Int64 | 返回总输出数数据字节数 |
| getTotalIn   | 无 | Int64 | 返回总输入数据字节数 |

💡 GzHeader 当压缩文件格式是 GZIP 时，设置压缩头参数。

| 成员变量  | 类型 | 作用描述 |
| --- | --- | --- |
| text   |Int32 | text 只有 0 和 1, 是个标志位，为 1 说明输入的数据是文本 |
| time   | Int32|修改时间 |
|  xflags  |Int32 |压缩程度（值为 2、4、0）  |
|  os  | Int32 |操作系统（0-255） |
| extra   |ArrayList<UInt8> |额外字段 |
|  name  |ArrayList<UInt8> |文件名 |
|  comment |ArrayList<UInt8> |注释  |
|  hcrc  |Bool |是否写入 gzip 头的校验值到 gzip 头中 |

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | ---  |
| init   | 无 | 无 | 初始化 GzHeader |


💡 Deflate 此类继承 Stream, 实现压缩功能，提供流式压缩接口 deflateInit 、 deflate 、 deflateBound 、 setGzipHeader 、 setDictionary 

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | ---  |
| init   | 无 | 无 | 初始化 deflate |
| deflateInit   | wrap!: WrapType = ZLIB, level!: UInt32 = LEVEL_DEFAULT_COMPRESSION, wbits!: UInt32 = DEF_WINDOW_BITS, mlevel!: UInt32 = DEF_MEM_LEVEL, strategy!: UInt32 = Z_DEFAULT_STRATEGY | UInt32 | 初始化压缩参数、状态，为内部缓冲区申请内存 |
| deflate   | flush: UInt32 | UInt32 | 压缩数据 |
| deflateEnd   |无 | UInt32 | deflate 结束 |
| deflateBound   | sourceLen: Int64 | Int64 | 根据源数据大小，计算压缩后数据最大尺寸，必须在 deflateInit 和 setGzipHeader 之后调用 |
| setDictionary   | dict: Array<UInt8> | UInt32 | 压缩开始前预设字典 (deflateInit 之后， deflate 之前调用) |
| setGzipHeader   | gzhead: GzHeader | UInt32 | 压缩文件类型选择 GZIP 时，用来设置 gzip 格式头信息（deflateInit 之后 ，deflate 之前调用)  |


💡 Inflate 此类实现解压功能, 提供流式压缩接口 inflateInit 、 inflate 、 getGzipHeader 、 setDictionary 、 inflateSync 。

| 接口名 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | ---  |
| init   | 无 | 无 | 初始化 inflate |
| inflateInit   | wrap!: WrapType = ZLIB, wbits!:UInt32 = DEF_WINDOW_BITS, ischeck!: Bool = true | UInt32 | 初始化解压参数、状态、内部缓冲区 |
| inflate   | flush: UInt32 | UInt32 | 解压数据 |
| inflateEnd   | 无 | UInt32 | inflate 结束 | 
| setDictionary   | dict: Array<UInt8> | UInt32 | 设置字典 |
| getGzipHeader   | gzhead: GzHeader | UInt32 | 解压 gzip 格式文件后，通过此函数获取 gzip 格式文件头部信息 |
| inflateSync   | 无 | UInt32 | 解压时跳过非法的压缩数据，从下一个全刷新点开始解压 |

💡 WrapType 压缩文件格式。

GZIP、ZLIB、DEFLATE

###### 5.1.4 展示示例

```cangjie
from zlib4cj import zlib.* 
from std import collection.* 
from std import io.*

main() { 
    var fileName: String = "../../../../README.md"
    var data: Array<UInt8> = readFile(fileName) 
    // Normal data test deflateStored, result: success
    testDeflateStored(data)  
}

func testDeflateStored(data: Array<UInt8>): Unit { 
    compressAndUncompressTestStored(data, "this is dictionary")
}

func compressAndUncompressTestStored(data: Array<UInt8>, strDictionary: String): Unit { 
    let buf: Array<UInt8> = compressTestStored(data, strDictionary) 
    let retbuf: ArrayList<UInt8> = uncompressTestStored(buf, strDictionary)
    checkResult(data, retbuf, "testDeflateStored: " + strDictionary)     
}

func compressTestStored(inbuf: Array<UInt8>, strDictionary: String): Array<UInt8> { 
    var deflate: Deflate = Deflate() 
    var outlen: Int64 = deflate.deflateBound(inbuf.size()) 
    var outbuf: Array<UInt8> = Array<UInt8>(outlen, item: 0) 
    deflate.setInBuf(inbuf) 
    deflate.setOutBuf(outbuf) 

    if (deflate.deflateInit(level: LEVEL_NO_COMPRESSION) != Z_OK) { 
        println("error compressTestStored() -> deflateInit(): ${deflate.message}") 
    }
    if (deflate.setDictionary(strDictionary.toArray()) != Z_OK) {
        println("error compressTestStored() -> setDictionary(): ${deflate.message}") 
    }
    if (deflate.deflate(Z_FINISH) != Z_STREAM_END) { 
        println("error compressTestStored() -> deflate(): ${deflate.message}") 
    }
    var retbuf: Array<UInt8> = outbuf[0..deflate.getOutDataLength()] 
    return retbuf 
}
func uncompressTestStored(inbuf: Array<UInt8>, strDictionary: String): ArrayList<UInt8> { 
    var retbuf: ArrayList<UInt8> = ArrayList<UInt8>() 
    var outbuf: Array<UInt8> = Array<UInt8>(inbuf.size(), item: 0) 
    var inflate: Inflate = Inflate() 
    inflate.setInBuf(inbuf) 
    inflate.setOutBuf(outbuf) 
    if (inflate.inflateInit() != Z_OK) { 
        println("error uncompressTestStored() -> inflateInit(): ${inflate.message}") 
    }
    var ret: UInt32
    while (true) { 
        ret = inflate.inflate(Z_NO_FLUSH)
        match { 
            case ret == Z_NEED_DICT =>
                if (inflate.setDictionary(strDictionary.toArray()) != Z_OK) { 
                    println("error uncompressTestStored() -> setDictionary(): ${inflate.message}") 
                } 
            case ret == Z_OK => 
                if (inflate.isHaveOutData()) { 
                    retbuf.appendAll(outbuf[0..inflate.getOutDataLength()]) 
                    inflate.resetOutBuf() 
                } 
            case ret == Z_STREAM_END => 
                if (inflate.isHaveOutData()) {
                    retbuf.appendAll(outbuf[0..inflate.getOutDataLength()]) 
                    inflate.resetOutBuf() 
                }
                break 
            case _ => 
                println("error uncompressTestStored() -> inflate(): ${inflate.message}") 
                break 
        } 
    }
    return retbuf 
}
func readFile(path: String): Array<UInt8> { 
    var data = Array<UInt8>()
    var fs = FileStream(path, AccessMode.Read)
    var readnum: Int64 = 0
    if (fs.openFile()) {
        data = fs.readAllBytes()
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

运行结果如下：

```cangjie
successed: testDeflateStored: this is dictionary
```

##### 5.2 核心特性2

###### 5.2.1 特性介绍

    此类提供一个整体的压缩和解压缩接口，用于压缩和解压缩整个数据。

###### 5.2.2 实现方案

    使用流式压缩进行封装。

###### 5.2.3 接口设计

💡 Zlib 提供一个整体的压缩和解压缩接口。

| 成员函数 | 入参 | 返回值 | 作用描述 |
| --- | --- | --- | ---  |
| compress  | inbuf: Array<UInt8>, level!: UInt32 = LEVEL_DEFAULT_COMPRESSION, wrap!: WrapType = ZLIB | ArrayList<UInt8>  | 压缩 |
| uncompress  | inbuf: Array<UInt8>, wrap!: WrapType = ZLIB | ArrayList<UInt8>  | 解压 |

###### 5.2.4 展示示例

```cangjie
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from zlib4cj import zlib.*
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
    var fs = FileStream(path)
    var readnum: Int64 = 0
    if (fs.openFile()) {
        data = fs.readAllBytes()
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

运行结果如下：

```cangjie
successed: testCompressAndUncompress
```