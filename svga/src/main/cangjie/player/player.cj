/**
 * Created on 2025/1/14
 */
package svga.player

import tpc.UIKit.UIContext.*
import tpc.AbilityKit.*
import tpc.UIKit.component_interop.*
import tpc.ImageKit.image.*
import tpc.LocalizationKit.resourceManager.*
import tpc.UIKit.matrix4.identity
import tpc.UIKit.matrix4.TranslateOption
import tpc.UIKit.window.Size as Sizes
import tpc.UIKit.animator.*
import std.collection.*
import std.math.*
import svga.valueAnimator.*
import svga.proto.*
import svga.parser.*
import svga.model.*

public class Player {
    private var _onFinished: ?() -> Unit = None
    private var _onFrame: ?(Float64) -> Unit = None
    private var _onPercentage: ?(Float64) -> Unit = None
    // 倍率
    private var _speed: Int64 = 1
    private var _playerController: StateController

    public init(UIContext: UIContext, context: Context, canvasRenderer: CanvasRenderingContext2D) {
        this._uiContext = UIContext
        this._context = context
        this._context2D = canvasRenderer
        this._sourceManager = SourceManager(context)
        this._renderer = unsafe { zeroValue<Renderer>() }
        this._playerController = unsafe { zeroValue<StateController>() }
        this._playerController = StateController(this)
        this._renderer = Renderer(this)
    }

    private var _sourceManager: SourceManager

    public func sourceManager(): SourceManager {
        return this._sourceManager
    }

    private var _pageIndex: String = ""

    public func pageIndex(): String {
        return this._pageIndex
    }

    public func pageIndex(value: String) {
        this._pageIndex = value
    }

    /**
     * 播放器所在页面名
     */
    private var _pageName: String = ""

    public func pageName(): String {
        return this._pageName
    }

    public func pageName(value: String) {
        this._pageName = value
    }

    /**
     * 动画控制器
     */
    private var _animator: ?ValueAnimator = None

    public func animator(): ?ValueAnimator {
        return this._animator
    }

    /**
     * 数据源
     */
    private var _videoItem: ?MovieEntity = None

    public func videoItem(): ?MovieEntity {
        return this._videoItem
    }

    /**
     * canvas绘制工具
     */
    private var _context2D: ?CanvasRenderingContext2D = None

    public func context2D(): ?CanvasRenderingContext2D {
        return this._context2D
    }

    /**
     * 动画渲染控制器
     */
    private var _renderer: ?Renderer = None

    public func renderer(): ?Renderer {
        return this._renderer
    }

    /**
     * 播放完成时页面停留模式
     */
    //使用 AnimatorFill 代替 PLAYER_FILL_MODE
    private var _fillMode: AnimatorFill = AnimatorFill.Forwards

    public func fillMode(): AnimatorFill {
        return this._fillMode
    }

    public func fillMode(value: AnimatorFill) {
        this._fillMode = value
    }

    /**
     * 当前帧
     */
    private var _currentFrame: Float64 = 0.0

    public func currentFrame(): Float64 {
        return this._currentFrame
    }

    public func currentFrame(value: Float64) {
        this._currentFrame = value
    }

    /**
     * 填充模式
     */
    private var _contentMode: PLAYER_CONTENT_MODE = PLAYER_CONTENT_MODE.AspectFit

    public func contentMode(): PLAYER_CONTENT_MODE {
        return this._contentMode
    }

    /**
     * 是否正在正向播放
     */
    private var _forwardAnimating: Bool = false

    public func forwardAnimating(): Bool {
        return this._forwardAnimating
    }

    /**
     * 是否在停止后释放资源
     */
    private var _clearsAfterStop: Bool = true

    public func clearsAfterStop(): Bool {
        return this._clearsAfterStop
    }

    public func clearsAfterStop(value: Bool) {
        this._clearsAfterStop = value
    }

    /**
     * ui上下文 用于监听页面变化
     */
    private var _uiContext: ?UIContext = None

