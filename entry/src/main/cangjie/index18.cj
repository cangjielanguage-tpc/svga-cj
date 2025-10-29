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
import svga.model.*
@Entry
@Component
class EntryView18 {
    @State
    var message: String = "Hello World"
    var controller: SvgaController = SvgaController()
    var listScroller: Scroller = Scroller()
    public func build() {
        Column {
            Column {
                    SvgaPlayer(url: "kingset.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller)
            }
            .height(50.percent)
            List(scroller: this.listScroller) {
                ListItem() {
                    Column(5) {

                        Button('setText')
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                var textConfig: TextMap = TextMap()
                                 let offset: TextOffset = TextOffset()
                                 offset.x=0.0
                                 offset.y=0.0
                                 textConfig.text = "w 我！@#&*%）*-+@11111111"
                                 textConfig.size = 15.0
                                 textConfig.color = Color(0xFF0000)
                                 textConfig.offset = offset
                                 textConfig.family = 'Arial'
                                 textConfig.style = FontStyle.Normal
                                 textConfig.weight = FontWeight.Bold
                                controller.setText(textConfig, 'banner');
//                                controller.setText("w 我！@#&*%）*-+@11111111", 'banner');
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
