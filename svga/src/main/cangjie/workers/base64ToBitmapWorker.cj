/**
 * Created on 2025/1/17
 */
package svga.workers

//import tpc.UIKit.*
import tpc.ImageKit.image.*
//import tpc.ImageKit.image.*
//import ohos.image.*
//import ohos.resource_manager.AppResource
//import ohos.ability.*
//import ohos.base.BusinessException
import encoding.base64.*
//import encoding.base64.*

func workerPort(data: MessageEvents) {
    var src: String = data.src
    var key: String = data.key
    var types: String = data.types
    var dir: String = data.dir

    try {
        if (types == "img") {
            var buf: Array<UInt8> = fromBase64String(src).getOrThrow()
            // 1, 创建imageSource
            var img = createImageSource(buf)
            var info = img.getImageInfo()
            var pixelMap: ?PixelMap = None
            pixelMap = img.createPixelMap(options: DecodingOptions(editable: false,desiredSize: Size(info.size.width, info.size.height)))
            img.release({a,b =>})
            pixelMap?.release({a,b =>})
            pixelMap = None
        } else {
           // v.release({ a,b=> })
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
        this.key = src
        this.types = src
        this.dir = src
    }
}