    public func uiContext(): ?UIContext {
        return this._uiContext
    }

    /**
     * 上下文 用于进行本地文件操作
     */
    private var _context: ?Context = None

    public func context(): ?Context {
        return this._context
    }

    /**
     * 循环次数
     */
    private var _loops: Float64 = 0.0

    public func loops(): Float64 {
        return this._loops
    }

    /**
     * 页面跳转其它页时 播放器的操作模式
     */
    private var _pageUpdateMode: PageUpdateMode = PageUpdateMode.pause

    public func pageUpdateMode(): PageUpdateMode {
        return this._pageUpdateMode
    }

    public func pageUpdateMode(value: PageUpdateMode) {
        this._pageUpdateMode = value
    }

    /**
     * 页面销毁时自动释放资源
     */
    private var _autoRelease: Bool = true

    public func autoRelease(): Bool {
        return this._autoRelease
    }

    public func autoRelease(value: Bool) {
        this._autoRelease = value
    }

    /**
     * 画布尺寸
     */
    private var _canvasValue: CanvasSizeAndTrans = CanvasSizeAndTrans()

    public func canvasValue(): CanvasSizeAndTrans {
        return this._canvasValue
    }

    public func canvasValue(value: CanvasSizeAndTrans) {
        this._canvasValue = value
    }

    private var _globalTransform: ?Transform = None

    public func globalTransform(): ?Transform {
        return this._globalTransform
    }

    /**
     * svgaPlayer组件尺寸
     */
    private var _parentSize: Sizes = Sizes(0, 0)

    public func parentSize(): Sizes {
        return this._parentSize
    }

    public func parentSize(value: Sizes) {
        this._parentSize = value
    }

    /**
     * 自定义文本集合
     */
    private var _dynamicText: HashMap<String, TextMap> = HashMap<String, TextMap>()

    public func dynamicText(): HashMap<String, TextMap> {
        return this._dynamicText
    }

    /**
     * 自定义图片变换集合
     */
    private var _dynamicImageTransform: HashMap<String, Transform> = HashMap<String, Transform>()

    public func dynamicImageTransform(): HashMap<String, Transform> {
        return this._dynamicImageTransform
    }

    /**
     * 设置资源
     * @param videoItem
     */
    public func setVideoItem(videoItem: MovieEntity) {
        this._currentFrame = 0.0
        this._videoItem = videoItem
        this.clear()
        this._renderer?.prepare()
        this._update()
        this._resize()
    }

    public func setContentMode(contentMode: PLAYER_CONTENT_MODE) {
        this._contentMode = contentMode
        this._update();
        this._resize();
    }

    /**
     * 开始动画
     * @param reverse 是否翻转
     */
    public func startAnimation(reverse: Bool) {
        this.stopAnimation(false);
        this._doStart(Option<Range>.None, reverse, Option<Float64>.None)
    }

    public func startAnimationWithRange(range: Range, reverse!: Bool = false) {
        this.stopAnimation(false);
        this._doStart(range, reverse, Option<Float64>.None)
    }

    /**
     * 暂停
     */
    public func pauseAnimation() {
        this._animator?.pause()
        this._renderer?.pauseAudios()
    }

    /**
     * 继续播放
     */
    public func playAnimation() {
        this._animator?.play()
        this._renderer?.playAudios()
    }

    /**
     * 停止动画
     * @param clear 是否清理
     */
    public func stopAnimation(clears: ?Bool) {
        this._forwardAnimating = false
        if (this._animator.isSome()) {
            this._animator?.stop()
        }
        var cleares = clears
        if (cleares.isNone()) {
            cleares = this._clearsAfterStop
        }
        if (cleares.isSome()) {
            this.clear()
        }
    }

    public func clear() {
        this._renderer?.clear()
        this._renderer?.clearAudios()
        this._animator?.release()
        this._animator = None
    }

