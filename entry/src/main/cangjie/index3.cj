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
import svga.proto.*
import ohos.router.Router
@Entry
@Component
class EntryView3 {
    @State
    var message: String = "Hello World"
    var controller1: SvgaController = SvgaController()
    var controller2: SvgaController = SvgaController()
    var listScroller: Scroller = Scroller()
    @State
    var buttonIndex = 1
    public func build() {
        Column {
            Column {
                if (buttonIndex == 1) {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller1)
                } else if (buttonIndex == 2) {
                    SvgaPlayer(url: "demo.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller2)
                }
            }
            .width(100.percent)
            .height(50.percent)
            List(scroller: this.listScroller) {
                ListItem() {
                    Column(5) {
                        Button('buttonIndex111111')
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                buttonIndex = 2

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
