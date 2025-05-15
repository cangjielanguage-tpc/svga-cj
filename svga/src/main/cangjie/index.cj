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
import svga.global.globalcontext
import ohos.ability.AbilityContext

@Component
public class SvgaPlayer {
    @State @Watch[updateSource] var url: String = ""
    @Prop
    var abilitycontext: AbilityContext
    var controller: SvgaController = SvgaController()
    var setting: RenderingContextSettings = RenderingContextSettings(antialias: true)
    var context: CanvasRenderingContext2D = CanvasRenderingContext2D(this.setting)
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
        this
            .controller
            .getplayer()
            .parentSize(
                Sizes(width: Int32(vp2px(Length(this.context.width)).getOrThrow().value),
                    height: Int32(vp2px(Length(this.context.height)).getOrThrow().value)))
    }

    public func build() {
        Stack(Alignment.TopStart) {
            Canvas(this.context)
                .width(this.canvasValue.width)
                .height(this.canvasValue.height)
                .transform(this.canvasValue.transformValue)
                .scale(x: this.canvasValue.scaleValue.x, y: this.canvasValue.scaleValue.x,
                    z: this.canvasValue.scaleValue.x, centerX: this.canvasValue.scaleValue.centerX,
                    centerY: this.canvasValue.scaleValue.centerY)
                .backgroundColor(Color.TRANSPARENT)
                .onReady {
                    this
                        .controller
                        .getplayer()
                        .parentSize(
                            Sizes(width: Int32(vp2px(Length(this.context.width)).getOrThrow().value),
                                height: Int32(vp2px(Length(this.context.height)).getOrThrow().value)))
                    if (this.onreadyIsLose) {
                        return
                    }
                    this.onreadyIsLose = true
                    if (let Some(v) <- this.onReady) {
                        v
                        return
                    }
                    if (this.url == "") {
                        AlertDialog.show(AlertDialogParamWithConfirm("地址错误 请输入完整沙盒路径地址"))
                        return
                    }
                    this.playAnim()
                }
        }
            .width("100%")
            .height("100%")
            .onAreaChange(
                {
                    old, area => this
                        .controller
                        .getplayer()
                        .parentSize(
                            Sizes(
                                width: Int32(vp2px(Length(area.width)).getOrThrow().value),
                                height: Int32(vp2px(Length(area.height)).getOrThrow().value)
                            )
                        )
                })
    }
    public func playAnim() {
        this.controller.stopAnimation(true)
        this.controller.load(this.url)
    }
}