    /**
     * 从指定位置开始播放
     * @param frame
     * @param andPlay 是否自动播放
     */
    public func stepToFrame(frame: Float64, andPlay!: Bool = true) {
        var src = if (let Some(v) <- this._videoItem) {
            Float64(v.params.frames)
        } else {
            0.0
        }
        if (frame >= src || frame < 0.0) {
            return;
        }
        this.pauseAnimation();
        this._currentFrame = frame
        this._update();
        if (andPlay) {
            this._doStart(Option<Range>.None, false, this._currentFrame);
        }
    }

    /**
     * 从指定百分比开始播放
     * @param percentage
     * @param andPlay
     */
    public func stepToPercentage(percentage: Int64, andPlay: Bool) {
        var src = if (let Some(v) <- this._videoItem) {
            Float64(v.params.frames)
        } else {
            1.0
        }
        //parseInt用于将给定字符串转化为指定进制的整数。
        //    let frame = parseInt((percentage * (this._videoItem?.params?.frames || 1)).toString());
        var frame: Float64 = (Float64(percentage) * src)
        if (frame >= src && frame > 0.0) {
            frame = src - 1.0
        }
        this.stepToFrame(frame, andPlay: andPlay)
    }

    /**
     * 设置播放次数 播放中修改无效
     * @param loops
     */
    public func setLoops(loops: Float64) {
        this._loops = if (loops <= 0.0) {
            Float64.Inf
        } else {
            loops
        }
    }

    /**
     * 播放速度 （通过修改帧率实现）
     * @param curRate
     * 需要在setvideoitem后 startanimation前执行
     */
    public func setCurRate(curRate: Int64) {
        this._speed = curRate
    }

    /**
     * 释放资源
     */
    public func release() {
        this._animator?.release()
        this._animator = None
        this._renderer?.clear()
        this._renderer?.release()

        this._playerController.release()
        this._sourceManager.release()
        this._renderer = None
        //    console.log('执行了清理222：' + this._renderer)
        this._uiContext = None
        this._context = None
        this._animator = None
        this.clearDynamicObjects()
        this._globalTransform = None
        this._context2D = None
        this._videoItem = None
        //    console.log('清理完毕')
    }

    public func clearDynamicObjects() {
        this._dynamicImageTransform.clear()
        this._dynamicText.clear()
    }

    /**
     * 动画完成回调
     * @param callback
     */
    public func onFinished(callback: () -> Unit) {
        this._onFinished = callback
    }

    /**
     * 帧回调
     * @param callback
     */
    public func onFrame(callback: (Float64) -> Unit) {
        this._onFrame = callback
    }

    /**
     * 百分百回调
     * @param callback
     */
    public func onPercentage(callback: (Float64) -> Unit) {
        this._onPercentage = callback
    }

    /**
     * 动态图片
     * @param urlOrResource 资源路径
     * @param forKey 所在位置
     * @param transform 变换参数
     */
    public func setImage(urlOrResource: ImageSource, forKey: String, transform: ?Transform) {
        try {
            this._renderer?.setDynamicImage(urlOrResource, forKey)
        } catch (e: Exception) {
            //            console.error('svga', 'setImage err:' + e)
        }
        //        if (transform.isSome() && transform instanceof Array && transform.length == 6) {
        if (let Some(v) <- transform) {
            this._dynamicImageTransform.put(forKey, v)
        }
    }

    public func setImage(urlOrResource: AppResource, forKey: String, transform: ?Transform) {
        try {
            var imageArray: Array<UInt8> = Array<UInt8>()
            try {
                imageArray = getSystemResourceManager().getMediaContent(urlOrResource)
            } catch (e: Exception) {
                try {
                    imageArray = getSystemResourceManager().getRawFileContent(
                        ((urlOrResource as AppResource)?.paramsArr[0] as String).getOrThrow())
                } catch (e: Exception) {
                    //                console.error("svga", "parse file:" + e);
                }
            }
            var imageResource = this.parseResourceStr(imageArray)
            this._renderer?.setDynamicImage(imageResource, forKey)
        } catch (e: Exception) {
            //            console.error('svga', 'setImage err:' + e)
        }
        if (let Some(v) <- transform) {
            this._dynamicImageTransform.put(forKey, v)
        }
    }

