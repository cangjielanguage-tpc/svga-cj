/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.parser

import svga.proto.*
import svga.utils.*
import ohos.resource_manager.*
import std.collection.HashMap
import stdx.encoding.base64.*
import ohos.hilog.Hilog
//
//public type CbFn = (MockWorkerResponseData) -> Unit
//
//public type DecodeCbFn = (MockWorkerDecodeResponseData) -> Unit

public class MockWorker {
    public static func load(url: String): ?MovieEntity {
        try {
            let stageContext = getStageContext(globalcontext.getOrThrow())
            let rm = ResourceManager.getResourceManager(stageContext)
            let buffer: Array<UInt8> = rm.getRawFileContent(url)
            return MockWorker.load_viaProto(buffer)
        } catch (e: Exception) {
            Hilog.error(0, "ERROR", "read file error ${e.toString()}")
            None
        }
    }

    public static func load_viaProto(arraybuffer: Array<Byte>) {
        var res: MovieEntity = Inflate(arraybuffer).get()
        return res
    }

}

