package ohos_app_cangjie_svga

internal import ohos.base.nativeLog
internal import cj_res_svga.app

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

//@Component
public class SvgaPlayer {
                            //    @Prop
                            //  @Require
                            //  //@Watch[]'updateSource')
                            //  var url: ResourceStr = ''
                            //  var controller: ?SvgaController
                            //  var setting: RenderingContextSettings = RenderingContextSettings(true)
                            //  var context: CanvasRenderingContext2D = CanvasRenderingContext2D(this.setting, LengthMetricsUnit.PX)
                            //  @State
                            //  var canvasValue: CanvasSizeAndTrans = CanvasSizeAndTrans()
                            //  onReady?: () => void;
                            //  private var onreadyIsLose: Bool = false
                            //
                            //  func  updateSource() {
                            //    this.playAnim()
                            //  }
                            //  protected override func aboutToAppear() {
                            //    const uniqueId = this.getUniqueId();
                            //    const uiContext = this.getUIContext()
                            //    const pageInfo = uiContext.getPageInfoByUniqueId(uniqueId)
                            //
                            //    if (!this.controller) {
                            //      this.controller = SvgaController()
                            //    }
                            //    this.controller.parser = Parser()
                            //    const player = Player(this.getUIContext(), getContext(), this.context)
                            //
                            //    this.controller.player = player
                            //    if (pageInfo) {
                            //      if (pageInfo.navDestinationInfo) {
                            //        player.pageName = pageInfo.navDestinationInfo.name.toString()
                            //        player.pageIndex = pageInfo.navDestinationInfo.index.toString()
                            //      } else if (pageInfo.routerPageInfo) {
                            //        player.pageName = pageInfo.routerPageInfo.name
                            //        player.pageIndex = pageInfo.routerPageInfo.index.toString()
                            //      }
                            //    }
                            //    this.controller.player.canvasValue = this.canvasValue
                            //  }

                            //    func build() {
                            //    Stack({ alignContent: Alignment.TopStart }) {
                            //      Canvas(this.context)
                            //        .width(this.canvasValue.width)
                            //        .height(this.canvasValue.height)
                            //        .transform(this.canvasValue.transformValue)
                            //        .scale(this.canvasValue.scaleValue)
                            //        .backgroundColor(Color.Transparent)
                            //        .onReady(() => {
                            //          if (this.onreadyIsLose) {
                            //            return;
                            //          }
                            //          this.onreadyIsLose = true
                            //          if (this.onReady) {
                            //            this.onReady()
                            //            return
                            //          }
                            //          if (typeof this.url === 'string' && this.url === '') {
                            //            return;
                            //          }
                            //          this.playAnim()
                            //        })
                            //    }
                            //    .width('100%')
                            //    .height('100%')
                            //    .onAreaChange((_: Area, area: Area) => {
                            //      this.controller!.player.parentSize = {
                            //        width: vp2px(area.width as number),
                            //        height: vp2px(area.height as number)
                            //      }
                            //    })
                            //  }

                            //    func playAnim() {
                            //    this.controller!.stopAnimation(true)
                            //    this.controller!.load(this.url)
                            //  }

                        }