    /**
     * 动态文字
     * @param textORMap 文本参数
     * @param forKey 所在位置
     */
    public func setText(textORMap: String, forKey: String) {
        let text = textORMap
        let size = "${fp2px(Length(14.0))?.value}.px"
        let family = "Arial"
        let color = "#000000"
        let weight = "normal"
        let offset: TextOffset = TextOffset()
        this
            ._dynamicText
            .put(forKey, TextMap(text: text, style: "normal ${weight} ${size} ${family}", color: color, offset: offset))
    }

    public func setText(textORMap: TextMap, forKey: String) {
        let text = textORMap.text
        var size: String
        let family = textORMap.family
        let color = textORMap.color
        let weight = textORMap.weight
        if (textORMap.size.isSome()) {
            size = "${fp2px(textORMap.size.getOrThrow())?.value}.px"
        } else {
            size = "${fp2px(Length(14.0))?.value}.px"
        }
        let offset: ?TextOffset = textORMap.offset
        this
            ._dynamicText
            .put(forKey,
                TextMap(text: text, style: "normal ${weight?.toString()} ${size} ${family}", color: color,
                    offset: offset))
    }

    /**
     * 初始化
     */
    private func _init() {
        //    this._renderer = Renderer(this)
    }

    /**
     * 处理资源
     * @param pixelBuffer
     * @returns
     */
    private func parseResourceStr(pixelBuffer: Array<UInt8>): ?ImageSource {
        var imageResource: ?ImageSource = None
        try {
            imageResource = createImageSource(pixelBuffer)
        } catch (e: Exception) {
            //      console.error('svga', 'parseResourceStr err:' + e)
        }
        return imageResource
    }

    private func getFps() {
        var src = if (let Some(v) <- this._videoItem) {
            Int64(v.params.fps)
        } else {
            20
        }
        return src * this._speed
    }

    private func _doStart(range: ?Range, reverse: Bool, fromFrame: ?Float64) {
        try {
            //this._animator = new ValueAnimator(this.uiContext!)
            this._animator = ValueAnimator(this._uiContext)
            if (let Some(v) <- range) {
                this._animator?.startValue = max(0.0, Float64(v.location))
                var src = if (let Some(vs) <- this._videoItem) {
                    Float64(vs.params.frames)
                } else {
                    1.0
                }
                this._animator?.endValue = min(src - 1.0, Float64(v.location) + Float64(v.length))
                if (this.getFps() != 0) {
                    this._animator?.duration = ((this._animator?.endValue).getOrThrow() -
                        (this._animator?.startValue).getOrThrow() + 1.0) * (1.0 / Float64(this.getFps())) * 1000.0
                } else {
                    this._animator?.duration = ((this._animator?.endValue).getOrThrow() -
                        (this._animator?.startValue).getOrThrow() + 1.0) * (1.0 / 1.0) * 1000.0
                }
            } else {
                this._animator?.startValue = 0.0
                var srcs = if (let Some(vs) <- this._videoItem) {
                    Float64(vs.params.frames)
                } else {
                    1.0
                }
                this._animator?.endValue = srcs - 1.0
                if (this.getFps() != 0) {
                    this._animator?.duration = srcs * (1.0 / Float64(this.getFps())) * 1000.0
                } else {
                    this._animator?.duration = srcs * (1.0 / 1.0) * 1000.0
                }
            }
            if (this.getFps() != 0) {
                this._animator?.FPS = Float64(this.getFps())
            } else {
                this._animator?.FPS = 20.0
            }

            this._animator?.loops = if (this._loops <= 0.0) {
                Float64.Inf
            } else {
                this._loops
            }
            this._animator?.fillRule = this._fillMode
            this._animator?.onUpdate = {value => this.animatorUpdate(value)}
            this._animator?.onEnd = {=> this.animatorEnd()}

            if (reverse == true) {
                this._animator?.reverse(fromFrame)
                this._forwardAnimating = false
            } else {
                this._animator?.start(fromFrame)
                this._forwardAnimating = true
            }
            this._currentFrame = (this._animator?.startValue).getOrThrow()
            this._update()
        } catch (e: Exception) {
            //      console.error('svga', '_doStart ' + e)
        }
    }

