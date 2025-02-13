/**
 * Created on 2025/2/6
 */
package svga.parser

import svga.proto.*
import svga.utils.*
import std.io.ByteArrayStream
import tpc.UIKit.ResourceStr
import ohos.base.AppResource
import std.collection.HashMap
import std.unittest.UnitTestCase
import encoding.base64.*

public type CbFn = (MockWorkerResponseData) -> Unit

public type DecodeCbFn = (MockWorkerDecodeResponseData) -> Unit

public var context: Option<UIAbilityContext> = Option<UIAbilityContext>.None

public class MockWorker {
    public static func load(url: ResourceStr, cb: CbFn, fn: FailureFn) {
        try {
            let rm = context.getOrThrow().resourceManager
            let buffer: Array<UInt8> = rm.getMediaContent((url as AppResource).getOrThrow())
            MockWorker.load_viaProto(buffer, cb)
        } catch (e: Exception) {
            //console.error("read file error " + e)
        }
    }

    public static func load_viaProto(arraybuffer: Array<Byte>, cb: CbFn) {
        var res: MovieEntity = Inflate(arraybuffer).get()
        cb(MockWorkerResponseData(res, HashMap<String, String>()))
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
            // 1, 创建imageSource
            var img = createImageSource(buf)
            var info = img.getImageInfo()

            let pixelMap: PixelMap = img.createPixelMap(
                options: DecodingOptions(editable: false, desiredSize: Size(info.size.width, info.size.height)))

            response.bitmap = pixelMap
            img.release
        } else {
            var fd = FileManager.saveAudio(src, dir)
            response.fd = fd
        }
    } catch (e: Exception) {
        // console.error("Decode error: " + JSON.stringify(e), undefined, 4)
    }
    return response
}
