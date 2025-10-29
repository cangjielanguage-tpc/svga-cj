package ohos_app_cangjie_entry

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import svga.*
import svga.player.*
import ohos.hilog.*
internal import ohos.ability.AbilityContext
import ohos.system_date_time.*
import svga.parser.PLAYER_CONTENT_MODE
@Entry
@Component
class EntryView7 {
    @State
    var message: String = "Hello World"
    var flagtest: Bool = false
    var controller: SvgaController = SvgaController()
    var listScroller: Scroller = Scroller()
    public func build() {
        Column {
            Column {
                SvgaPlayer(url: "", abilitycontext: globalcontext.getOrThrow(), controller: controller)
            }
            .width(100.percent)
            .height(50.percent)
            List(scroller: this.listScroller) {
                ListItem() {
                    Column(5) {

                             Button('7777777701')
                              .width(90.percent)
                              .height(35)
                              .shape(ShapeType.Normal)
                              .onClick {
                                  =>
                                  // 对标库也不支持load和startAnimationWithRange放一块调用
                                  controller.load("angel.svga",autoPlay:false)
                                  controller.load("angel.svga",autoPlay:false)
                              }
                          Button('7777777702')
                              .width(90.percent)
                              .height(35)
                              .shape(ShapeType.Normal)
                              .onClick {
                                  =>
                                  flagtest = false
                                  // 第一个参数是起始播放第几帧，第二个参数是播放长度
//                                    let range:SvgaRange=SvgaRange(-1000.50001,-10200.7123) // 应用闪退，报错IndexOutOfBoundsException
//                                    let range:SvgaRange=SvgaRange(-1000.50001,20.7123) // 应用闪退，报错IndexOutOfBoundsException
                                    let range:SvgaRange=SvgaRange(-10000.0,1020.7123) // 应用闪退，报错IndexOutOfBoundsException
                                    controller.startAnimationWithRange(range)
                                    flagtest = true
                              }

                    }
                }
            }
                .width(100.percent)
                .height(30.percent)
                .scrollBar(BarState.Off)
                .alignListItem(ListItemAlign.Center)
        }

    }
}