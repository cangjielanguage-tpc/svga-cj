## zlib4cj 库

### 介绍
该库提供流式压缩和解压功能、整体压缩和解压功能。
注意：压缩及解压中，wrap 设置需一致。


    注意：压缩解压超大文件（100M）时，需要设置 export CJHEAPSIZE=2GB

    仓颉默认规格 stack 1MB，heap 256 MB，建议根据文件数量大小将堆内存调到合适的大
    小。一般 2GB 满足大多数情况，如果不够再视情况增加大小。

### 1 zlib 格式支持

前置条件：NA 

场景：
1. 支持zlib文件压缩、解压缩功能。

约束：NA

性能： 支持版本几何性能持平

可靠性： NA

#### 1.1 zlib 压缩功能

##### 1.1.1 主要接口

###### class Zlib

```cangjie
public class Zlib { 
    /*
     * 将数组 inbuf 中的数据，以指定的压缩级别进行压缩
     * 
     * 参数 inbuf - 将数组 inbuf 中的数据进行压缩 
     * 参数 level - 压缩级别 (0-9)，默认值为 LEVEL_DEFAULT_COMPRESSION 
     *              (压缩级别, LEVEL_DEFAULT_COMPRESSION = 6) 
     * 参数 wrap - 压缩文件格式 ZLIB 
     *
     * 返回值 ArrayList<UInt8> - 压缩后的数据封装成 ArrayList<UInt8> 格式返回 
     */
    public static func compress(inbuf: Array<UInt8>, level!: UInt32 = LEVEL_DEFAULT_COMPRESSION, wrap: ZLIB): ArrayList<UInt8> 
}
```

##### 1.1.2 示例

代码如下：

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
    // level: 0-9 success
    for(j in 0..9) {
        let buf: ArrayList<UInt8> = Zlib.compress(data, level: UInt32(j))
        let arr: Array<UInt8> = Array<UInt8>(buf.size, { i => buf[i] })
        let result: ArrayList<UInt8> = Zlib.uncompress(arr)
        
        if(checkResult(data, result, "testCompressAndUncompress") != 0) {
            return -1
        }
        return 0
    }  
    return 0
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


#### 1.2 zlib 解压功能

##### 1.2.1 主要接口

###### class Zlib

```cangjie
public class Zlib { 
    /*
     * 将数组 inbuf 中的数据进行解压 
     *
     * 参数 inbuf - 将数组 inbuf 中的数据进行解压 
     * 参数 wrap - 压缩文件格式，ZLIB
     *
     * 返回值 ArrayList<UInt8> - 解压后的数据封装成 ArrayList<UInt8> 格式返回 
     */ 
    public static func uncompress(inbuf: Array<UInt8>, wrap: ZLIB): ArrayList<UInt8>
}
```

##### 1.2.2 示例

代码如下：

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

#### 1.3 其他接口
##### 1.3.1 class Stream

此类是流压缩和解压缩基类。

```cangjie
public open class Stream {
    /*
     * 调用 init()，初始化 Stream 
     */
    public init()

    /*
     * 判断内部输出缓冲区是否为空，为空后，调用解压缩接口前需先重新设置输入数据 
     * 返回值 Bool - 判断内部输出缓冲区是否为空，如果是空返回 true，否则返回 false 
     */
    public func isInbufEmpty(): Bool

    /*
     * 检查输出缓冲区中是否有数据 
     * 返回值 Bool - 如果输出缓冲区中有数据，则返回 true，否则返回 false 
     */ 
    public func isHaveOutData(): Bool 

    /*
     * 设置输入缓冲区 
     * 参数 buf - 将 buf 设置为输入缓冲区 
     * 返回值 Int64 - 返回输入缓冲区实际剩余空间 
     */ 
    public func setInBuf(buf: Array<UInt8>): Int64 

    /*
     * 设置输入缓冲区 
     * 参数 buf - 将 buf 设置为输入缓冲区 
     * 参数 start - 将 start 设置为输入缓冲区当前光标位置 
     * 参数 len - 将 len 设置为输入缓冲区剩余空间 
     * 返回值 Int64 - 返回输入缓冲区实际剩余空间 
     */ 
    public func setInBuf(buf: Array<UInt8>, start: Int64, len: Int64): Int64 

    /*
     * 设置输出缓冲区 
     * 参数 buf - 将 buf 设置为输出缓冲区 
     * 返回值 Int64 - 返回输出缓冲区实际剩余空间 
     */ 
    public func setOutBuf(buf: Array<UInt8>): Int64 

    /*
     * 设置输出缓冲区 
     * 参数 buf - 将 buf 设置为输出缓冲区 
     * 参数 start - 将 start 设置为输出缓冲区当前光标位置 
     * 参数 len - 将 len 设置为输出缓冲区剩余空间 
     * 返回值 Int64 - 返回输出缓冲区实际剩余空间 
     */ 
    public func setOutBuf(buf: Array<UInt8>, start: Int64, len: Int64): Int64 
    
    /*
     * 重置输出缓冲区状态 
     */ 
    public func resetOutBuf(): Unit

    /*
     * 返回输出缓冲区中数据长度 
     * 返回值 Int64 - 返回输出缓冲区中数据长度 
     */ 
    public func getOutDataLength(): Int64 

    /*
     * 返回总输出数数据字节数 
     * 返回值 Int64 - 返回总输出数数据字节数 
     */ 
    public func getTotalOut(): Int64 

    /*
     * 返回总输入数据字节数 
     * 返回值 Int64 - 返回总输入数据字节数 
     */ 
    public func getTotalIn(): Int64
}
```

