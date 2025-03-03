# svga-cj 特性文档

## 介绍

 svga-cj是一个动画库，它可以解析svga格式的动画，并在移动设备上进行本地渲染。

## 1 svga播放器

### 1.1 SvgaPlayer Class API Description

svga播放器组件

```cangjie
@Component
public class SvgaPlayer {
    /* svga rawfile资源路径 */
    @State
    @Watch[updateSource]
    var url: String = ""
    
    /* svga 控制器 */
    @Prop
    var controller: ?SvgaController = None
    
    /**
     * Component控件生成函数。
     */
    public func build()
}
```

### 1.2 Player Class API Description

svga播放器

```cangjie
public class Player {
    /**
     * 播放器构造
     * 参数 UIContext - ui上下文
     * 返回 canvasRenderer - canvas渲染器
     */
    public init(UIContext: AbilityContext, canvasRenderer: CanvasRenderingContext2D)
    
    /**
     * 设置当前页面的属性
     * 参数 value - 页面的属性
     */
    public func pageIndex(value: String)
    
    /**
     * 获取当前页面的属性
     * 返回 String - 页面的属性
     */
    public func pageIndex(): String
    
    /**
     * 设置pageName
     * 参数 value - String
     */
    public func pageName(value: String)
    
    /**
     * 获取pageName
     * 返回 String - String
     */
    public func pageName(): String
    
    /**
     * 获取CanvasRenderingContext2D
     * 返回 CanvasRenderingContext2D - CanvasRenderingContext2D
     */
    public func context2D(): CanvasRenderingContext2D
    
    /**
     * 获取动画执行后是否恢复到初始状态，动画执行后，动画结束时的状态（在最后一个关键帧中定义）将保留
     *
     * 返回 AnimatorFill - AnimatorFill
     */
    public func fillMode(): AnimatorFill 
    
    /**
     * 设置动画执行后是否恢复到初始状态，动画执行后，动画结束时的状态（在最后一个关键帧中定义）将保留
     *
     * @param value - AnimatorFill
     * 
     */
    public func fillMode(value: AnimatorFill)

    /**
     * 获取当前帧
     * 返回值 Float64 - Float64
     */
    public func currentFrame(): Float64
    
    /**
     * 设置当前帧
     * 参数 value - Float64
     */
    public func currentFrame(value: Float64)

    /**
     * 获取当前PLAYER_CONTENT_MODE
     * 返回值 PLAYER_CONTENT_MODE - PLAYER_CONTENT_MODE
     */
    public func contentMode(): PLAYER_CONTENT_MODE

    /**
     * 获取当前是否正在正向播放
     * 返回值 Bool - Bool
     */
    public func forwardAnimating(): Bool

    /**
     * 获取当前是否在停止后释放资源
     * 返回值 Bool - Bool
     */
    public func clearsAfterStop(): Bool
    
    /**
     * 设置当前是否在停止后释放资源
     * 参数 value - Bool
     */
    public func clearsAfterStop(value: Bool)
    
    /**
     * 获取当前AbilityContext
     * 返回值 AbilityContext - AbilityContext
     */
    public func uiContext(): AbilityContext
    
    /**
     * 获取当前循环次数
     * 返回值 Float64 - Float64
     */
    public func loops(): Float64
    
    /**
     * 获取当前页面跳转其它页时 播放器的操作模式
     * 返回值 PageUpdateMode - PageUpdateMode
     */
    public func pageUpdateMode(): PageUpdateMode
    
    /**
     * 设置当前页面跳转其它页时 播放器的操作模式
     * 参数 PageUpdateMode - PageUpdateMode
     */
    public func pageUpdateMode(value: PageUpdateMode)
    
    /**
     * 获取当前是否自动释放资源
     * 返回值 Bool - Bool
     */
    public func autoRelease(): Bool
    
    /**
     * 设置当前是否自动释放资源
     * 参数 Bool - Bool
     */
    public func autoRelease(value: Bool)
    
    /**CanvasSizeAndTrans
     * 获取当前画布值
     * 返回值 CanvasSizeAndTrans - CanvasSizeAndTrans
     */
    public func canvasValue(): CanvasSizeAndTrans
    
    /**
     * 设置当前画布值
     * 参数 calue - CanvasSizeAndTrans
     */
    public func canvasValue(value: CanvasSizeAndTrans)
    
    /**
     * 获取当前svgaPlayer组件尺寸默认0
     * 返回值 Transform - Transform
     */
    public func globalTransform(): ?Transform
    
    /**
     * 获取当前svgaPlayer组件尺寸，默认0
     * 返回值 Sizes - Sizes 对应使用的是 ohos.image.Size 
     */
    public func parentSize(): Sizes
    
    /**
     * 设置当前svgaPlayer组件尺寸
     * 参数 Sizes - Sizes
     */
    public func parentSize(value: Sizes)
    
    /**
     * 获取当前自定义文本集合
     * 返回值 HashMap<String, TextMap> - HashMap<String, TextMap>
     */
    public func dynamicText(): HashMap<String, TextMap>
    
    /**
     * 获取当前自定义图片变换集合
     * 返回值 HashMap<String, Transform> - HashMap<String, Transform>
     */
    public func dynamicImageTransform(): HashMap<String, Transform>
    
    /**
     * 设置当前播放模式
     * 参数 contentMode - PLAYER_CONTENT_MODE
     */
    public func setContentMode(contentMode: PLAYER_CONTENT_MODE)
    
    /**
     * 开始播放动画
     * 参数 reverse - Bool
     */
    public func startAnimation(reverse: Bool)
    
    /**
     * 开始播放动画
     * 参数 range - Range
     * 参数 reverse - Bool
     */
    public func startAnimationWithRange(range: Range, reverse!: Bool = false)
    
    /**
     * 暂停动画
     */
    public func pauseAnimation()
    
    /**
     * 播放动画
     */
    public func playAnimation()
    
    /**
     * 停止动画
     * 参数 clears - Bool
     */
    public func stopAnimation(clears: Bool)
    
    /**
     * 清理动画资源
     */
    public func clear()
    
    /**
     * 从指定位置开始播放
     * 参数 frame - Float64
     * 参数 andPlay - Bool
     */
    public func stepToFrame(frame: Float64, andPlay!: Bool = true)
    
    /**
     * 从指定百分比开始播放
     * 参数 percentage - Float64
     * 参数 andPlay - Bool
     */
    public func stepToPercentage(percentage: Int64, andPlay: Bool)
    
    /**
     * 设置重复次数
     * 参数 loops - Float64
     */
    public func setLoops(loops: Float64)
    
    /**
     * 设置播放速度
     * 参数 curRate - Int64
     */
    public func setCurRate(curRate: Int64)
    
    /**
     * 清理动画资源
     */
    public func release()
    
    /**
     * 清理动态资源
     */
    public func clearDynamicObjects()
    
    /**
     * 动画结束回调
     */
    public func onFinished(callback: () -> Unit)
    
    /**
     * 动画播放帧回调
     */
    public func onFrame(callback: (Float64) -> Unit)
    
    /**
     * 动画百分百回调回调
     */
    public func onPercentage(callback: (Float64) -> Unit)
}

public class CanvasSizeAndTrans {
    public var width: String = '100%' //当前页面的宽度
    public var height: String = '100%' //当前页面的高度，默认值为
    public var transformValue: matrix4.Matrix4Transit = matrix4.identity() //变换矩阵
    public var scaleValue: ScaleOptions = ScaleOptions(x: 1.0, y: 1.0) //缩放参数
}

// 填充模式 
public enum PLAYER_CONTENT_MODE {
    | AspectFit //选取长宽里面较大的一个作为依据 填充整个容器
    | Fill //填充整个容器
    | AspectFill //选取长宽里面较小的一个作为依据 填充整个容器

    /* 判等 */
    public operator func ==
    /* 判不等 */
    public operator func !=
}

public enum AnimatorPlayStatus {
    | INACTIVE // 初始状态
    | PLAY // 播放中
    | FINISH // 播放完成
    | PAUSE // 暂停
}

public class ValueAnimator {
    /**
     * ValueAnimator 的有参构造方法
     * 参数 uicontext - UI上下文
     */
    public init(uicontext: ?UIContext) 
    
    /**
     * 获取动画状态
     * 返回值Status - AnimatorPlayStatus
     */
    public func getstatus(): AnimatorPlayStatus
    
    /**
     * 开始动画处理
     * 参数 frame - Float64
     * 参数 reverse - Bool
     */
    public func start(frame: ?Float64, reverse!: Bool = false)
    
    /**
     * 动画反向播放
     * 参数 currentValue - Float64
     */
    public func reverse(currentValue: ?Float64)
    
    /**
     * 动画资源释放
     */
    public func release()
    
    /**
     * 动画停止
     */
    public func stop()
    
    /**
     * 动画暂停
     */
    public func pause()
    
    /**
     * 动画播放
     */
    public func play()
}
```

