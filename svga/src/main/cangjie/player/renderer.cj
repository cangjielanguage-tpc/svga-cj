/**
 * Created on 2025/2/5
 */
package svga.player

//import ohos.base.Color
//import ohos.advertising.advertising.ValueType
import tpc.ImageKit.image.PixelMap
import tpc.ImageKit.image.ImageSource
import tpc.ImageKit.image.createImageSource
import tpc.ImageKit.image.DecodingOptions
import tpc.ImageKit.image.Size as Sizes

import svga.proto.*
import svga.parser.*
import svga.parser.EllipsePath
import svga.parser.RectPath
import svga.audio.*
import std.collection.*
import std.convert.*
import std.regex.Regex

var validMethods = 'MLHVCSQAZmlhvcsqaz'


public class Renderer {
    private var owner: Player
    private var unDrawFrame: ?Float64 = Option<Float64>.None;
    private var dynamicImage: HashMap<String, ImageSource> = HashMap<String, ImageSource>()
    public var bitmapCache: HashMap<String, PixelMap> = HashMap<String, PixelMap>()
    public var avplayerCache: HashMap<String, AVPlayerClass> = HashMap<String, AVPlayerClass>()
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
        var promiseArr: ArrayList<Bool> = ArrayList<Bool>()

        if (this.bitmapCache.size == 0) {
            var keys: EquatableCollection<String> = this
                .owner
                .videoItem()
                .getOrThrow()
                .images
                .keys()
            for (key in keys) {
                let src = this
                    .owner
                    .videoItem()
                    .getOrThrow()
                    .images
                    .get(key)
                    .getOrThrow()
                    .toArray()
                try {
                    var img = createImageSource(src)
                    var info = img.getImageInfo()
                    let pixelMap: PixelMap = img.createPixelMap()
                    let bitmapKey = key.replace('.matte', '')
                    this.bitmapCache.put(bitmapKey, pixelMap)
                    if (this.dynamicImage.get(bitmapKey).isSome()) {
                        let dynamicImage = this.dynamicImage.get(bitmapKey)
                        this.handleDynamicImage(dynamicImage.getOrThrow(), bitmapKey)
                    }
                } catch (e: Exception) {
                    // var player = AVPlayerClass()
                    // this.avplayerCache.add(key, player)
                    // continue
                }
            }
        }
        if (this.bitmapCache.size == this
            .owner
            .videoItem()
            .getOrThrow()
            .images
            .keys()
            .size) {
            if (promiseArr.size != 0) {
                try {
                    promiseArr = ArrayList<Bool>()
                    this._prepared = true
                    if (this.unDrawFrame.isSome()) {
                        this.drawFrame(this.unDrawFrame.getOrThrow());
                        this.unDrawFrame = None
                    }
                } catch (e: Exception) {
                    promiseArr = ArrayList<Bool>()
                    this._prepared = true
                    if (this.unDrawFrame.isSome()) {
                        this.drawFrame(this.unDrawFrame.getOrThrow());
                        this.unDrawFrame = None
                    }
                }
            } else {
                this._prepared = true

                if (this.unDrawFrame.isSome()) {
                    this.drawFrame(this.unDrawFrame.getOrThrow());
                    this.unDrawFrame = None
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
        this
            .owner
            .context2D()?
            .clearRect(0, 0, Int64(this.owner.context2D().getOrThrow().width),
                Int64(this.owner.context2D().getOrThrow().height))
    }

    public func release() {
        for (it in this.soundsQueue) {
            it.player.release()
        }
        this.soundsQueue = ArrayList<SoundsItem>()
        try {
            for ((k, v) in this.bitmapCache) {
                v.release({a,b=>})
            }
            this.bitmapCache.clear()
        } catch (error: Exception) {
        }
        this.lastShape.clear()
        for ((k, v) in this.dynamicImage) {
            v.release({a,b=>})
        }
    }

    public func clearAudios() {
        for (it in this.soundsQueue) {
            it.player.stop()
        }
        this.soundsQueue = ArrayList<SoundsItem>()
    }

    public func drawFrame(frame: Float64) {
        if (this._prepared) {
            this.clear()
            if (this.owner.context2D().isNone()) {
                return;
            }
            var ctx = this.owner.context2D().getOrThrow()
            let matteSprites = HashMap<String, SpriteEntity>();
            var isMatting = false
            let sprites = this.owner.videoItem()?.sprites
            if (let Some(sprites) <- sprites) {
                var index = 0
                for (sprite in sprites) {
                    this.drawSprite(sprite, ctx, frame, index)
                }
            }
        } else {
            this.unDrawFrame = frame
        }
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
                    this.soundsQueue.append(item)
                }
            }
            var deleted = false

            for (it in this.soundsQueue) {
                if (frame >= it.endFrame) {
                    deleted = true
                    it.player.stop()
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
        ctx.globalAlpha = (Float64(sprite.frames[Int64(this.owner.currentFrame())].alpha))
        let transform = sprite.frames[Int64(this.owner.currentFrame())].transform
        let a = transform.a
        ctx.transform(
            {
                => if (Float64(transform.a) == 0.0) {
                    return 1.0
                } else {
                    return Float64(transform.a)
                }
            }(),
            Float64(transform.b),
            Float64(transform.c),
            {
                => if (Float64(transform.d) == 0.0) {
                    return 1.0
                } else {
                    return Float64(transform.d)
                }
            }(),
            Float64(transform.tx),
            Float64(transform.ty)
        )
        let bitMapKey = sprite.imageKey.replace('.matte', '');

        let src = (this.bitmapCache.get(bitMapKey))

        if (let Some(src) <- src) {
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
                    ctx.drawImage(src, 0.0, 0.0)
                    if (this.owner.dynamicImageTransform().contains(sprite.imageKey) &&
                        this.owner.dynamicImageTransform().get(sprite.imageKey).isSome()) {
                        ctx.restore()
                    }
                }
            }
        }

        for (shape in sprite.frames[Int64(this.owner.currentFrame())].shapes) {
            if (shape.type_ == ShapeEntity_ShapeType.SHAPE) {
                var shapeArgs = shape.shape;
                this.drawBezier(ctx, BezierPath(shapeArgs.d, shape.transform, shape.styles))
            }
            if (shape.type_ == ShapeEntity_ShapeType.ELLIPSE) {
                var ellipseArgs = shape.ellipse;
                this.drawEllipse(
                    ctx,
                    EllipsePath(Float64((ellipseArgs.x)), Float64(ellipseArgs.y), Float64(ellipseArgs.radiusX),
                        Float64(ellipseArgs.radiusY), shape.transform, shape.styles)
                )
            }
            if (shape.type_ == ShapeEntity_ShapeType.RECT) {
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
            ctx.textBaseline = CanvasTextBaseline.middle
            ctx.font = dynamicText.style
            let textWidth = ctx.measureText(dynamicText.text).width
            let offsetX = 0.0 //(dynamicText.offset.isSome()) ?
            let offsetY = 0.0 //(dynamicText.offset !== undefined && dynamicText.offset.y !== undefined) ?
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
            return
        }
        let styles: ?ShapeEntity_ShapeStyle = obj.styles
        if (styles.isNone()) {
            return
        }
        if (!styles.getOrThrow().stroke.isEmpty()) {
            var r: Float32 = 0.0
            var g: Float32 = 0.0
            var b: Float32 = 0.0
            var a: Float32 = 0.0
//            if (styles.getOrThrow().stroke.r.isNormal()) {
                r = styles.getOrThrow().stroke.r * 255.0
//            }
//            if (styles.getOrThrow().stroke.g.isNormal()) {
                g = styles.getOrThrow().stroke.g * 255.0
//            }
//            if (styles.getOrThrow().stroke.b.isNormal()) {
                b = styles.getOrThrow().stroke.b * 255.0
//            }
//            if (styles.getOrThrow().stroke.a.isNormal()) {
                a = styles.getOrThrow().stroke.a
//            }
            ctx.strokeStyle(Color(UInt8(r), UInt8(g), UInt8(b), alpha: a))
        } else {
            ctx.strokeStyle(Color.TRANSPARENT)
        }
        var strokeWidth: Float32 = 0.0
//        if (styles.getOrThrow().strokeWidth.isNormal()) {
            strokeWidth = styles.getOrThrow().strokeWidth
//        }
        ctx.lineWidth(Float64(strokeWidth))

        match (styles.getOrThrow().lineCap) {
            case ShapeEntity_ShapeStyle_LineCap.LineCap_BUTT => ctx.lineCap = CanvasLineCap.butt
            case ShapeEntity_ShapeStyle_LineCap.LineCap_ROUND => ctx.lineCap = CanvasLineCap.round
            case ShapeEntity_ShapeStyle_LineCap.LineCap_SQUARE => ctx.lineCap = CanvasLineCap.square
            case _ => ()
        }
        match (styles.getOrThrow().lineJoin) {
            case ShapeEntity_ShapeStyle_LineJoin.LineJoin_MITER => ctx.lineJoin = (CanvasLineJoin.miter)
            case ShapeEntity_ShapeStyle_LineJoin.LineJoin_ROUND => ctx.lineJoin = (CanvasLineJoin.round)
            case ShapeEntity_ShapeStyle_LineJoin.LineJoin_BEVEL => ctx.lineJoin = (CanvasLineJoin.bevel)
            case _ => ()
        }
        var miterLimit: Float32 = 0.0
//        if (styles.getOrThrow().miterLimit.isNormal()) {
            miterLimit = styles.getOrThrow().miterLimit
//        }
        ctx.miterLimit = (Float64(miterLimit))
        if (!styles.getOrThrow().fill.isEmpty()) {
            var r: Float32 = 0.0
            var g: Float32 = 0.0
            var b: Float32 = 0.0
            var a: Float32 = 0.0
//            if (styles.getOrThrow().fill.r.isNormal()) {
                r = styles.getOrThrow().fill.r * 255.0
//            }
//            if (styles.getOrThrow().fill.g.isNormal()) {
                g = styles.getOrThrow().fill.g * 255.0
//            }
//            if (styles.getOrThrow().fill.b.isNormal()) {
                b = styles.getOrThrow().fill.b * 255.0
//            }
//            if (styles.getOrThrow().fill.a.isNormal()) {
                a = styles.getOrThrow().fill.a
//            }
            ctx.fillStyle(Color(UInt8(r), UInt8(g), UInt8(b), alpha: a))
        } else {
            ctx.fillStyle(Color.TRANSPARENT)
        }
        let lineDash: ArrayList<Float64> = ArrayList<Float64>()
//        if (styles.getOrThrow().lineDashI.isNormal()) {
            lineDash.append(Float64(styles.getOrThrow().lineDashI))
//        }
//        if (styles.getOrThrow().lineDashII.isNormal()) {
            lineDash.append(Float64(styles.getOrThrow().lineDashII))
//        }
//        if (styles.getOrThrow().lineDashIII.isNormal()) {
            lineDash.append(Float64(styles.getOrThrow().lineDashIII))
//        }
        ctx.setLineDash(lineDash.toArray());
    }

    private func drawBezier(ctx: CanvasRenderingContext2D, obj: BezierPath) {
        ctx.save();
        this.resetShapeStyles(ctx, obj);
        if (let Some(transform) <- obj.transform) {
            var a1 = Float64(transform.a)
            if (transform.a == 0.0) {
                a1 = 1.0
            }
            var d1 = Float64(transform.d)
            if (transform.d == 0.0) {
                d1 = 1.0
            }
            ctx.transform(a1, Float64(transform.b), Float64(transform.c), d1, Float64(transform.tx),
                Float64(transform.ty));
        }
        let currentPoint: CurrentPoint = CurrentPoint(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

        ctx.beginPath();
        var d: String = obj.d
        var tmps = HashSet<String>()
        if (let Some(v) <- Regex("[a-zA-Z]").matcher(d).findAll()) {
            for (sc in v) {
                tmps.put(sc.matchStr())
            }
        }
        let tmps1 = tmps.toArray()
        for (i in 0..tmps1.size) {
            d = d.replace(tmps1[i], "|||${tmps1[i]} ")
        }
        d = Regex(",").matcher(d).replaceAll(" ")
        var list = d.split('|||')
        for (segment in list) {
            if (segment.size == 0) {
                continue
            }
            var firstLetter = segment[0..1];
            if (let Some(v) <- validMethods.indexOf(firstLetter)) {
                if (v >= 0) {
                    var args = segment[1..].trimAscii().split(" ");
                    this.drawBezierElement(ctx, currentPoint, firstLetter, args);
                }
            }
        }
        if (obj.styles.isSome() && !obj.styles.getOrThrow().fill.isEmpty()) {
            ctx.fill();
        }
        if (obj.styles.isSome() && !obj.styles.getOrThrow().stroke.isEmpty()) {
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
            case 'Z' => ctx.closePath();
            case 'z' => ctx.closePath();
            case _ => ()
        }
    }

    private func drawEllipse(ctx: CanvasRenderingContext2D, obj: EllipsePath) {
        ctx.save();
        this.resetShapeStyles(ctx, obj)
        if (let Some(transform) <- obj.transform) {
            ctx.transform(
                Float64(transform.a),
                Float64(transform.b),
                Float64(transform.c),
                Float64(transform.d),
                Float64(transform.tx),
                Float64(transform.ty),
            )
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
        if (obj.styles.isSome() && !obj.styles.getOrThrow().fill.isEmpty()) {
            ctx.fill();
        }
        if (obj.styles.isSome() && !obj.styles.getOrThrow().stroke.isEmpty()) {
            ctx.stroke();
        }
        ctx.restore();
    }

    private func drawRect(ctx: CanvasRenderingContext2D, obj: RectPath) {
        ctx.save();
        this.resetShapeStyles(ctx, obj);
        if (let Some(transform) <- obj.transform) {
            var a = 1.0
            var b = 0.0
            var c = 0.0
            var d = 1.0
            var tx = 0.0
            var ty = 0.0
//            if (transform.a.isNormal()) {
                a = Float64(transform.a)
//            }
//            if (transform.b.isNormal()) {
                b = Float64(transform.b)
//            }
//            if (transform.c.isNormal()) {
                c = Float64(transform.c)
//            }
//            if (transform.d.isNormal()) {
                d = Float64(transform.d)
//            }
//            if (transform.tx.isNormal()) {
                tx = Float64(transform.tx)
//            }
//            if (transform.ty.isNormal()) {
                ty = Float64(transform.ty)
//            }
            ctx.transform(a, b, c, d, tx, ty)
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

        if (obj.styles.isSome() && !obj.styles.getOrThrow().fill.isEmpty()) {
            ctx.fill();
        }
        if (obj.styles.isSome() && !obj.styles.getOrThrow().stroke.isEmpty()) {
            ctx.stroke();
        }
        ctx.restore();
    }

    private func handleDynamicImage(imageSource: ?ImageSource, forKey: String) {
        let cachedBitmap = this.bitmapCache.get(forKey)
        if (let Some(bitmap) <- cachedBitmap) {
            let originBitmap = bitmap
            var imageInfo = originBitmap.getImageInfo()
            let dynamicImageBitmap: ?PixelMap = this.transformBase64str2Bitmap(imageSource,
                Float64(imageInfo.size.width), Float64(imageInfo.size.height))
            if (let Some(dynamicImageBitmap) <- dynamicImageBitmap) {
                this.bitmapCache.put(forKey, dynamicImageBitmap)
            }
        }
    }

    private func transformBase64str2Bitmap(imageSource: ?ImageSource, width: Float64, height: Float64): ?PixelMap {
        var bitmap: ?PixelMap = None
        DecodingOptions()
        try {
            if (let Some(imageSource) <- imageSource) {
                bitmap = imageSource.createPixelMap(
                    options: DecodingOptions(editable: false,
                        desiredSize: Sizes(Int32(width), Int32(height))))
                imageSource.release({a,b=>})
            }
        } catch (e: Exception) {
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