##### 1.3.2 class Deflate

此类继承 Stream, 实现压缩功能，提供流式压缩接口 deflateInit 、 deflate 、 deflateBound 、 setGzipHeader 、 setDictionary 。

```
public class Deflate <: Stream { 
    /*
    * 调用 init()，初始化 deflate. 
    */ 
    public init() 
    
    /*
    * 初始化压缩参数、状态，为内部缓冲区申请内存 
    * 参数 wrap - 压缩数据外包装类型，默认值为 ZLIB (压缩文件格式：ZLIB/DEFLATE) 
    * 参数 level - 压缩级别，默认值为 LEVEL_DEFAULT_COMPRESSION 
    *              (压缩级别 0-9， LEVEL_DEFAULT_COMPRESSION = 6) 
    * 参数 wbits - 窗口位数，默认值为 DEF_WINDOW_BITS (窗口位数 8-15： 
    *              DEF_WINDOW_BITS = 15) 
    * 参数 mlevel - 内存级别，默认值为 DEF_MEM_LEVEL (内存级别： 
    *               memlevel 1-9, DEF_MEM_LEVEL = 8) 
    * 参数 strategy - 压缩策略，默认值为 Z_DEFAULT_STRATEGY，取值为： 
    *                 Z_DEFAULT_STRATEGY：20 
    *                 Z_FILTERED：21 
    *                 Z_HUFFMAN_ONLY：22 
    *                 Z_RLE：23 
    *                 Z_FIXED：24 
    *
    * 返回值 UInt32 - 返回执行 deflateInit 函数的状态值，如果正常执行完 
    *                成返回值为 Z_OK (函数的返回值: Z_OK = 0) 
    */ 
    public func deflateInit(wrap!: WrapType = ZLIB, level!: UInt32 = LEVEL_DEFAULT_COMPRESSION, wbits!: UInt32 = DEF_WINDOW_BITS, mlevel!: UInt32 = DEF_MEM_LEVEL, strategy!: UInt32 = Z_DEFAULT_STRATEGY): UInt32

    /*
     * 压缩数据 
     *
     * 参数 flush - 缓冲处理类型 
     *              Z_NO_FLUSH: 计算输出结果前需要缓冲的数据量，以此来最大化压缩率。 
     *              Z_SYNC_FLUSH：所有未输出的结果会被 flush 到输出缓冲区，并以字节为单 位进行对齐。 
     *              Z_PARTIAL_FLUSH：所有未输出的结果会被 flush 到输出缓冲区中，但是输出 不会以字节为单位进行对齐。 
     *              Z_BLOCK：一个 deflate 块已经结束并释放，解压程序可能需要等待下一个块 被吐出时才能进行解压。这个 
     *                      特性可以用于控制 deflate 块的吞吐。 
     *              Z_FULL_FLUSH：所有的输出都会像 Z_SYNC_FLUSH 一样被冲出，并且压缩状 态会被重置，这样如果之前的 
     *                          已压缩数据被损坏或有随机访问需求，那么解压程序可以从这 个点重新开始运行。 
     *              Z_FINISH：所有的输入都会被处理并且所有的输出都会被冲出。 
     *
     * 返回值 UInt32 - 返回执行 deflate 函数的状态值 
     */ 
    public func deflate(flush: UInt32): UInt32

    /*
     * deflate 结束
     *
     * 返回值 UInt32 - 返回执行 deflateEnd 函数的状态值
     */
    public func deflateEnd(): UInt32

    /*
     * 根据源数据大小，计算压缩后数据最大尺寸，必须在 deflateInit 和 setGzipHeader 之后调用 
     *
     * 参数 sourceLen - 源数据大小 
     *
     * 返回值 Int64 - 压缩后数据最大尺寸 
     */
    public func deflateBound(sourceLen: Int64): Int64

    /*
     * 压缩开始前预设字典 (deflateInit 之后， deflate 之前调用) 
     * 设置的字典必须和要压缩的信息有关联关系，且字典中有效信息长度大于2，否则此设置无效。
     *
     * 参数 dict - 将数组 dict 中的数据设置为字典 
     *
     * 返回值 UInt32 - 返回执行 setDictionary 函数的状态值，如果正常执行完成返回值 
     *                 为 Z_OK (函数的返回值: Z_OK = 0) 
     */ 
    public func setDictionary(dict: Array<UInt8>): UInt32
}

```


##### 1.3.3 class Inflate

此类实现解压功能, 提供流式压缩接口 inflateInit 、 inflate 、 getGzipHeader 、 setDictionary 、 inflateSync 。