## 2 svga控制器

### 2.1 SvgaPlayerProps Class API Description

svag动画播放属性

```cangjie
public class SvgaPlayerProps {

    /**
     * 页面跳转时动画处理模式
     * 默认值为None
     **/
    public var pageUpdateMode: ?PageUpdateMode = None
    
    /**
     * 动画播放的次数
     * 默认值为None
     */
    public var loops: ?Float64 = None
    
    /**
     * 页面销毁时自动执行清理
     * 默认值为None
     **/
    public var autoRelease: ?Bool = None
    
    /**
     * 设置是否在停止后释放资源
     * 默认值为None
     */
    public clearsAfterStop: ?Bool = None
    
    /**
     * 动画结束时的状态
     * 默认值为None
     */
    public var fillMode: ?AnimatorFill = AnimatorFill.None

}

public enum PageUpdateMode {
        /* 暂停状态 */
        | pause  
        /* 播放状态 */
        | play
        /* 销毁状态 */
        | release
} 


```

### 2.2 SvgaController Class API Description

svag动画控制器

```cangjie
public class SvgaController {
    
    /**
     * SvgaController 的有参构造方法
     * @param props - svag动画播放属性
     * 默认值为None
     */
    public init(props!: ?SvgaPlayerProps = None)
    
    /**
     * 获取动画播放次数
     *
     * @return Float64类型
     */
    public func getloops(): Float64
    
    /**
     * 是否自动释放动画资源
     *
     * @return Bool类型
     */
    public func getautoRelease(): Bool
    
    /**
     * 是否在播放停止后情理动画资源，返回true,表示播放停止后情理，false则相反
     *
     * @return Bool类型
     */
    public func getclearsAfterStop(): Bool
    
    /**
     * 动画执行后是否恢复到初始状态,动画执行后，动画结束时的状态（在最后一个关键帧中定义）将保留
     *
     * @return AnimatorFill类型
     */
    public func getfillMode(): AnimatorFill
    
    /**
     * 获取当前播放器对象
     *
     * @return Player 类型
     */
    public func getplayer(): Player
    
    /**
     * 设置当前播放器对象
     *
     * @param value - Player对象
     *
     */
    public func setplayer(value: Player)  
    
    /**
     * 获取动画处播放模式
     *
     * @return PageUpdateMode 类型
     */
    public func getpageUpdateMode(): PageUpdateMode
    
    /**
     * 加载动画资源
     *
     * @param source - 动画资源的文件路径
     * @param success - SuccessFn 类型
     * @param failure - FailureFn 类型
     * @param autoPlay - 是否自动播放，默认值为true
     *
     */
    public func load(source: String, success!: ?SuccessFn = None, failure!: ?FailureFn = None, autoPlay!: Bool = true)
    
    //加载成功的回调函数
    public type SuccessFn = (MovieEntity) -> Unit
    //加载失败的回调函数
    public type FailureFn = (Object) -> Unit
    
    /**
     * 停止动画
     *
     * @param clears - Bool 类型
     *
     */
    public func stopAnimation(clears: Bool)
}
```






