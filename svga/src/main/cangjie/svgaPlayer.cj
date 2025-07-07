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
@Component
public class SvgaPlayer {
    @State
    @Watch[updateSource]
    var url: String = ""
    @Prop
    var abilitycontext: AbilityContext
    var controller: SvgaController = SvgaController()
    var setting: RenderingContextSettings = RenderingContextSettings(antialias: true)
    var context: CanvasRenderingContext2D = CanvasRenderingContext2D(this.setting,LengthMetricsUnit.PX)
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
        this.controller.getplayer().parentSize(Sizes(width: Int32(this.context.width().value),height: Int32(this.context.height().value)))
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
                .scale(
                    x: this.canvasValue.scaleValue.x,
                    y: this.canvasValue.scaleValue.y,
                    z: this.canvasValue.scaleValue.z,
                    centerX: this.canvasValue.scaleValue.centerX,
                    centerY: this.canvasValue.scaleValue.centerY
                )
                .backgroundColor(Color.TRANSPARENT)
                .onReady {
                    this.controller.getplayer().parentSize(Sizes(width: Int32(this.context.width()),height: Int32(this.context.height())))
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
                    old, area => this.controller.getplayer().parentSize(
                            Sizes(
                                width: Int32(vp2px(area.width).getOrThrow().value),
                                height: Int32(vp2px(area.height).getOrThrow().value)
                            )
                        )
                })
    }

    public func width(width:Float64):This{
        return this
    }

    func playAnim() {
        this.controller.stopAnimation(true)
        this.controller.load(this.url)
    }
}
