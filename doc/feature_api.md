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
     * 参数 pageUpdateMode - 页面跳转时动画处理模式，默认值为PageUpdateMode.pause
     * 参数 loops - 动画播放次数，默认值为-1
     * 参数 autoRelease - 页面销毁时自动执行清理，默认值为true
     * 参数 clearsAfterStop - 设置是否在停止后释放资源，默认值为true
     * 参数 fillMode - 动画结束时的动画状态，默认值为AnimatorFill.Forwards
     **/
    public init(pageUpdateMode!: PageUpdateMode = PageUpdateMode.pause, loops!: Int32 = -1, autoRelease!: Bool = true,
        clearsAfterStop!: Bool = true, fillMode!: AnimatorFill = AnimatorFill.Forwards) 

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
     * 获取动画处播放模式
     *
     * @return PageUpdateMode 类型
     */
    public func getpageUpdateMode(): PageUpdateMode
    
    /**
     * 加载动画资源
     *
     * @param source - 动画资源的文件路径
     * @param autoPlay - 是否自动播放，默认值为true
     *
     */
    public func load(source: String, autoPlay!: Bool = true)

    /**
     * 开始播放动画
     * 参数 reverse - Bool类型，是否反向播放，设置为true,反向播放，否则相反
     */
    public func startAnimation(reverse!: Bool = false)
    
    /**
     * 开始播放动画
     * 参数 range - SvgaRange类型
     * 参数 reverse - Bool类型，是否反向播放，设置为true,反向播放，否则相反
     */
    public func startAnimationWithRange(range: SvgaRange, reverse!: Bool = false)
    
    /**
     * 暂停动画
     */
    public func pauseAnimation()
    
    /**
     * 停止动画
     * 参数 clear - Bool类型，设置为true,停止播放后自动清理资源，设置false，则相反
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
     * 参数 percentage - Int64类型，视频总帧数百分比
     * 参数 andPlay - Bool类型，设置为true,从指定百分比开始播放，设置false则不播放
     */
    public func stepToPercentage(percentage: Int64, andPlay: Bool)
    
    /**
     * 清理动态资源
     */
    public func clearDynamicObjects() 
    
    /**
     * 设置重复次数。需在播放前调用
     * 参数 loops - Int32类型，循环次数
     */
    public func setLoops(loops: Int32)
    
    /**
     * 设置播放速度
     * 参数 curRate - Float64类型，播放倍速，这里仅支持正数倍数，其他非法值不保证结果
     */
    public func setCurRate(curRate: Float64)
    
    /**
     * 清理动画资源
     */
    public func release()
	
	public enum PLAYER_CONTENT_MODE{
	  |AspectFit // 选取长宽里面较大的一个作为依据 填充整个容器
	  |Fill // 填充整个容器
      |AspectFile // 选取长宽里面较小的一个作为依据 填充整个容器
	  /*判等*/
	  public operator func ==
	  /*判不等*/
	  public operator func !==
	}
	
	public class SvgaRange{
	 /**
     * SvgaRange构造器
	 * 参数location - Float64类型，动画起始位置
	 * 参数length - Float64类型，动画播放长度
     */
	public init(location:Float64,length:Float64)
	}
}
```






