/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */

package svga.proto

import encoding.base64.*

struct StructPrinter <: ToString {
    private let stb = StringBuilder("{")
    private var sep = false

    public mut func append(key: String, str: ToString): Unit {
        if (sep) { stb.append(", ") } else { sep = true }
        stb.append(key)
        stb.append(": ")
        stb.append(str)
    }

    public mut func append(key: String, str: String): Unit {
        if (sep) { stb.append(", ") } else { sep = true }
        stb.append(key)
        stb.append(": \"")
        stb.append(str)
        stb.append('"')
    }

    public mut func clear(): Unit { stb.reset(); stb.append('{'); sep = false }
    public func done() { stb.append('}'); this }
    public func toString() { stb.toString() }
}

func subReader<T>(reader: T) where T <: BytesReader {
    SimpleReader(reader.read(reader.parseInt64()))
}