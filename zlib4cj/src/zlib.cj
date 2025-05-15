/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 *
 * Zlib class, which provides the compress and uncompress interfaces for decompressing and compressing the entire data.
 */
package zlib4cj

import std.collection.*

/**
 * This class Provides the overall decompression interface.
 *
 * @since 0.28.4
 */
public class Zlib {

    /**
     * Compressing data
     *
     * @param inbuf Input compression datas, type is Array<UInt8>
     * @param level Compression level, the default value is LEVEL_DEFAULT_COMPRESSION
     * @param wrap Compression type, the default value is ZLIB
     *
     * @return Buffer Returns a value of the ArrayList<UInt8> type.
     * @since 0.28.4
     */
    public static func compress(inbuf: Array<UInt8>, level!: UInt32 = LEVEL_DEFAULT_COMPRESSION, wrap!: WrapType = ZLIB): ArrayList<UInt8> {        
        var deflate: Deflate = Deflate()
        if (deflate.deflateInit(level:level, wrap:wrap) != Z_OK) {
            return ArrayList<UInt8>()
        }

        var outlen: Int64 = deflate.deflateBound(inbuf.size)
        var outbuf: Array<UInt8> = Array<UInt8>(outlen, repeat: 0)
        deflate.setInBuf(inbuf)
        deflate.setOutBuf(outbuf)

        if (deflate.deflate(Z_FINISH) != Z_STREAM_END) {
            return ArrayList<UInt8>()
        }

        if (deflate.deflateEnd() != Z_OK) {
            return ArrayList<UInt8>()
        }
        
        var retBuf: ArrayList<UInt8> = ArrayList<UInt8>(outbuf[0..deflate.getOutDataLength()])
        return retBuf
    }

    /**
     * Decompressing Data
     *
     * @param inbuf Input decompressing datas, type is Array<UInt8>
     * @param wrap Decompressing type, the default value is ZLIB
     *
     * @return Buffer Returns a value of the ArrayList<UInt8> type.
     * @since 0.28.4
     */
    public static func uncompress(inbuf: Array<UInt8>, wrap!: WrapType = ZLIB): ArrayList<UInt8> {
        var inflate: Inflate = Inflate()
        if (inflate.inflateInit(wrap: wrap) != Z_OK) {
            return ArrayList<UInt8>()
        }
        
        var outlen: Int64 = inbuf.size
        var outBuf: Array<UInt8> = Array<UInt8>(outlen, repeat: 0)
        inflate.setInBuf(inbuf)
        inflate.setOutBuf(outBuf)

        var ret: UInt32
        var retBuf: ArrayList<UInt8> = ArrayList<UInt8>()
        while (true) {
            ret = inflate.inflate(Z_NO_FLUSH)
            match {
                case ret == Z_OK =>
                    if (inflate.isHaveOutData()) {
                        retBuf.add(all: outBuf[0..inflate.getOutDataLength()])
                        inflate.resetOutBuf()
                    }
                case ret == Z_STREAM_END =>
                    if (inflate.isHaveOutData()) {
                        retBuf.add(all: outBuf[0..inflate.getOutDataLength()])
                        inflate.resetOutBuf()
                    }
                    break
                case _ =>
                    return ArrayList<UInt8>()
            }
        }

        if (inflate.inflateEnd() != Z_OK) {
            return ArrayList<UInt8>()
        }
        return retBuf
    }
}
