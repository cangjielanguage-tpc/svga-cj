package svga

import tpc.UIKit.*
import tpc.UIKit.component_interop.LengthMetricsUnit as LengthMetricsUnits
import tpc.UIKit.component_interop.RenderingContextSettings
import tpc.UIKit.component_interop.CanvasRenderingContext2D
import tpc.UIKit.window.*
import tpc.UIKit.UIContext.*
import tpc.UIKit.arkui_node.*

import ohos.state_macro_manage.*


import svga.player.SvgaController
import svga.player.CanvasSizeAndTrans
import svga.parser.Parser
import svga.player.*

@Component
public class SvgaPlayer {

//  @Prop
//  @Require
//    @Watch[updateSource]
    @State
    var url: ResourceStr = ""
    public var controller: ?SvgaController = None
    var setting: RenderingContextSettings = RenderingContextSettings(antialias:true)
    var context: CanvasRenderingContext2D = CanvasRenderingContext2D(settings:this.setting, unit:LengthMetricsUnits.PX)
    @State
    var canvasValue: CanvasSizeAndTrans = CanvasSizeAndTrans()
    public var onReady: ?() -> Unit = None
    var onreadyIsLose: Bool = false

    public func updateSource() {
        this.playAnim()
    }

    public func aboutToAppear(): Unit {
//        var uniqueId = this.getUniqueId();
//        var uiContext = this.getUIContext()  fromUIContextBase
         var uiContextBase = findWindow("").getUIContext()
        var uiContext = fromUIContextBase(uiContextBase)
         var uniqueId = FrameNode(uiContextBase).getUniqueId();
        var pageInfos: ?PageInfo= uiContext.getPageInfoByUniqueId(Int32(uniqueId))

        if (this.controller.isNone()) {
          this.controller = SvgaController()
        }
        this.controller?.setparser(Parser())
//        var player = Player(uiContext, Context(), this.context)
//        var player: Player = this.controller?.getplayer().getOrThrow() //暂时替代
//
//        this.controller?.setparser(player)
        if (let Some(pageInfo) <- pageInfos) {
            if (pageInfo.navDestinationInfo.isSome()) {
//            player.pageName(pageInfo.navDestinationInfo.getOrThrow().name.STRING)
//            player.pageName("")
//            player.pageIndex = pageInfo.navDestinationInfo.index.toString()
          } else if (pageInfo.routerPageInfo.isSome()) {
//            player.pageName = pageInfo.routerPageInfo.name
//            player.pageIndex = pageInfo.routerPageInfo.index.toString()
          }
        }

     this.controller?.getplayer().canvasValue(this.canvasValue)
    }


    public func build() {
//        Stack( Alignment.TopStart ,() -> Unit) {
//          Canvas(this.context)
//            .width(this.canvasValue.width)
//            .height(this.canvasValue.height)
//            .transform(this.canvasValue.transformValue)
//            .scale(this.canvasValue.scaleValue)
//            .backgroundColor(Color.Transparent)
//            .onReady {
//              if (this.onreadyIsLose) {
//                return;
//              }
//              this.onreadyIsLose = true
//              if (this.onReady) {
//                this.onReady()
//                return
//              }
////              if (typeof this.url == 'string' && this.url === '') {
////                return;
////              }
//              this.playAnim()
//            }
//        }
//        .width('100%')
//        .height('100%')
//        .onAreaChange((_: Area, area: Area) => {
//          this.controller!.player.parentSize = {
//            width: vp2px(area.width as number),
//            height: vp2px(area.height as number)
//          }
//        })
    }
    public func playAnim() {
        this.controller?.stopAnimation(true)
        this.controller?.load(this.url)
    }
}
