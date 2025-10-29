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
import svga.parser.PageUpdateMode
@Entry
@Component
class EntryView8 {
    @State
    var message: String = "Hello World"
    var controller: SvgaController = SvgaController()
    var listScroller: Scroller = Scroller()
    var controller21: SvgaController = SvgaController(props: SvgaPlayerProps(pageUpdateMode: PageUpdateMode.release))
    public func build() {
        Column {
            Column {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller)
            }
            .width(100.percent)
            .height(50.percent)
            List(scroller: this.listScroller) {
                ListItem() {
                    Column(5) {

                        Button('888')
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                controller.stopAnimation(false)
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