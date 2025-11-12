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

public type CbFn = (MockWorkerResponseData) -> Unit

public type DecodeCbFn = (MockWorkerDecodeResponseData) -> Unit

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

    public static func load_viaProto(arraybuffer: Array<Byte>): MovieEntity {
        var res: MovieEntity = Inflate(arraybuffer).get()
        return res
    }

    public static func decode(key: String, src: String, types: String, dir: String, cb: DecodeCbFn, failure: ?FailureFn): Unit {
        try {
            spawn {
                => cb(base64ToBitmap(key, src, types, dir))
            }
        } catch (error: Exception) {
            if (let Some(failure) <- failure) {
                failure(error)
            }
        }
    }
}

public open class MockWorkerResponseData {
    public var movie: MovieEntity
    public var images: HashMap<String, String>
    public init(movie: MovieEntity, images: HashMap<String, String>) {
        this.movie = movie
        this.images = images
    }
}

public open class MockWorkerDecodeResponseData {
    public var key: String = ""

    public var bitmap: ?PixelMap = None

    public var fd: Int32 = 0
}

func base64ToBitmap(key: String, src: String, types: String, dir: String) {
    let response: MockWorkerDecodeResponseData = MockWorkerDecodeResponseData()
    response.key = key
    try {
        if (types == "image") {
            var buf = fromBase64String(src).getOrThrow()
            var img = createImageSource(buf)
            var info = img.getImageInfo()

            let pixelMap: PixelMap = img.createPixelMap(
                options: DecodingOptions(editable: false,
                    desiredSize: Size(width: info.size.width, height: info.size.height)))
            response.bitmap = pixelMap
            img.Release()
        } else {
            var fd = FileManager.saveAudio(src, dir)
            response.fd = fd
        }
    } catch (e: Exception) {
    }
    return response
}