```
public class Inflate <: Stream { 
    /*
     * 调用 init()，初始化 inflate. 
     */ 
    public init() 
    
    /*
     * 初始化解压参数、状态、内部缓冲区 
     *
     * 参数 wrap - 压缩数据外包装类型，默认值为 ZLIB (压缩文件格式: ZLIB/DEFLATE) 
     * 参数 wbits - 窗口位数，默认值为 DEF_WINDOW_BITS (窗口位数: 
     *              DEF_WINDOW_BITS = 15) 
     * 参数 ischeck - 是否检查原始数据检验值和 gzip 头的检验值 
     *
     * 返回值 UInt32 - 返回执行 inflateInit 函数的状态值，如果正常执行完成返回值 
     *                 为 Z_OK (函数的返回值: Z_OK = 0) 
     */ 
    public func inflateInit(wrap!: WrapType = ZLIB, wbits!:UInt32 = DEF_WINDOW_BITS, ischeck!: Bool = true): UInt32

    /*
     * 解压数据 
     *
     * 参数 flush - 缓冲处理类型 
     *              Z_SYNC_FLUSH: 要求 inflate() 冲出尽可能多的输出到输出缓冲区中。 
     *              Z_BLOCK：这个参数选项在处理合并 deflate 流或者往已有的流中添加内容时 派上用场，可以用来检查当前已消耗的数据的位数。 
     *              Z_TREES：可以用来检查 deflate 块头部的长度，以便之后在 deflate 块中 进行随机访问。 
     *              Z_FINISH：所有的解压操作都需要在一次调用中完成，所有的输入都会被处理并 且所有的输出都会被冲出。
     *
     * 返回值 UInt32 - 返回执行 inflate 函数的状态值 
     */ 
    public func inflate(flush: UInt32): UInt32

    /*
     * inflate 结束
     *
     * 返回值 UInt32 - 返回执行 inflateEnd 函数的状态值
     */
    public func inflateEnd(): UInt32

    /*
     * 设置字典，当 WrapType (压缩文件格式: ZLIB/DEFLATE) 类型为 DEFLATE 格式时， 在 inflateInit 之后 inflate 之前调用； 
     *          当 WrapType 类型为 ZLIB 格式时，在 inflate 返回 Z_NEED_DICT(函数的返回值: Z_NEED_DICT = 2) 后调用；  
     * 如果压缩时设置了字典，则解压前必须设置相同的字典 
     *
     * 参数 dict - 将数组 dict 中的数据设置为字典 
     *
     * 返回值 UInt32 - 返回执行 setDictionary 函数的状态值，如果正常执行完成 
     *                 返回值为 Z_OK (函数的返回值: Z_OK = 0) 
     */ 
    public func setDictionary(dict: Array<UInt8>): UInt32 

    /*
     * 解压时跳过非法的压缩数据，从下一个全刷新点开始解压，压缩时选择 
     * Z_FULL_FLUSH (冲洗类型: Z_FULL_FLUSH = 13) 策略会生成带全刷 
     * 新点的压缩数据 
     *
     * 返回值 UInt32 - 返回执行 inflateSync 函数的状态值，如果正常执行完成返回 
     *                 值为 Z_OK (函数的返回值: Z_OK = 0) 
     */ 
    public func inflateSync(): UInt32

}
```

##### 1.3.4 enum WrapType

此枚举压缩文件格式：ZLIB、DEFLATE。

```cangjie
public enum WrapType { 
    | ZLIB 
    | DEFLATE 
}
```

##### 1.3.5 zutil.cj全局方法
```cangjie
/*
 * adler32校验
 *
 * 参数 value - 上个检测返回值, 初始为0
 * 参数 buf - 输出缓冲 
 * 参数 start - 开始位置 
 * 参数 length - 长度 
 *
 */ 
public func adler32(check: UInt32, buf: Array<UInt8>, start: Int64, length: Int64): UInt32

/*
 * crc32校验
 *
 * 参数 value - 上个检测返回值, 初始为0
 * 参数 buf - 输出缓冲 
 * 参数 start - 开始位置 
 * 参数 length - 长度 
 *
 */ 
public func crc32(value: UInt32, buf: Array<UInt8>, start: Int64, length: Int64): UInt32
```
##### 1.3.6 class ReturnValue（内部使用）
```cangjie
/*
 * 构造函数
 *
 * 参数 rtype - 返回值类型 
 * 参数 value - 返回值内容 
 *
 */ 
public init(rtype!: ReturnType = OTHER, value!: Int64 = 0) {
    this.rtype = rtype
    this.value = value
}

/*
 * 清空方法 
 */ 
public func clear() {
    rtype = OTHER
    value = 0
}
```
##### 1.3.7 示例
Deflate 和 Inflate 的使用

代码如下：

```cangjie
import zlib4cj.* 
import std.collection.* 
import std.io.*
import std.os.posix.*
import std.fs.*

main() { 
    var fileName: String = "${path}/zlib_01_test.md"
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
    var outlen: Int64 = deflate.deflateBound(inbuf.size) 
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
    var outbuf: Array<UInt8> = Array<UInt8>(inbuf.size, item: 0) 
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