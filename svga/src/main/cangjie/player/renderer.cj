/**
 * Created on 2025/2/5
 */
package svga.player

import tpc.ImageKit.image.*
import tpc.ImageKit.image.Size as imageSize
import tpc.UIKit.component_interop.*
import ohos.base.Color
import svga.proto.*
import svga.parser.*
import svga.parser.EllipsePath
import svga.parser.RectPath
import svga.audio.*
import std.collection.*
import std.convert.*

var validMethods = 'MLHVCSQAZmlhvcsqaz'

public class Renderer {
    private var owner: Player
    private var unDrawFrame: ?Float64 = Option<Float64>.None;
    private var dynamicImage: HashMap<String, ImageSource> = HashMap<String, ImageSource>()
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

        //    if (this.owner.videoItem.isNone() || Object.keys(this.owner.videoItem?.images).length == 0) {
        //      this.bitmapCache.clear()
        //      this._prepared = true
        //      return;
        //    }
        //    let promiseArr: ArrayList<Bool> = ArrayList<Bool>()
        //    let decodeCb: DecodeCbFn = {data: MockWorkerDecodeResponseData =>
        //      let key: String = data.key
        //      let bitmap: ?PixelMap = data.bitmap
        //      let fd: ?Float64 = data.fd
        //      // 处理图片
        //      if (bitmap.isSome()) {
        //        this.bitmapCache.put(key, ImageBitmap(bitmap.getOrThrow(), LengthMetricsUnit.PX))
        //        bitmap.getOrThrow().release
        //      }
        //      if (this.dynamicImage.get(key)) {
        //        let dynamicImage = this.dynamicImage.get(key)
        //        this.handleDynamicImage(dynamicImage, key)
        //      }
        //      // 处理音频
        //      if (fd.isSome() && fd.getOrThrow() > -1.0) {
        //        var player = AVPlayerClass()
        //        this.bitmapCache.put(key, player)
        //        promiseArr.append(player(`fd://${fd}`))
        //      }
        //      if (this.owner.videoItem &&
        //        this.bitmapCache.size == this.owner.videoItem?.images.keys().length) {
        //        if (promiseArr.size>0) {
        //          Promise.all(promiseArr).then(res => {
        //            console.timeLog('准备资源总耗时', '准备资源 end')
        //            promiseArr = []
        //            this._prepared = true
        //            if (typeof this.unDrawFrame === "number") {
        //              this.drawFrame(this.unDrawFrame);
        //              this.unDrawFrame = undefined;
        //            }
        //          }).catch(() => {
        //            console.timeLog('准备资源总耗时', '准备资源 end')
        //
        //            promiseArr = []
        //            this._prepared = true
        //            if (typeof this.unDrawFrame === "number") {
        //              this.drawFrame(this.unDrawFrame);
        //              this.unDrawFrame = undefined;
        //            }
        //          })
        //        } else {
        //          this._prepared = true
        //          //console.timeLog('准备资源总耗时', '准备资源 end')
        //
        //          if (this.unDrawFrame.isSome()) {
        //            this.drawFrame(this.unDrawFrame.getOrThrow());
        //            this.unDrawFrame = None;
        //          }
        //        }
        //      }
        //    }

