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
    var controller: SvgaController = SvgaController()
}
```

## 2 svga控制器

### 2.1 SvgaPlayerProps Class API Description

svag动画播放属性

```cangjie
public class SvgaPlayerProps {

    /**
     * 构造函数
     * 参数 loops - 动画播放次数，默认值为-1
     * 参数 autoRelease - 页面销毁时自动执行清理，默认值为true
     * 参数 clearsAfterStop - 设置是否在停止后释放资源，默认值为true
     * 参数 fillMode - 动画结束时的动画状态，默认值为AnimatorFill.Forwards
     */
    public init(loops!: Int32 = -1, autoRelease!: Bool = true,
        clearsAfterStop!: Bool = true, fillMode!: AnimatorFill = AnimatorFill.Forwards) 

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
     * @return Int32类型，表示循环次数
     */
    public func getloops(): Int32
    
    /**
     * 获取当前是否自动释放动画资源
     *
     * @return Bool类型， 返回true, 表示自动释放动画资源
     */
    public func getautoRelease(): Bool
    
    /**
     * 获取是否在停止后释放资源
     *
     * @return Bool类型，返回true, 表示停止播放后自动释放资源，否则返回false
     */
    public func getclearsAfterStop(): Bool
    
    /**
     * 获取动画执行后，动画结束时的状态
     *
     * @return AnimatorFill类型,具体释义见UI文档
     */
    public func getfillMode(): AnimatorFill
    
    /**
     * 获取Player动画播放器
     *
     * @return Player类型
     */
    public func getplayer(): Player
    
    /**
     * 加载动画资源
     *
     * @param source - 动画资源的文件路径
     * @param autoPlay - 是否自动播放，默认值为true
     *
     */
    public func load(source: String, autoPlay!: Bool = true): Unit
    
    /**
     * 开始播放动画
     * 参数 reverse - Bool类型，是否反向播放，设置为true,反向播放，否则相反
     */
    public func startAnimation(reverse!: Bool = false)
    
    /**
     * 设置指定范围开始播放动画
     * 参数 range - SvgaRange类型，动画播放的范围
     * 参数 reverse - Bool类型，是否反向播放，设置为true,反向播放，否则相反
     */
    public func startAnimationWithRange(range: SvgaRange, reverse!: Bool = false)
    
    /**
     * 暂停动画
     */
    public func pauseAnimation()
    
    /**
     * 停止动画
     * 参数 clears - Bool类型，设置为true,停止播放后自动清理资源，设置false，则相反
     */
    public func stopAnimation(clears: Bool)
    
    /**
     * 设置当前播放模式
     * 参数 mode - PLAYER_CONTENT_MODE类型
     */
    public func setContentMode(mode: PLAYER_CONTENT_MODE)
    
    /**
     * 清理动画资源
     */
    public func clear()
    
    /**
     * 从指定位置开始播放
     * 参数 frame - Float64类型，帧数，从该帧开始播放
     * 参数 andPlay - Bool类型，跳帧后是否播放，设置为true,正常播放，设置false则不播放
     */
    public func stepToFrame(frame: Float64, andPlay!: Bool = true)
    
    /**
     * 从指定百分比开始播放
     * 参数 percentage - Float64类型，视频总帧数百分比
     * 参数 andPlay - Bool类型，设置为true,从指定百分比开始播放，设置false则不播放
     */
    public func stepToPercentage(percentage: Float64, andPlay: Bool)
    
    /**
     * 设置动画播放器中图像内容
     * 参数 urlOrResource - String 类型，图像内容的地址支持resfile文件夹路径
     * 参数 forKey - String 类型，指定文本的标识键
     * 参数 transform - Transform 类型，对图像进行变换处
     */
    public func setImage(urlOrResource: String, forKey: String, transform!: ?Transform = None)
    
    /**
     * 设置动画播放器中图像内容
     * 参数 urlOrResource - ImageSource 类型，图片源类
     * 参数 forKey - String 类型，指定文本的标识键
     * 参数 transform - Transform 类型，对图像进行变换处
     */
    public func setImage(urlOrResource: ImageSource, forKey: String, transform!: ?Transform = None)
    /**
     * 设置动画播放中文本内容
     * 参数 textORMap - String 类型，文本内容
     * 参数 forKey - String 类型，指定文本的标识键
     */
    public func setText(textORMap: String, forKey: String)
    
    
    /**
     * 设置动画播放中文本内容
     * 参数 textORMap - TextMap 类型，文本内容格式设置
     * 参数 forKey - String 类型，指定文本的标识键
     */
    public func setText(textORMap: TextMap, forKey: String)
    
    /**
     * 清理动态资源
     */
    public func clearDynamicObjects() 
    
    /**
     * 动画完成后的回调接口
     * 参数 callback - 回调接口
     */
    public func onFinished(callback: () -> Unit)
    
    /**
     * 获取当前播放的帧数回调接口
     * 参数 callback - 回调接口
     */
    public func onPercentage(callback: (Float64) -> Unit)
    
    /**
     * 监听播放进度百分比回调接口
     * 参数 callback - 回调接口
     */
    public func onPercentage(callback: (Float64) -> Unit)
    
    
    /**
     * 设置播放次数。需在播放前调用
     * 参数 loops - Int32类型，循环次数
     */
    public func setLoops(loops: Int32)
    
    /**
     * 设置倍速播放
     * 参数 curRate - Float64类型,倍速播放 仅开始播放前设置生效
     */
    public func setCurRate(curRate: Float64)
    
    /**
     * 清理动画资源
     */
    public func release()
}
//控制动画内容在画布中的适配方式
public enum PLAYER_CONTENT_MODE{
    |AspectFit // 选取长宽里面较大的一个作为依据 填充整个容器
    |Fill // 填充整个容器
    |AspectFill // 选取长宽里面较小的一个作为依据 填充整个容器
    /*判等*/
    public operator func ==
    /*判不等*/
    public operator func !=
}
//动画播放的范围
public class SvgaRange{
    /**
    * SvgaRange构造器
    * 参数location - Float64类型，动画起始位置
    * 参数length - Float64类型，动画播放长度
    */
    public init(location:Float64,length:Float64)
}

public class TextMap {
    
    /**
    * TextMap构造器
    * 参数 text - String 类型，字体的内容
    * 参数 size - Length 类型，字体的大小
    * 参数 color - Color 类型，字体的颜色
    * 参数 offset - TextOffset 类型，字体的起始位置
    * 参数 family - String 类型，文本的字体列表
    * 参数 style - FontStyle 类型，文本字体样式
    * 参数 weight - FontWeight 类型，文本的字体粗细
    */
    public init(text!: String = "", size!: ?Length = None, color!: ?Color = None, offset!: ?TextOffset = None,
        family!: ?String = None, style!: FontStyle = FontStyle.Normal, weight!: ?FontWeight = None) 
}

public class TextOffset {
    
    /**
    * TextOffset 构造器
    * 参数x - Float64类型，字体的x坐标
    * 参数y - Float64类型，字体的y坐标
    */
    public init(x!: Float64 = 0.0, y!: Float64 = 0.0)
}
```


