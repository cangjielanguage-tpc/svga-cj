/**
 * Created on 2025/1/11
 */
package svga.utils

import svga.proto.MovieEntity
import compress.zlib.*
import std.io.*
import std.collection.ArrayList

public func Inflate(src: Array<Byte>): Future<MovieEntity> {
    let fut: Future<MovieEntity> = spawn {
        =>
        var count: Int64 = 0
        let outBuf = ByteArrayStream();
        outBuf.write(src)
        let output: ByteArrayStream = ByteArrayStream(); // 用于存储解压后的数据

        var tempBuf: Array<UInt8> = Array<UInt8>(1024, item: 0)
        var decompressInputStream: DecompressInputStream = DecompressInputStream(outBuf, wrap: DeflateFormat)
        while (true) {
            var readNum = decompressInputStream.read(tempBuf)
            if (readNum <= 0) {
                break
            }
            output.write(tempBuf.slice(0, readNum).toArray())
            count += readNum
        }
        decompressInputStream.close()

        let res = MovieEntity()
        res.unpack(output.readToEnd())

        return res
    }
    return fut
}
