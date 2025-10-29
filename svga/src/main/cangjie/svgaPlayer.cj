package svga

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.image.Size as Sizes
import svga.player.SvgaController
import svga.player.CanvasSizeAndTrans
import svga.parser.Parser
import svga.player.*
import svga.global.*
import ohos.hilog.*
import ohos.ability.AbilityContext
import ohos.matrix4
import ohos.matrix4.Matrix4
@Component
public class SvgaPlayer {

    @Link @Watch[updateSource] var url: String = ""
    @Prop
    var abilitycontext: AbilityContext
    var controller: SvgaController = SvgaController()
    var setting: RenderingContextSettings = RenderingContextSettings(antialias: true)
    var context: CanvasRenderingContext2D = CanvasRenderingContext2D(this.setting,LengthMetricsUnit.PX)
    @State
    var canvasValue: CanvasSizeAndTrans = CanvasSizeAndTrans()
    public var onReady: ?() -> Unit = None
    var onreadyIsLose: Bool = false


    @State var w: Float64 = 1.0
    @State var h: Float64 = 1.0
    @State var x: Float32 = 1.0
    @State var y: Float32 = 1.0
    @State var z: Float32= 0.0
    @State var centerX: Length = 0.0
    @State var centerY:Length = 0.0
    @State var transformValue: matrix4.Matrix4Transit = Matrix4.identity()
    func canvasValueCallback(value: CanvasSizeAndTrans): Unit {
        w=value.width.value
        h=value.height.value
        x=value.scaleValue.x
        y=value.scaleValue.y
        z=value.scaleValue.z
        centerX=value.scaleValue.centerX.value
        centerY=value.scaleValue.centerY.value
        transformValue=value.transformValue

    }
    func updateSource() {
        this.controller.getplayer().animator()?.release()
        this.playAnim()
        return
    }

    public func aboutToAppear(): Unit {
        var uiContext = this.abilitycontext
        this.controller.setparser(Parser(uiContext))
        var player = Player(uiContext, this.context)

        this.controller.setplayer(Player(globalcontext.getOrThrow(), this.context))
        this.controller.getplayer().canvasValue(this.canvasValue,canvasValueCallback)
    }

    public func aboutToDisappear():Unit{
        this.controller.release()
    }

    public func build() {
        Stack(Alignment.TopStart) {
            Canvas(this.context)
                .width(w)
                .height(h)
                .transform(transformValue)
                .scale(
                    x: x,
                    y: y,
                    z: z,
                    centerX: centerX,
                    centerY: centerY
                )
                .backgroundColor(Color.TRANSPARENT)
                .onReady {
                    if (this.onreadyIsLose) {
                        return
                    }
                    this.onreadyIsLose = true
                    if (let Some(v) <- this.onReady) {
                        v
                        return
                    }
                    if (this.url == "") {
                        Hilog.error(0, "ERROR", "Address error, please enter the complete sandbox path")
                        return
                    }
                    this.playAnim()
                }
        }
            .width(100.percent)
            .height(100.percent)
            .onAreaChange(
                {
                    old, area =>
                        this.controller.getplayer().parentSize(
                            Sizes(
                                width: Int32(vp2px(area.width).getOrThrow().value),
                                height: Int32(vp2px(area.height).getOrThrow().value)
                            )
                        )
                })
    }
    func playAnim() {
        this.controller.stopAnimation(true)
        this.controller.load(this.url)
    }
}
