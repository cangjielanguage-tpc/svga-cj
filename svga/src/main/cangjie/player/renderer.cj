/**
 * Created on 2025/2/5
 */
package svga.player


import tpc.ImageKit.image.*
import tpc.UIKit.component_interop.*
import svga.proto.*
import svga.parser.*
import std.collection.*


var validMethods = 'MLHVCSQAZmlhvcsqaz'

public class Renderer {
  private var owner: Player
  private var unDrawFrame: ?Float64 = Option<Float64>.None;
  private var dynamicImage: HashMap<String, image.ImageSource> = HashMap<String, image.ImageSource>()
  private var bitmapCache: HashMap<String, ImageBitmap> = HashMap<String, ImageBitmap>()
  private var soundsQueue: Array<SoundsItem> = [];
  private var lastShape: HashMap<Float64, ShapeEntity> = HashMap<Float64, ShapeEntity>()
  init(owner: Player) {
    this.owner = owner
  }

  private var _prepared: Bool = false

  public func getprepared(): Bool {
    return this._prepared
  }
    /**
   * 渲染
   */
  public func prepare() {
    this.lastShape.clear()

    this._prepared = false
    this.bitmapCache.clear()

    if (this.owner.videoItem.isNone() || Object.keys(this.owner.videoItem?.images).length == 0) {
      this.bitmapCache.clear()
      this._prepared = true
      return;
    }
    let promiseArr: Array<Bool> = []
    let decodeCb: DecodeCbFn = {data: MockWorkerDecodeResponseData =>
      let key: String = data.key
      let bitmap: ?PixelMap = data.bitmap
      let fd: ?Float64 = data.fd
      // 处理图片
      if (bitmap.isSome()) {
        this.bitmapCache.put(key, ImageBitmap(bitmap.getOrThrow(), LengthMetricsUnit.PX))
        bitmap.getOrThrow().release
      }
      if (this.dynamicImage.get(key)) {
        let dynamicImage = this.dynamicImage.get(key)
        this.handleDynamicImage(dynamicImage!, key)
      }
      // 处理音频
      if (fd.isSome() && fd.getOrThrow() > -1.0) {
        const player = AVPlayerClass()
        this.bitmapCache.put(key, player)
        promiseArr.push(player.init(`fd://${fd}`))
      }
      if (this.owner.videoItem &&
        this.bitmapCache.size === Object.keys(this.owner.videoItem?.images || new Object({})).length) {
        if (promiseArr.length) {
          Promise.all(promiseArr).then(res => {
            console.timeLog('准备资源总耗时', '准备资源 end')
            promiseArr = []
            this._prepared = true
            if (typeof this.unDrawFrame === "number") {
              this.drawFrame(this.unDrawFrame);
              this.unDrawFrame = undefined;
            }
          }).catch(() => {
            console.timeLog('准备资源总耗时', '准备资源 end')

            promiseArr = []
            this._prepared = true
            if (typeof this.unDrawFrame === "number") {
              this.drawFrame(this.unDrawFrame);
              this.unDrawFrame = undefined;
            }
          })
        } else {
          this._prepared = true
          console.timeLog('准备资源总耗时', '准备资源 end')

          if (typeof this.unDrawFrame === "number") {
            this.drawFrame(this.unDrawFrame);
            this.unDrawFrame = undefined;
          }
        }
      }
    }

    if (this.bitmapCache.size == 0) {
    var keys: EquatableCollection<String> = this.owner.videoItem!.images.keys()
      //console.time('准备资源总耗时')
      //console.timeLog('准备资源总耗时', '准备资源 start')
      for(key in keys) {
        let src: String = this.owner.videoItem!.images![key]
        if (src.indexOf("iVBO") == 0 || src.indexOf("/9j/2w") == 0) {
          let bitmapKey = key.replace('.matte', '')
          actions.decode(bitmapKey, src, 'img', "", decodeCb)
        } else if (src.indexOf('SUQz') == 0) {
          // 音频
          actions.decode(key, src, 'audio', this.owner.sourceManager.basePath, decodeCb)
        }
      }
    }
  }
}

public abstract class SoundsItem {
//  var player: AVPlayerClass
//  var endFrame: number
}
