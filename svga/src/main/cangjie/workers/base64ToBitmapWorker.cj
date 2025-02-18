/**
 * Created on 2025/1/17
 */
package svga.workers

//import tpc.ImageKit.image.*
//import tpc.UIKit.component_interop.ImageBitmap
//import tpc.UIKit.component_interop.LengthMetricsUnit
import ohos.image.*
import ohos.base.BusinessException

import encoding.base64.*

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
          var pixelMap: ?PixelMap= None
//          if (img) {
            //DecodingOptions
                pixelMap = img.createPixelMap(options: DecodingOptions(editable: false, desiredSize: Size (height:info.size.width,width:info.size.height)))
                img.Release()
//                var bitmap = ImageBitmap(pixelMap.getOrThrow(), LengthMetricsUnit.PX)
                pixelMap?.Release()
                pixelMap = None
//                workerPort.postMessage({
//                  key,
//                  bitmap,
//                })
//          } else {
//            workerPort.postMessage({
//              key,
//              bitmap: null,
//            })
//          }
        }else {

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