    /**
     * 动画执行过程
     * @param value
     */
    private func animatorUpdate(value: Float64): Unit {
        if (this._currentFrame == floor(value)) {
            return;
        }

        if (this._forwardAnimating && this._currentFrame > floor(value)) {
            this._renderer?.clearAudios()
        }
        this._currentFrame = floor(value)
        this._update()

        if (let Some(v) <- this._onFrame) {
            v(this._currentFrame)
        }
        if (let Some(v) <- this._onPercentage) {
            var src = if (let Some(v) <- this._videoItem) {
                Float64(v.params.frames)
            } else {
                1.0
            }
            v((this._currentFrame + 1.0) / src)
        }
    }

    /**
     * 动画结束程序
     */
    private func animatorEnd(): Unit {
        this._forwardAnimating = false
        if (this._clearsAfterStop == true) {
            this.clear()
        }
        if (let Some(v) <- this._onFinished) {
            v()
        }
    }

    /**
     * 设置尺寸
     */
    private func _resize() {
        this._canvasValue.transformValue = identity()
        this._globalTransform = None
        this._canvasValue.scaleValue = ScaleOptions(
            x: 1.0,
            y: 1.0,
            centerX: 0.0,
            centerY: 0.0
        )
        if (this._context2D.isSome()) {
            var scaleX = 1.0;
            var scaleY = 1.0;
            var translateX = 0.0;
            var translateY = 0.0;
            var targetSize: Sizes = Sizes(0, 0)
            if (this._parentSize.width != 0 && this._parentSize.height != 0) {
                targetSize = Sizes(this._parentSize.width, this._parentSize.height)
            } else {
                let width_1: Int32 = if (let Some(v) <- this._videoItem) {
                    Int32(v.params.viewBoxWidth)
                } else {
                    0
                }
                let height_1: Int32 = if (let Some(v) <- this._videoItem) {
                    Int32(v.params.viewBoxHeight)
                } else {
                    0
                }
                targetSize = Sizes(width_1, height_1)
            }
            var width_imageSize: Int32 = if (let Some(v) <- this._videoItem) {
                Int32(v.params.viewBoxWidth)
            } else {
                0
            }
            var height_imageSize: Int32 = if (let Some(v) <- this._videoItem) {
                Int32(v.params.viewBoxHeight)
            } else {
                0
            }
            let imageSize: Sizes = Sizes(width_imageSize, height_imageSize)
            if (targetSize.width >= imageSize.width && targetSize.height >= imageSize.height) {
                this._canvasValue.width = "${px2vp(Length(Float64(targetSize.width)))?.value}.vp"
                this._canvasValue.height = "${px2vp(Length(Float64(targetSize.height)))?.value}.vp"
                if (this._contentMode == PLAYER_CONTENT_MODE.Fill) {
                    scaleX = Float64(targetSize.width / imageSize.width)
                    scaleY = Float64(targetSize.height / imageSize.height)
                } else if (this._contentMode == PLAYER_CONTENT_MODE.AspectFit || this._contentMode == PLAYER_CONTENT_MODE
                    .AspectFill) {
                    let imageRatio = imageSize.width / imageSize.height;
                    let viewRatio = targetSize.width / targetSize.height;
                    if ((imageRatio >= viewRatio && this._contentMode == PLAYER_CONTENT_MODE.AspectFit) || (imageRatio <=
                        viewRatio && this._contentMode == PLAYER_CONTENT_MODE.AspectFill)) {
                        scaleY = Float64(targetSize.width / imageSize.width)
                        scaleX = scaleY
                        translateY = (Float64(targetSize.height) - Float64(imageSize.height) * scaleY) / 2.0
                    } else if ((imageRatio < viewRatio && this._contentMode == PLAYER_CONTENT_MODE.AspectFit) || (imageRatio >
                        viewRatio && this._contentMode == PLAYER_CONTENT_MODE.AspectFill)) {
                        scaleY = Float64(targetSize.height / imageSize.height)
                        scaleX = scaleY
                        translateX = (Float64(targetSize.width) - Float64(imageSize.width) * scaleX) / 2.0
                    }
                }
                this._globalTransform = Transform(
                    a: Float32(scaleX),
                    b: 0.0,
                    c: 0.0,
                    d: Float32(scaleY),
                    tx: Float32(translateX),
                    ty: Float32(translateY)
                )
            } else {
                this._canvasValue.width = "${px2vp(Length(Float64(imageSize.width)))?.value}.vp"
                this._canvasValue.height = "${px2vp(Length(Float64(imageSize.height)))?.value}.vp"
                if (this._contentMode == PLAYER_CONTENT_MODE.Fill) {
                    scaleX = Float64(targetSize.width / imageSize.width)
                    scaleY = Float64(targetSize.height / imageSize.height)
                    translateX = (Float64(imageSize.width) * scaleX - Float64(imageSize.width)) / 2.0
                    translateY = (Float64(imageSize.height) * scaleY - Float64(imageSize.height)) / 2.0
                    //           this._canvasValue.transformValue.translate(TranslateOption(
                    //             x: translateX,
                    //             y: translateY
                    //           ))
                    this._canvasValue.scaleValue = ScaleOptions(
                        x: scaleX,
                        y: scaleY,
                        centerX: 0.0,
                        centerY: 0.0
                    )
                } else if (this._contentMode == PLAYER_CONTENT_MODE.AspectFit || this._contentMode == PLAYER_CONTENT_MODE
                    .AspectFill) {
                    let imageRatio = imageSize.width / imageSize.height;
                    let viewRatio = targetSize.width / targetSize.height;
                    if ((imageRatio >= viewRatio && this._contentMode == PLAYER_CONTENT_MODE.AspectFit) || (imageRatio <=
                        viewRatio && this._contentMode == PLAYER_CONTENT_MODE.AspectFit)) {
                        scaleY = Float64(targetSize.width / imageSize.width)
                        scaleX = scaleY
                        translateX = (Float64(targetSize.width) - Float64(imageSize.width) * scaleX) / 2.0
                        translateY = (Float64(targetSize.height) - Float64(imageSize.height) * scaleY) / 2.0
                        this._canvasValue.transformValue.translate(
                            TranslateOption(
                                x: translateX,
                                y: translateY
                            )
                        )
                        this._canvasValue.scaleValue = ScaleOptions(
                            x: scaleX,
                            y: scaleY,
                            centerX: 0.0,
                            centerY: 0.0
                        )
                    } else if ((imageRatio < viewRatio && this._contentMode == PLAYER_CONTENT_MODE.AspectFit) || (imageRatio >
                        viewRatio && this._contentMode == PLAYER_CONTENT_MODE.AspectFill)) {
                        scaleY = Float64(targetSize.height / imageSize.height)
                        scaleX = scaleY
                        translateX = (Float64(targetSize.width) - Float64(imageSize.width) * scaleX) / 2.0
                        translateY = (Float64(targetSize.height) - Float64(imageSize.height) * scaleY) / 2.0
                        this._canvasValue.transformValue.translate(
                            TranslateOption(
                                x: translateX,
                                y: translateY
                            )
                        )
                        this._canvasValue.scaleValue = ScaleOptions(
                            x: scaleX,
                            y: scaleY,
                            centerX: 0.0,
                            centerY: 0.0
                        )
                    }
                }
            }
        }
    }

    private func _update() {
        if (this._videoItem.isNone()) {
            return
        }
        this._renderer?.drawFrame(this._currentFrame)
        this._renderer?.playAudio(this._currentFrame)
    }
}

public interface Range {
    prop location: Int64
    prop length: Int64
}
