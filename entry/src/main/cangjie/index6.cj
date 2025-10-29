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
class EntryView6 {
    @State
    var message: String = "Hello World"
    var controller: SvgaController = SvgaController()
    var listScroller: Scroller = Scroller()
    @State  var url13:String= "angel.svga"
    public func build() {
        Column {
            Column {
                    SvgaPlayer(url: this.url13, abilitycontext: globalcontext.getOrThrow(), controller: controller)
            }
            .width(100.percent)
            .height(50.percent)
            List(scroller: this.listScroller) {
                ListItem() {
                    Column(5) {

                        Button('url13')
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                Hilog.error(10, "----cwl----------", "----cwl---this.url13------->${this.url13}")
                                this.url13="kingset.svga"
                                Hilog.error(10, "----cwl----------", "----cwl---this.url13------->${this.url13}")
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
