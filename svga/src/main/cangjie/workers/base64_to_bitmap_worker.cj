package svga.workers

import ohos.image.*
import stdx.encoding.base64.*

func workerPort(data: MessageEvents) {
    var src: String = data.src
    var key: String = data.key
    var types: String = data.types
    var dir: String = data.dir

    try {
        if (types == "img") {
            var buf: Array<UInt8> = fromBase64String(src).getOrThrow()
            // 创建imageSource
            var img = createImageSource(buf)
            var info = img.getImageInfo()
            var pixelMap: ?PixelMap = None
            pixelMap = img.createPixelMap(options: DecodingOptions(editable: false,
                desiredSize: Size(width: info.size.width, height: info.size.height)))
            img.Release()
            pixelMap?.Release()
            pixelMap = None
        }
    } catch (e: Exception) {
    }
}

class MessageEvents {
    var src: String
    var key: String
    var types: String
    var dir: String

    public init(src: String, key: String, types: String, dir: String) {
        this.src = src
        this.key = key
        this.types = types
        this.dir = dir
    }
}
