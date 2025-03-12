/**
 * Created on 2025/2/5
 */
package svga.player

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
    private var bitmapCache: HashMap<String, PixelMap> = HashMap<String, PixelMap>()
    private var soundsQueue: ArrayList<SoundsItem> = ArrayList<SoundsItem>();
    private var lastShape: HashMap<Int64, ShapeEntity> = HashMap<Int64, ShapeEntity>()
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
        if (this.owner.videoItem().isNone() || this
            .owner
            .videoItem()
            .getOrThrow()
            .images
            .size == 0) {
            this.bitmapCache.clear()
            this._prepared = true
            return;
        }
        let promiseArr: ArrayList<Bool> = ArrayList<Bool>()
        let decodeCb: DecodeCbFn = {
            data: MockWorkerDecodeResponseData =>
            let key: String = data.key
            let bitmap = data.bitmap
            //            let bitmap: ?PixelMap = data.bitmap
            let fd: ?Int32 = data.fd
            // 处理图片
            if (bitmap.isSome()) {
                //                this.bitmapCache.put(key, ImageBitmap(bitmap.getOrThrow(), LengthMetricsUnit.PX))
                //                bitmap.getOrThrow().release
            }
            if (this.dynamicImage.get(key).isSome()) {
                let dynamicImage = this.dynamicImage.get(key)
                this.handleDynamicImage(dynamicImage, key)
            }
            // 处理音频
            if (fd.isSome() && fd.getOrThrow() > 0) {
                var player = AVPlayerClass()
                //                        this.bitmapCache.put(key, player)
                //                        promiseArr.append(player(`fd://${fd}`))
            }
            if (this.owner.videoItem().isSome() && this.bitmapCache.size == this
                .owner
                .videoItem()
                .getOrThrow()
                .images
                .keys()
                .size) {
                if (promiseArr.size > 0) {
                //                          Promise.all(promiseArr).then(res => {
                //                            console.timeLog('准备资源总耗时', '准备资源 end')
                //                            promiseArr = []
                //                            this._prepared = true
                //                            if (typeof this.unDrawFrame === "number") {
                //                              this.drawFrame(this.unDrawFrame);
                //                              this.unDrawFrame = undefined;
                //                            }
                //                          }).catch(() => {
                //                            console.timeLog('准备资源总耗时', '准备资源 end')
                //
                //                            promiseArr = []
                //                            this._prepared = true
                //                            if (typeof this.unDrawFrame === "number") {
                //                              this.drawFrame(this.unDrawFrame);
                //                              this.unDrawFrame = undefined;
                //                            }
                //                          })
                } else {
                    this._prepared = true
                    //console.timeLog('准备资源总耗时', '准备资源 end')

                    if (this.unDrawFrame.isSome()) {
                        this.drawFrame(this.unDrawFrame.getOrThrow());
                        this.unDrawFrame = None
                    }
                }
            }
        }

        if (this.bitmapCache.size == 0) {
            var keys: EquatableCollection<String> = this
                .owner
                .videoItem()
                .getOrThrow()
                .images
                .keys()
            //console.time('准备资源总耗时')
            //console.timeLog('准备资源总耗时', '准备资源 start')
            for (key in keys) {
                let src: String = this
                    .owner
                    .videoItem()
                    .getOrThrow()
                    .images
                    .get(key)
                    .toString()
                if (src.indexOf("iVBO") == 0 || src.indexOf("/9j/2w") == 0) {
                    let bitmapKey = key.replace('.matte', '')
                    MockWorker.decode(bitmapKey, src, "img", "", decodeCb, Option<FailureFn>.None)
                } else if (src.indexOf('SUQz') == 0) {
                    // 音频
                    //actions.decode(key, src, 'audio', this.owner.sourceManager.basePath, decodeCb)
                }
            }
        }
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
        //        this
        //            .owner
        //            .context2D()?
        //            .clearRect(0, 0, Int64(this.owner.context2D().getOrThrow().width),
        //                Int64(this.owner.context2D().getOrThrow().height))
    }

    public func release() {
        //console.log('执行了清理2')
        for (it in this.soundsQueue) {
            it.player.release()
        }
        this.soundsQueue = ArrayList<SoundsItem>()
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
        this.soundsQueue = ArrayList<SoundsItem>()
    }

    public func drawFrame(frame: Float64) {
        //        if (this._prepared) {
        //            this.clear()
        //            if (this.owner.context2D().isNone()) {
        //                return;
        //            }
        //            var ctx = this.owner.context2D().getOrThrow()
        //            let matteSprites = HashMap<String, SpriteEntity>();
        //            var isMatting = false
        //            let sprites = this.owner.videoItem()?.sprites
        //            if (let Some(sprites) <- sprites) {
        //                var index = 0
        //                for (sprite in sprites) {
        //                    if (sprites[0].imageKey.indexOf('.matte').isNone()) {
        //                        this.drawSprite(sprite, ctx, frame, index)
        //                        return;
        //                    }
        //                    if (sprite.imageKey.indexOf('.matte').isSome()) {
        //                        matteSprites.put(sprite.imageKey, sprite)
        //                        return;
        //                    }
        //                    var lastSprite = sprites[index - 1];
        //                    if (isMatting && (sprite.matteKey.isEmpty() || sprite.matteKey != lastSprite.matteKey)) {
        //                        isMatting = false
        //                        let matteSprite = matteSprites.get(sprite.matteKey).getOrThrow()
        //                        ctx.globalCompositeOperation = "destination-in"
        //                        this.drawSprite(matteSprite, ctx, frame, index)
        //                        ctx.globalCompositeOperation = "source-over"
        //                        ctx.restore()
        //                    }
        //                    if (!sprite.matteKey.isEmpty() && ((lastSprite.matteKey.isEmpty()) || lastSprite.matteKey != sprite
        //                        .matteKey)) {
        //                        isMatting = true
        //                        ctx.save()
        //                    }
        //                    this.drawSprite(sprite, ctx, frame, index)
        //                    if (isMatting && index == sprites.size - 1) {
        //                        let matteSprite = matteSprites.get(sprite.matteKey).getOrThrow()
        //                        ctx.globalCompositeOperation = "destination-in"
        //                        this.drawSprite(matteSprite, ctx, frame, index);
        //                        ctx.globalCompositeOperation = "source-over"
        //                        ctx.restore();
        //                    }
        //                }
        //            }
        //        } else {
        //            this.unDrawFrame = frame
        //        }
    }

    public func playAudio(frame: Float64) {
        if (this.owner.forwardAnimating()) {
            for (audio in this.owner.videoItem().getOrThrow().audios) {
                if (this.bitmapCache.size == 0) {
                    return;
                }
                if ((audio.startFrame != 0 || audio.startFrame == Int32(frame)) && this
                    .bitmapCache
                    .contains(audio.audioKey) && this.bitmapCache.get(audio.audioKey).isSome()) {
                    var item: SoundsItem = SoundsItem(
                        (this.bitmapCache.get(audio.audioKey).getOrThrow() as AVPlayerClass).getOrThrow(),
                        Float64(audio.endFrame)
                    )
                    item.player.play()
                    item.player.seek(audio.startTime / 1000)
                    //console.log('audio触发了：播放')
                    this.soundsQueue.append(item)
                }
            }
            var deleted = false

            for (it in this.soundsQueue) {
                if (frame >= it.endFrame) {
                    deleted = true
                    it.player.stop()
                    //console.log('audio触发了：回收333')
                }
            }
            if (deleted) {
                var newsoundsQueue = ArrayList<SoundsItem>()
                for (it in this.soundsQueue) {
                    if (frame > it.endFrame) {
                        newsoundsQueue.append(it)
                    }
                }
                this.soundsQueue = newsoundsQueue
            }
        }
    }

    private func drawSprite(sprite: SpriteEntity, ctx: CanvasRenderingContext2D, _: Float64, index: Int64) {
        if (sprite.frames.size == 0) {
            return;
        }
        if (sprite.frames[Int64(this.owner.currentFrame())].alpha < 0.05) {
            return;
        }
        ctx.save()
        if (let Some(globalTransform) <- this.owner.globalTransform()) {
            ctx.transform(
                Float64(globalTransform.a),
                Float64(globalTransform.b),
                Float64(globalTransform.c),
                Float64(globalTransform.d),
                Float64(globalTransform.tx),
                Float64(globalTransform.ty),
            )
        }
        ctx.globalAlpha(Float64(sprite.frames[Int64(this.owner.currentFrame())].alpha))
        let transform = sprite.frames[Int64(this.owner.currentFrame())].transform
        let a = transform.a
        ctx.transform(
            Float64(transform.a),
            Float64(transform.b),
            Float64(transform.c),
            Float64(transform.d),
            Float64(transform.tx),
            Float64(transform.ty)
        )
        let bitMapKey = sprite.imageKey.replace('.matte', '');
        //                    if (!bitMapKey.isEmpty()) {
        //                      return;
        //                    }
        let src: ImageBitmap = (this.bitmapCache.get(bitMapKey)).getOrThrow()
        //                        //(this.owner.videoItem!.images![bitMapKey])
        //                    if (src.isNone()) {
        //                      return;
        //                    }
        if (src is Object) {
            let clipPath = sprite.frames[Int64(this.owner.currentFrame())].clipPath
            if (clipPath.size > 0) {
                let maskPath = BezierPath(clipPath, Option<Transform>.None, Option<ShapeEntity_ShapeStyle>.None);
                this.drawBezier(ctx, maskPath)
                ctx.clip()
            }
            if (this.owner.dynamicImageTransform().contains(sprite.imageKey) &&
                this.owner.dynamicImageTransform().get(sprite.imageKey).isSome()) {
                ctx.save()
                var concatTransform = this.owner.dynamicImageTransform().get(sprite.imageKey).getOrThrow()
                ctx.transform(Float64(concatTransform.a), Float64(concatTransform.b), Float64(concatTransform.c),
                    Float64(concatTransform.d), Float64(concatTransform.tx), Float64(concatTransform.ty))
            }
            if (src is AVPlayerClass) {
            } else {
                ctx.drawImage(src, 0.0, 0.0, src.width, src.height)
                if (this.owner.dynamicImageTransform().contains(sprite.imageKey) &&
                    this.owner.dynamicImageTransform().get(sprite.imageKey).isSome()) {
                    ctx.restore()
                }
            }
        } else if (src is String) {
            // 沙箱路径
            let clipPath = sprite.frames[Int64(this.owner.currentFrame())].clipPath
            if (clipPath.size > 0) {
                let maskPath = BezierPath(clipPath, Option<Transform>.None, Option<ShapeEntity_ShapeStyle>.None);
                this.drawBezier(ctx, maskPath)
                ctx.clip()
            }
            if (this.owner.dynamicImageTransform().contains(sprite.imageKey) &&
                this.owner.dynamicImageTransform().get(sprite.imageKey).isSome()) {
                ctx.save()
                var concatTransform = this.owner.dynamicImageTransform().get(sprite.imageKey).getOrThrow()
                ctx.transform(Float64(concatTransform.a), Float64(concatTransform.b), Float64(concatTransform.c),
                    Float64(concatTransform.d), Float64(concatTransform.tx), Float64(concatTransform.ty))
            }
            //            var img = ImageBitmap('file://' + "src", LengthMetricsUnit.PX)
            var img = ImageBitmap('file://' + "src", 1, 1)
            ctx.drawImage(img, 0.0, 0.0)
            //            img.close()
            if (this.owner.dynamicImageTransform().contains(sprite.imageKey) &&
                this.owner.dynamicImageTransform().get(sprite.imageKey).isSome()) {
                ctx.restore()
            }
        }
        //
        for (shape in sprite.frames[Int64(this.owner.currentFrame())].shapes) {
            //            sprite.frames[this.owner.currentFrame].shapes!.forEach(shape => {
            if (shape.type_ == ShapeEntity_ShapeType.KEEP && this.lastShape.contains((index)) &&
                this.lastShape.get((index)).isSome()) {
                //this.shape = this.lastShape.get(index)!
            }
            //
            if (shape.type_ == ShapeEntity_ShapeType.SHAPE) {
                this.lastShape.put(index, shape)
                var shapeArgs = shape.shape;
                this.drawBezier(ctx, BezierPath(shapeArgs.d, shape.transform, shape.styles))
            }
            if (shape.type_ == ShapeEntity_ShapeType.ELLIPSE) {
                this.lastShape.put(index, shape)
                var ellipseArgs = shape.ellipse;
                this.drawEllipse(
                    ctx,
                    EllipsePath(Float64((ellipseArgs.x)), Float64(ellipseArgs.y), Float64(ellipseArgs.radiusX),
                        Float64(ellipseArgs.radiusY), shape.transform, shape.styles)
                )
            }
            if (shape.type_ == ShapeEntity_ShapeType.RECT) {
                this.lastShape.put(index, shape)
                var rectArgs = shape.rect;
                this.drawRect(
                    ctx,
                    RectPath(Float64(rectArgs.x), Float64(rectArgs.y), Float64(rectArgs.width), Float64(rectArgs.height),
                        Float64(rectArgs.cornerRadius), shape.transform, shape.styles)
                )
            }
        }
        let dynamicText = this.owner.dynamicText().get(sprite.imageKey)
        if (let Some(dynamicText) <- dynamicText) {
            ctx.textBaseline(TextBaseline.Middle)
            //            ctx.font = dynamicText.style.getOrThrow()
            let textWidth = ctx.measureText(dynamicText.text).width
            //ctx.fillStyle(dynamicText.color.getOrThrow())
            let offsetX = 0.0 //(dynamicText.offset.isSome()) ?

            //                isNaN(parseFloat(dynamicText.offset.x.toString())) ? 0 : parseFloat(dynamicText.offset.x.toString()) : 0;
            let offsetY = 0.0 //(dynamicText.offset !== undefined && dynamicText.offset.y !== undefined) ?

            //                isNaN(parseFloat(dynamicText.offset.y.toString())) ? 0 : parseFloat(dynamicText.offset.y.toString()) : 0;
            ctx.fillText(
                dynamicText.text,
                (Float64(sprite.frames[Int64(this.owner.currentFrame())].layout.width) - textWidth) / 2.0 + offsetX,
                Float64(sprite.frames[Int64(this.owner.currentFrame())].layout.height) / 2.0 + offsetY
            );
        }
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
            case ShapeEntity_ShapeStyle_LineCap.LineCap_BUTT => ctx.lineCap(LineCapStyle.Butt)
            case ShapeEntity_ShapeStyle_LineCap.LineCap_ROUND => ctx.lineCap(LineCapStyle.Round)
            case ShapeEntity_ShapeStyle_LineCap.LineCap_SQUARE => ctx.lineCap(LineCapStyle.Square)
            case _ => ()
        }
        match (styles.lineJoin) {
            case ShapeEntity_ShapeStyle_LineJoin.LineJoin_MITER => ctx.lineJoin(LineJoinStyle.Miter)
            case ShapeEntity_ShapeStyle_LineJoin.LineJoin_ROUND => ctx.lineJoin(LineJoinStyle.Round)
            case ShapeEntity_ShapeStyle_LineJoin.LineJoin_BEVEL => ctx.lineJoin(LineJoinStyle.Bevel)
            case _ => ()
        }
        ctx.miterLimit(Float64(styles.miterLimit))

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

        //        ctx.setLineDash(lineDash.toArray());
        ctx.lineDash(lineDash.toArray());
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
                    options: DecodingOptions(editable: false,
                        desiredSize: imageSize(height: Int32(width), width: Int32(height))))
                imageSource.Release()
                //                bitmap = ImageBitmap(pixelMap.getOrThrow(), LengthMetricsUnit.PX)
                //                pixelMap.getOrThrow().release
                //                pixelMap = None
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
