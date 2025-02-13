package ohos_app_cangjie_entry


import tpc.RouterKit.router.*
import tpc.UIKit.*
import tpc.UIKit.component_interop.*

import ohos.base.AppResource
import ohos.state_macro_manage.*
import ohos.state_macro_manage.r
import ohos.state_manage.LocalStorage
import ohos.state_manage.ObservedProperty
import ohos.state_manage.SubscriberManager
import ohos.state_manage.ViewStackProcessor
import ohos.hybrid_base.CJPageEntry
import ohos.hybrid_base.HybridComponentBase
import cj_res_entry.app

import svga.player.*

@HybridComponentEntry
@Component
class TestPage2 {
//    @State
    var controller: SvgaController = SvgaController()
    var index: Int64 = 0
    var list: Array<ResourceStr> = [
        @r(app.media.angel),
        @r(app.media.angel),
        @r(app.media.demo),
        @r(app.media.EmptyState),
        @r(app.media.gift1),
        @r(app.media.gift2),
        @r(app.media.gift3),
        @r(app.media.gift4),
        @r(app.media.gift5),
        @r(app.media.gift6),
        @r(app.media.gift7),
        @r(app.media.gift8),
        @r(app.media.gift9),
        @r(app.media.gift10),
        @r(app.media.halloween),
        @r(app.media.HamburgerArrow),
        @r(app.media.hasaudio),
        @r(app.media.heartbeat),
        @r(app.media.index),
        @r(app.media.index2),
        @r(app.media.kingset),
        @r(app.media.matteBitmap),
        @r(app.media.matteBitmap_1),
        @r(app.media.matteRect),
        @r(app.media.mbygg),
        @r(app.media.mutiMatte),
        @r(app.media.onlyimage),
        @r(app.media.PinJump),
        @r(app.media.posche),
        @r(app.media.rose),
        @r(app.media.TwitterHeart),
        @r(app.media.Walkthrough)
  ]

    public func build() {
        Column {
//            SvgaPlayer({
//                url: @r('app.media.kingset'),
//                controller: this.controller
//              })
//                .width(300)
//                .aspectRatio(1)
            Button("切换资源").onClick {
                =>
                    this.index++
//                    this.index > this.list.size - 1 && (this.index = 0);
                    this.controller.load(this.list[this.index])
            }
            Button("替换资源").onClick {
                =>
//                    this.controller.setText({
//                        text: "测试替换文本",
//                        color: "#F00",
//                        size: "20px",
//                        weight: 800,
//                      }, "banner")
//                      // this.controller.setImage('https://cdnoffice.lizhi.fm/studio/2024/01/04/3051857755503029814.png', '99')
//                      // this.controller.setImage(@r('app.media.background'), '99')
//                      let b = getContext().resourceManager.getMediaContentSync(@r(app.media.background).id)
//                      let s = createImageSource(b.buffer)
//                      this.controller.setImage(s, "99")
            }
            Button("去关于").onClick {
                =>
                    pushUrl(
                        RouterOptions("pages/About"),{ m, n => }
                    )
            }
        }
        .width("100%")
        .height("100%")
    }
}
