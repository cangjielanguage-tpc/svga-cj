/**
 * Created on 2025/2/11
 */
package ohos_app_cangjie_entry.pages

import tpc.UIKit.*
import tpc.ImageKit.image
import tpc.LocalizationKit.resourceManager.ResourceManager
import ohos.hybrid_base.*
import ohos.state_macro_manage.*
import tpc.UIKit.component_interop.*

@Component
class Demo {
    @State
    var message: String = 'PixelMapToBase64';
    @State
    var base64: String = '';

    func build() {
        Row() {
            Column() {
                Text(this.message)
                    .fontSize(50)
                    .fontWeight(FontWeight.Bold)
                    .onClick {
                        event =>
//                        let resourceManager: ResourceManager =  ResourceManager.getOverrideResourceManager() //= //getContext().resourceManager
//                        let imageArray = resourceManager.getMediaContent(1);//('app.media.startIcon')
//                        let pixelBuffer = imageArray
//                        let imageResource = image.createImageSource(pixelBuffer);
//                        let opts: image.DecodingOptions = image.DecodingOptions(editable: true)
//                        let pixelMap = imageResource.createPixelMap(options: opts);
//
                        // 转换成base64
                        var imagePackerApi: image.ImagePacker = image.createImagePacker();
                        let packOpts: image.PackingOption = image.PackingOption('image/jpeg', 100)
//                                    imagePackerApi.packing(pixelMap, packOpts).then( data => {
//                                      let buf: buffer.Buffer = buffer.from(data);
//                                      this.base64 = 'data:image/jpeg;base64,' + buf.toString('base64', 0, buf.length);
//                                      console.info('base64: ' + this.base64);
//                                    }).catch((err: Exception) => {
//                                      //console.log('base: ' + err.message)
//                                    }

                    }
                Image(this.base64).width(200).height(200).margin(15)
            }.width('100%')
        }.height('100%')
    }
}
