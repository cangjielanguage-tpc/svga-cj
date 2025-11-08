/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.utils

import svga.proto.*
import std.collection.ArrayList
import std.collection.HashMap
import ohos.hilog.*
import zlib4cj.*
import svga.global.*
import std.regex.*
import ohos.image.*
import std.convert.*
import protobuf.*

public func Inflate(src: Array<Byte>): Future<MovieEntity> {
    let fut: Future<MovieEntity> = spawn {
        =>
        var ubuf: Array<Byte> = Array<Byte>()
        try {
            ubuf = src.slice(0, 4)
        } catch (e: Exception) {
        }
        if (ubuf.size == 4 && ubuf[0] == 80 && ubuf[1] == 75 && ubuf[2] == 3 && ubuf[3] == 4) {

            let res = MovieEntity()
            res.unpack(src.toArray())
            return res
        } else {
            let result: ArrayList<UInt8> = Zlib.uncompress(src, wrap: ZLIB)
            var res = MovieEntity()
            res.unpack(result.toArray())
            var lastShapes = RepeatedMessage<ShapeEntity>()
            for (sprite in res.sprites) {
                for (frame in sprite.frames) {
                    if (frame.shapes.size > 0 && frame.shapes[0].type_ == ShapeEntity_ShapeType.KEEP) {
//                        frame.shapes = lastShapes
                    } else {
                        lastShapes = frame.shapes
                    }
                }
            }
            return res
        }
    }
    return fut
}