        //    if (this.bitmapCache.size == 0) {
        //    var keys: EquatableCollection<String> = this.owner.videoItem!.images.keys()
        //      //console.time('准备资源总耗时')
        //      //console.timeLog('准备资源总耗时', '准备资源 start')
        //      for(key in keys) {
        //        let src: String = this.owner.videoItem!.images![key]
        //        if (src.indexOf("iVBO") == 0 || src.indexOf("/9j/2w") == 0) {
        //          let bitmapKey = key.replace('.matte', '')
        //          actions.decode(bitmapKey, src, 'img', "", decodeCb)
        //        } else if (src.indexOf('SUQz') == 0) {
        //          // 音频
        //          actions.decode(key, src, 'audio', this.owner.sourceManager.basePath, decodeCb)
        //        }
        //      }
        //    }
    }

    /**
     * 暂停
     */
    public func pauseAudios() {
        for (it in this.soundsQueue) {
            it.player.pause()
        }
    }

    public func playAudios() {
        for (it in this.soundsQueue) {
            it.player.play()
        }
    }

    public func setDynamicImage(imageSource: ?ImageSource, forKey: String) {
        if (let Some(imageSource) <- imageSource) {
            this.dynamicImage.put(forKey, imageSource)
            this.handleDynamicImage(imageSource, forKey)
        }
    }

    /**
     * 清空画布
     */
    public func clear() {
        //this.owner.context2D?.clearRect(0, 0, this.owner.context2D.width, this.owner.context2D.height)
    }

    public func release() {
        //console.log('执行了清理2')
        for (it in this.soundsQueue) {
            it.player.release()
        }
        this.soundsQueue = []
        try {
            for (v in this.bitmapCache) {
                if (v is AVPlayerClass) {
                    (v as AVPlayerClass).getOrThrow().release()
                } else {
                    if (v is Object) {
                        // v.close()
                    }
                }
            }
            this.bitmapCache.clear()
        } catch (error: Exception) {
            //console.error('svga', error)
        }
        this.lastShape.clear()
    }

    public func clearAudios() {
        for (it in this.soundsQueue) {
            //console.log('audio触发了：回收')
            it.player.stop()
        }
        this.soundsQueue = []
    }

    public func drawFrame(frame: Float64) {
        if (this._prepared) {
        //      this.clear()
        //      const ctx = this.owner.context2D
        //      if (!ctx) {
        //        return;
        //      }
        //      let matteSprites = HashMap<String, SpriteEntity>();
        //      let isMatting = false
        //      let sprites = this.owner.videoItem?.sprites
        //      if (sprites && sprites.length > 0) {
        //        sprites.forEach((sprite, index) => {
        //          if (sprites![0].imageKey?.indexOf('.matte') == -1) {
        //            this.drawSprite(sprite, ctx, frame, index)
        //            return;
        //          }
        //          if (sprite.imageKey?.indexOf('.matte') != -1) {
        //            matteSprites.set(sprite.imageKey || '', sprite)
        //            return;
        //          }
        //          let lastSprite = sprites![index - 1];
        //          if (isMatting &&
        //            ((sprite.matteKey == null || sprite.matteKey?.length == 0) || sprite.matteKey != lastSprite.matteKey)) {
        //            isMatting = false
        //            let matteSprite = matteSprites.get(sprite.matteKey || '')
        //            ctx.globalCompositeOperation = "destination-in"
        //            this.drawSprite(matteSprite!, ctx, frame, index)
        //            ctx.globalCompositeOperation = "source-over";
        //            ctx.restore()
        //          }
        //          if (sprite.matteKey != null && sprite.matteKey.length !== 0 &&
        //            ((lastSprite.matteKey == null || lastSprite.matteKey.length == 0) ||
        //              lastSprite.matteKey != sprite.matteKey)) {
        //            isMatting = true
        //            ctx.save()
        //          }
        //          this.drawSprite(sprite, ctx, frame, index)
        //          if (isMatting && index == sprites!.length - 1) {
        //            let matteSprite = matteSprites.get(sprite.matteKey || '');
        //            ctx.globalCompositeOperation = "destination-in";
        //            this.drawSprite(matteSprite!, ctx, frame, index);
        //            ctx.globalCompositeOperation = "source-over";
        //            ctx.restore();
        //          }
        //        })
        //      }
        } else {
            this.unDrawFrame = frame
        }
    }

    public func playAudio(frame: Float64) {
        //    if (this.owner.forwardAnimating && this.owner.videoItem?.audios instanceof Array) {
        //      this.owner.videoItem?.audios?.forEach(audio => {
        //        if (!this.bitmapCache.size) {
        //          return;
        //        }
        //        if ((!audio.startFrame || audio.startFrame === frame) &&
        //        this.bitmapCache.has(audio.audioKey) &&
        //          this.bitmapCache.get(audio.audioKey) !== undefined &&
        //          this.bitmapCache.get(audio.audioKey) instanceof AVPlayerClass) {
        //          const item: SoundsItem = {
        //            player: this.bitmapCache.get(audio.audioKey!) as AVPlayerClass,
        //            endFrame: audio.endFrame || 0,
        //          }
        //          item.player.play()
        //          // item.player.seek(audio.startTime / 1000)
        //          console.log('audio触发了：播放')
        //          this.soundsQueue.push(item)
        //        }
        //      })
        //      let deleted = false
        //      this.soundsQueue.forEach(it => {
        //        if (frame >= it.endFrame) {
        //          deleted = true
        //          it.player.stop()
        //          console.log('audio触发了：回收333')
        //        }
        //      })
        //      if (deleted) {
        //        this.soundsQueue = this.soundsQueue.filter(it => frame < it.endFrame)
        //      }
        //    }
    }

    private func drawSprite(sprite: SpriteEntity, ctx: CanvasRenderingContext2D, _: Float64, index: Float64) {
        if (sprite.frames.size == 0) {
            return;
        }
        //    if (!sprite.frames[this.owner.currentFrame].alpha || sprite.frames[this.owner.currentFrame].alpha! < 0.05) {
        //      return;
        //    }
        //    ctx.save()
        //    if (this.owner.globalTransform) {
        //      ctx.transform(
        //        this.owner.globalTransform.a,
        //        this.owner.globalTransform.b,
        //        this.owner.globalTransform.c,
        //        this.owner.globalTransform.d,
        //        this.owner.globalTransform.tx,
        //        this.owner.globalTransform.ty,
        //      )
        //    }
        //    ctx.globalAlpha = sprite.frames[this.owner.currentFrame].alpha!
        //    ctx.transform(
        //      sprite.frames[this.owner.currentFrame].transform.a,
        //      sprite.frames[this.owner.currentFrame].transform.b,
        //      sprite.frames[this.owner.currentFrame].transform.c,
        //      sprite.frames[this.owner.currentFrame].transform.d,
        //      sprite.frames[this.owner.currentFrame].transform.tx,
        //      sprite.frames[this.owner.currentFrame].transform.ty,
        //    )
        //    let bitMapKey = sprite.imageKey.replace('.matte', '');
        //    if (!bitMapKey.isEmpty()) {
        //      return;
        //    }
        //    let src: string | ImageBitmap | AVPlayerClass =
        //      (this.bitmapCache ? this.bitmapCache.get(bitMapKey) : '') ||
        //        (this.owner.videoItem!.images![bitMapKey])
        //    if (src.isNone()) {
        //      return;
        //    }
        //    if (typeof src === 'object') {
        //      let clipPath = (sprite.frames[this.owner.currentFrame] as FrameEntity).clipPath
        //      if (clipPath && clipPath.length > 0) {
        //        let maskPath = new BezierPath(clipPath, undefined, {});
        //        this.drawBezier(ctx, maskPath)
        //        ctx.clip()
        //      }
        //      if (this.owner.dynamicImageTransform.has(sprite.imageKey!) &&
        //      this.owner.dynamicImageTransform.get(sprite.imageKey!)) {
        //        ctx.save()
        //        const concatTransform = this.owner.dynamicImageTransform.get(sprite.imageKey)!
        //        ctx.transform(concatTransform.a, concatTransform.b, concatTransform.c, concatTransform.d, concatTransform.tx,
        //          concatTransform.ty)
        //      }
        //      if (src instanceof AVPlayerClass) {
        //
        //      } else {
        //        ctx.drawImage(src, 0, 0, src.width, src.height)
        //        if (this.owner.dynamicImageTransform.has(sprite.imageKey!) &&
        //        this.owner.dynamicImageTransform.get(sprite.imageKey!)) {
        //          ctx.restore()
        //        }
        //      }
        //
        //    } else if (typeof src === 'string') {
        //      // 沙箱路径
        //      let clipPath = (sprite.frames[this.owner.currentFrame] as FrameEntity).clipPath
        //      if (clipPath && clipPath.length > 0) {
        //        let maskPath = new BezierPath(clipPath, undefined, {});
        //        this.drawBezier(ctx, maskPath)
        //        ctx.clip()
        //      }
        //      if (this.owner.dynamicImageTransform.has(sprite.imageKey!) &&
        //      this.owner.dynamicImageTransform.get(sprite.imageKey!)) {
        //        ctx.save()
        //        const concatTransform = this.owner.dynamicImageTransform.get(sprite.imageKey!)!
        //        ctx.transform(concatTransform.a, concatTransform.b, concatTransform.c, concatTransform.d, concatTransform.tx,
        //          concatTransform.ty)
        //      }
        //      const img = new ImageBitmap('file://' + src, LengthMetricsUnit.PX)
        //      ctx.drawImage(img, 0, 0)
        //      img.close()
        //      if (this.owner.dynamicImageTransform.has(sprite.imageKey!) &&
        //      this.owner.dynamicImageTransform.get(sprite.imageKey!)) {
        //        ctx.restore()
        //      }
        //    }
        //
        //    sprite.frames[this.owner.currentFrame].shapes &&
        //    sprite.frames[this.owner.currentFrame].shapes!.forEach(shape => {
        //      if (shape.typePb === ShapeType.KEEP && this.lastShape.has(index) && this.lastShape.get(index)) {
        //        shape = this.lastShape.get(index)!
        //      }
        //
        //      if (shape.typePb === ShapeType.SHAPE && shape.shape && shape.shape.d) {
        //        this.lastShape.set(index, shape)
        //        const shapeArgs = shape.shape;
        //        this.drawBezier(ctx, new BezierPath(shapeArgs.d, shape.transform || undefined, shape.styles || undefined))
        //      }
        //      if (shape.typePb === ShapeType.ELLIPSE && shape.ellipse) {
        //        this.lastShape.set(index, shape)
        //        const ellipseArgs = shape.ellipse;
        //        this.drawEllipse(ctx,
        //          new EllipsePath(parseFloat((ellipseArgs.x || 0).toString()), parseFloat((ellipseArgs.y || 0).toString()),
        //            parseFloat((ellipseArgs.radiusX || 0).toString()), parseFloat((ellipseArgs.radiusY || 0).toString()),
        //            shape.transform || undefined, shape.styles || undefined))
        //      }
        //      if (shape.typePb === ShapeType.RECT && shape.rect) {
        //        this.lastShape.set(index, shape)
        //        const rectArgs = shape.rect;
        //        this.drawRect(ctx,
        //          new RectPath(parseFloat((rectArgs.x || 0).toString()), parseFloat((rectArgs.y || 0).toString()),
        //            parseFloat((rectArgs.width || 0).toString()), parseFloat((rectArgs.height || 0).toString()),
        //            parseFloat((rectArgs.cornerRadius || 0).toString()), shape.transform || undefined,
        //            shape.styles || undefined))
        //      }
        //    })
        //    let dynamicText = this.owner.dynamicText.get(sprite.imageKey!)
        //    if (dynamicText !== undefined) {
        //      ctx.textBaseline = 'middle'
        //      ctx.font = dynamicText.style || `${fp2px(14)}px`
        //      let textWidth = ctx.measureText(dynamicText.text).width
        //      ctx.fillStyle = dynamicText.color || '#000'
        //      let offsetX = (dynamicText.offset !== undefined && dynamicText.offset.x !== undefined) ?
        //        isNaN(parseFloat(dynamicText.offset.x.toString())) ? 0 : parseFloat(dynamicText.offset.x.toString()) : 0;
        //      let offsetY = (dynamicText.offset !== undefined && dynamicText.offset.y !== undefined) ?
        //        isNaN(parseFloat(dynamicText.offset.y.toString())) ? 0 : parseFloat(dynamicText.offset.y.toString()) : 0;
        //      ctx.fillText(dynamicText.text,
        //        ((sprite.frames[this.owner.currentFrame].layout?.width || 0) - textWidth) / 2 + offsetX,
        //        (sprite.frames[this.owner.currentFrame].layout?.height || 0) / 2 + offsetY);
        //    }
        ctx.restore()
    }

    private func resetShapeStyles(ctx: CanvasRenderingContext2D, obj: BezierPath) {
        if (obj.styles.isNone()) {
            return;
        }
        var styles: ShapeEntity_ShapeStyle = obj.styles.getOrThrow();

        //    if (styles && styles.stroke) {
        ctx.strokeStyle(
            Color(UInt8(styles.stroke.r), UInt8(styles.stroke.g), UInt8(styles.stroke.b), alpha: styles.stroke.a))
        //    } else {
        //      ctx.strokeStyle = "transparent"
        //    }
        ctx.lineWidth(Float64(styles.strokeWidth))

        match (styles.lineCap) {
            case ShapeEntity_ShapeStyle_LineCap.LineCap_BUTT => ctx.lineCap = CanvasLineCap.butt
            case ShapeEntity_ShapeStyle_LineCap.LineCap_ROUND => ctx.lineCap = CanvasLineCap.round
            case ShapeEntity_ShapeStyle_LineCap.LineCap_SQUARE => ctx.lineCap = CanvasLineCap.square
            case _ => ()
        }
        match (styles.lineJoin) {
            case ShapeEntity_ShapeStyle_LineJoin.LineJoin_MITER => ctx.lineJoin = CanvasLineJoin.miter
            case ShapeEntity_ShapeStyle_LineJoin.LineJoin_ROUND => ctx.lineJoin = CanvasLineJoin.round
            case ShapeEntity_ShapeStyle_LineJoin.LineJoin_BEVEL => ctx.lineJoin = CanvasLineJoin.bevel
            case _ => ()
        }
        ctx.miterLimit = Float64(styles.miterLimit)

        ctx.fillStyle(Color(UInt8(styles.fill.r), UInt8(styles.fill.g), UInt8(styles.fill.b), alpha: styles.fill.a))
        //    if (styles && styles.fill) {
        //      ctx.fillStyle =
        //        `rgba(${parseInt(((styles.fill["r"] ?? 0) * 255).toString())}, ${parseInt(((styles.fill["g"] ?? 0) *
        //          255).toString())}, ${parseInt(((styles.fill["b"] ?? 0) * 255).toString())}, ${styles.fill["a"]})`
        //    } else {
        //      ctx.fillStyle = "transparent"
        //    }
        let lineDash: ArrayList<Float64> = ArrayList<Float64>()
        lineDash.append(Float64(styles.lineDashI))

        lineDash.append(Float64(styles.lineDashII))

        lineDash.append(Float64(styles.lineDashIII))

        ctx.setLineDash(lineDash.toArray());
    }

    private func drawBezier(ctx: CanvasRenderingContext2D, obj: BezierPath) {
        ctx.save();
        this.resetShapeStyles(ctx, obj);
        if (let Some(transform) <- obj.transform) {
            ctx.transform(Float64(transform.a), Float64(transform.b), Float64(transform.c), Float64(transform.d),
                Float64(transform.tx), Float64(transform.ty));
        }
        let currentPoint: CurrentPoint = CurrentPoint(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

        ctx.beginPath();
        var d: String = obj.d.replace("/([a-zA-Z])/g", '|||$1 ').replace("/,/g", ' '); //BUG
        var list = d.split('|||')
        for (segment in list) {
            if (segment.size == 0) {
                return;
            }
            var firstLetter = segment[0..1];
            if (validMethods.indexOf(firstLetter).getOrThrow() >= 0) {
                var args = segment[1..].trimAscii().split(" ");
                this.drawBezierElement(ctx, currentPoint, firstLetter, args);
            }
        }
        if (obj.styles.isSome()) {
            ctx.fill();
            ctx.stroke();
        }

        ctx.restore();
    }

    private func drawBezierElement(ctx: CanvasRenderingContext2D, currentPoint: CurrentPoint, method: String,
        args: Array<String>) {
        match (method) {
            case 'M' =>
                currentPoint.x = Float64.parse(args[0])
                currentPoint.y = Float64.parse(args[1])
                ctx.moveTo(currentPoint.x, currentPoint.y);
            case 'm' =>
                currentPoint.x += Float64.parse(args[0])
                currentPoint.y += Float64.parse(args[1])
                ctx.moveTo(currentPoint.x, currentPoint.y);
            case 'L' =>
                currentPoint.x = Float64.parse(args[0])
                currentPoint.y = Float64.parse(args[1])
                ctx.lineTo(currentPoint.x, currentPoint.y);
            case 'l' =>
                currentPoint.x += Float64.parse(args[0])
                currentPoint.y += Float64.parse(args[1])
                ctx.lineTo(currentPoint.x, currentPoint.y);
            case 'H' =>
                currentPoint.x = Float64.parse(args[0])
                ctx.lineTo(currentPoint.x, currentPoint.y);
            case 'h' =>
                currentPoint.x += Float64.parse(args[0])
                ctx.lineTo(currentPoint.x, currentPoint.y);
            case 'V' =>
                currentPoint.y = Float64.parse(args[0])
                ctx.lineTo(currentPoint.x, currentPoint.y);
            case 'v' =>
                currentPoint.y += Float64.parse(args[0])
                ctx.lineTo(currentPoint.x, currentPoint.y);
            case 'C' =>
                currentPoint.x1 = Float64.parse(args[0])
                currentPoint.y1 = Float64.parse(args[1])
                currentPoint.x2 = Float64.parse(args[2])
                currentPoint.y2 = Float64.parse(args[3])
                currentPoint.x = Float64.parse(args[4])
                currentPoint.y = Float64.parse(args[5])
                ctx.bezierCurveTo(currentPoint.x1, currentPoint.y1, currentPoint.x2, currentPoint.y2, currentPoint.x,
                    currentPoint.y);
            case 'c' =>
                currentPoint.x1 = currentPoint.x + Float64.parse(args[0])
                currentPoint.y1 = currentPoint.y + Float64.parse(args[1])
                currentPoint.x2 = currentPoint.x + Float64.parse(args[2])
                currentPoint.y2 = currentPoint.y + Float64.parse(args[3])
                currentPoint.x += Float64.parse(args[4])
                currentPoint.y += Float64.parse(args[5])
                ctx.bezierCurveTo(currentPoint.x1, currentPoint.y1, currentPoint.x2, currentPoint.y2, currentPoint.x,
                    currentPoint.y);
            case 'S' =>
                if (currentPoint.x1 != 0.0 && currentPoint.y1 != 0.0 && currentPoint.x2 != 0.0 && currentPoint.y2 != 0.0) {
                    currentPoint.x1 = currentPoint.x - currentPoint.x2 + currentPoint.x
                    currentPoint.y1 = currentPoint.y - currentPoint.y2 + currentPoint.y
                    currentPoint.x2 = Float64.parse(args[0])
                    currentPoint.y2 = Float64.parse(args[1])
                    currentPoint.x = Float64.parse(args[2])
                    currentPoint.y = Float64.parse(args[3])
                    ctx.bezierCurveTo(currentPoint.x1, currentPoint.y1, currentPoint.x2, currentPoint.y2, currentPoint.x,
                        currentPoint.y);
                } else {
                    currentPoint.x1 = Float64.parse(args[0])
                    currentPoint.y1 = Float64.parse(args[1])
                    currentPoint.x = Float64.parse(args[2])
                    currentPoint.y = Float64.parse(args[3])
                    ctx.quadraticCurveTo(currentPoint.x1, currentPoint.y1, currentPoint.x, currentPoint.y);
                }
            case 's' =>
                if (currentPoint.x1 != 0.0 && currentPoint.y1 != 0.0 && currentPoint.x2 != 0.0 && currentPoint.y2 != 0.0) {
                    currentPoint.x1 = currentPoint.x - currentPoint.x2 + currentPoint.x
                    currentPoint.y1 = currentPoint.y - currentPoint.y2 + currentPoint.y
                    currentPoint.x2 = currentPoint.x + Float64.parse(args[0])
                    currentPoint.y2 = currentPoint.y + Float64.parse(args[1])
                    currentPoint.x += Float64.parse(args[2])
                    currentPoint.y += Float64.parse(args[3])
                    ctx.bezierCurveTo(currentPoint.x1, currentPoint.y1, currentPoint.x2, currentPoint.y2, currentPoint.x,
                        currentPoint.y);
                } else {
                    currentPoint.x1 = currentPoint.x + Float64.parse(args[0])
                    currentPoint.y1 = currentPoint.y + Float64.parse(args[1])
                    currentPoint.x += Float64.parse(args[2])
                    currentPoint.y += Float64.parse(args[3])
                    ctx.quadraticCurveTo(currentPoint.x1, currentPoint.y1, currentPoint.x, currentPoint.y);
                }
            case 'Q' =>
                currentPoint.x1 = Float64.parse(args[0])
                currentPoint.y1 = Float64.parse(args[1])
                currentPoint.x = Float64.parse(args[2])
                currentPoint.y = Float64.parse(args[3])
                ctx.quadraticCurveTo(currentPoint.x1, currentPoint.y1, currentPoint.x, currentPoint.y);
            case 'q' =>
                currentPoint.x1 = currentPoint.x + Float64.parse(args[0])
                currentPoint.y1 = currentPoint.y + Float64.parse(args[1])
                currentPoint.x += Float64.parse(args[2])
                currentPoint.y += Float64.parse(args[3])
                ctx.quadraticCurveTo(currentPoint.x1, currentPoint.y1, currentPoint.x, currentPoint.y);
            case 'A' => ()
            case 'a' => ()
            case 'Z' => ()
            case 'z' => ctx.closePath();
            case _ => ()
        }
    }

    private func drawEllipse(ctx: CanvasRenderingContext2D, obj: EllipsePath) {
        ctx.save();
        this.resetShapeStyles(ctx, obj);
        if (let Some(transform) <- obj.transform) {
            ctx.transform(Float64(transform.a), Float64(transform.b), Float64(transform.c), Float64(transform.d),
                Float64(transform.tx), Float64(transform.ty));
        }
        let x = obj._x - obj._radiusX;
        let y = obj._y - obj._radiusY;
        let w = obj._radiusX * 2.0;
        let h = obj._radiusY * 2.0;
        let kappa = .5522848
        let ox = (w / 2.0) * kappa
        let oy = (h / 2.0) * kappa
        let xe = x + w
        let ye = y + h
        let xm = x + w / 2.0
        let ym = y + h / 2.0

        ctx.beginPath();
        ctx.moveTo(x, ym);
        ctx.bezierCurveTo(x, ym - oy, xm - ox, y, xm, y);
        ctx.bezierCurveTo(xm + ox, y, xe, ym - oy, xe, ym);
        ctx.bezierCurveTo(xe, ym + oy, xm + ox, ye, xm, ye);
        ctx.bezierCurveTo(xm - ox, ye, x, ym + oy, x, ym);
        if (obj.styles.isSome()) {
            ctx.fill();
        }
        if (obj.styles.isSome()) {
            ctx.stroke();
        }
        ctx.restore();
    }

    private func drawRect(ctx: CanvasRenderingContext2D, obj: RectPath) {
        ctx.save();
        this.resetShapeStyles(ctx, obj);
        if (let Some(transform) <- obj.transform) {
            ctx.transform(Float64(transform.a), Float64(transform.b), Float64(transform.c), Float64(transform.d),
                Float64(transform.tx), Float64(transform.ty));
        }

        let x = obj._x;
        let y = obj._y;
        let width = obj._width;
        let height = obj._height;
        var radius = obj._cornerRadius;

        if (width < 2.0 * radius) {
            radius = width / 2.0
        }
        if (height < 2.0 * radius) {
            radius = height / 2.0
        }

        ctx.beginPath();
        ctx.moveTo(x + radius, y);
        ctx.arcTo(x + width, y, x + width, y + height, radius);
        ctx.arcTo(x + width, y + height, x, y + height, radius);
        ctx.arcTo(x, y + height, x, y, radius);
        ctx.arcTo(x, y, x + width, y, radius);
        ctx.closePath();

        if (obj.styles.isSome()) {
            ctx.fill();
        }
        if (obj.styles.isSome()) {
            ctx.stroke();
        }
        ctx.restore();
    }

    private func handleDynamicImage(imageSource: ?ImageSource, forKey: String) {
        let cachedBitmap = this.bitmapCache.get(forKey)
        if (let Some(bitmap) <- cachedBitmap) {
            let originBitmap = bitmap
            let dynamicImageBitmap = this.transformBase64str2Bitmap(imageSource, originBitmap.width, originBitmap.height
            )
            if (let Some(dynamicImageBitmap) <- dynamicImageBitmap) {
                this.bitmapCache.put(forKey, dynamicImageBitmap)
            }
        }
    }

    private func transformBase64str2Bitmap(imageSource: ?ImageSource, width: Float64, height: Float64): ?ImageBitmap {
        var bitmap: ?ImageBitmap = None
        DecodingOptions()
        try {
            var pixelMap: ?PixelMap = None
            if (let Some(imageSource) <- imageSource) {
                pixelMap = imageSource.createPixelMap(
                    options: DecodingOptions(editable: false, desiredSize: imageSize(Int32(width), Int32(height))))
                imageSource.release
                bitmap = ImageBitmap(pixelMap.getOrThrow(), LengthMetricsUnit.PX)
                pixelMap.getOrThrow().release
                pixelMap = None
            }
        } catch (e: Exception) {
            //console.error('svga', 'transformBase64str2Bitmap err:' + e)
        }
        return bitmap
    }
}

public class CurrentPoint {
    var x: Float64 = 0.0
    var y: Float64 = 0.0
    var x1: Float64 = 0.0
    var y1: Float64 = 0.0
    var x2: Float64 = 0.0
    var y2: Float64 = 0.0

    public init(x: Float64, y: Float64, x1: Float64, y1: Float64, x2: Float64, y2: Float64) {
        this.x = x
        this.y = y
        this.x1 = x1
        this.y1 = y1
        this.x2 = x2
        this.y2 = y2
    }
}

public class SoundsItem {
    public var player: AVPlayerClass
    public var endFrame: Float64

    public init(player: AVPlayerClass, endFrame: Float64) {
        this.player = player
        this.endFrame = endFrame
    }
}
