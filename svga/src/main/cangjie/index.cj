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
import svga.parser.globalcontext

@Component
public class SvgaPlayer {

//    @Prop
//    @Require
    @State
    @Watch[updateSource]
    var url: String = ""
    public var controller: ?SvgaController = None
    var setting: RenderingContextSettings = RenderingContextSettings(antialias:true)
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
//        var uniqueId = this.getUniqueId();
//        var uiContext = this.getUIContext()  fromUIContextBase
//         var uiContextBase = findWindow("").getUIContext()
//        var uiContext = fromUIContextBase(uiContextBase)
//         var uniqueId = FrameNode(uiContextBase).getUniqueId();
//        var pageInfos: ?PageInfo= uiContext.getPageInfoByUniqueId(Int32(uniqueId))

//        if (this.controller.isNone()) {
//          this.controller = SvgaController()
//        }
//        this.controller?.setparser(Parser())
//        var player = Player(uiContext, Context(), this.context)
//        var player: Player = this.controller?.getplayer().getOrThrow() //暂时替代
//
//        this.controller?.setparser(player)
//        if (let Some(pageInfo) <- pageInfos) {
//            if (pageInfo.navDestinationInfo.isSome()) {
//            player.pageName(pageInfo.navDestinationInfo.getOrThrow().name.STRING)
//            player.pageName("")
//            player.pageIndex = pageInfo.navDestinationInfo.index.toString()
//          } else if (pageInfo.routerPageInfo.isSome()) {
//            player.pageName = pageInfo.routerPageInfo.name
//            player.pageIndex = pageInfo.routerPageInfo.index.toString()
//          }
//        }
    this.controller?.setplayer(Player(globalcontext.getOrThrow(), this.context))
     this.controller?.getplayer().canvasValue(this.canvasValue)
    }


    public func build() {
        Stack( Alignment.TopStart) {
          Canvas(this.context)
            .width(this.canvasValue.width)
            .height(this.canvasValue.height)
//            .transform(this.canvasValue.transformValue)
            .scale(x:this.canvasValue.scaleValue.x, y: this.canvasValue.scaleValue.x, z: this.canvasValue.scaleValue.x, centerX: this.canvasValue.scaleValue.centerX, centerY: this.canvasValue.scaleValue.centerY)
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
                return
              }
              this.playAnim()
            }
        }
        .width("100%")
        .height("100%")
        .onAreaChange( {old, area =>
          this.controller?.getplayer().parentSize(Sizes(
            width: Int32(vp2px(Length(area.width)).getOrThrow().value),
            height: Int32(vp2px(Length(area.height)).getOrThrow().value)
          ))
        })
    }
    public func playAnim() {
        this.controller?.stopAnimation(true)
        this.controller?.load(this.url)
    }
}
