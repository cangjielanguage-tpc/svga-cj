package svga

//import ohos.base.*
//import ohos.component.*
//import ohos.state_manage.*
//import ohos.state_macro_manage.*
//import ohos.image.Size as Sizes
import tpc.AbilityKit.UIAbilityContext
import tpc.ImageKit.image.Size as Sizes
import tpc.UIKit.component_interop.*
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Watch
import ohos.state_macro_manage.Prop
import ohos.state_macro_manage.Component

//import svga.player.SvgaController
//import svga.player.CanvasSizeAndTrans
import svga.parser.Parser
import svga.player.*
import svga.global.*


@Component
public class SvgaPlayer {
    @State
    @Watch[updateSource]
    var url: String = ""
    @Prop
    var abilitycontext: UIAbilityContext
    var controller: SvgaController = SvgaController()
    var settinges: RenderingContextSettings = RenderingContextSettings(antialias: true)
    var context: CanvasRenderingContext2D = CanvasRenderingContext2D(settings:settinges,unit:LengthMetricsUnit.PX)
    @State
    var canvasValue: CanvasSizeAndTrans = CanvasSizeAndTrans()
    public var onReady: ?() -> Unit = None
    var onreadyIsLose: Bool = false

    public func updateSource() {
        this.playAnim()
        return
    }

    public func aboutToAppear(): Unit {
        var uiContext = this.abilitycontext
        this.controller.setparser(Parser(uiContext))
        var player = Player(uiContext, this.context)

        this.controller.setplayer(Player(globalcontext.getOrThrow(), this.context))
        this.controller.getplayer().canvasValue(this.canvasValue)
        this.controller.getplayer().parentSize(Sizes(Int32(this.context.width),Int32(this.context.height)))
    }

    public func aboutToDisappear():Unit{
        this.controller.release()
    }

    public func build() {
        Stack(Alignment.TopStart) {
            Canvas(this.context)
                .width(this.canvasValue.width)
                .height(this.canvasValue.height)
                .transform(this.canvasValue.transformValue)
                .scale(x: Float32(this.canvasValue.scaleValue.x.getOrThrow()), y: Float32(this.canvasValue.scaleValue.y.getOrThrow()),
                    z: Float32(this.canvasValue.scaleValue.z ?? 0.0),centerX:Length(Float64(this.canvasValue.scaleValue.centerX ?? 0.0)),centerY:Length(Float64(this.canvasValue.scaleValue.centerY ?? 0.0)))
                .backgroundColor(Color.TRANSPARENT)
                .onReady {
                    this.controller.getplayer().parentSize(Sizes( Int32(this.context.width),Int32(this.context.height)))
                    if (this.onreadyIsLose) {
                        return
                    }
                    this.onreadyIsLose = true
                    if (let Some(v) <- this.onReady) {
                        v
                        return
                    }
                    if (this.url == "") {
                        AlertDialog.show(AlertDialogParamWithConfirm("地址错误 请输入完整沙箱路径"))
                        return
                    }
                    this.playAnim()
                }
        }
            .width(100.percent)
            .height(100.percent)
            .onAreaChange(
                {
                    old, area => this.controller.getplayer().parentSize(
                            Sizes(
                                Int32(vp2px(Length(area.width)).getOrThrow().value),
                                Int32(vp2px(Length(area.height)).getOrThrow().value)
                            )
                        )
                })
    }

//    public func width(width:Float64):This{
//        return this
//    }

    func playAnim() {
        this.controller.stopAnimation(true)
        this.controller.load(this.url)
    }
}
