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
@Entry
@Component
class EntryView11 {
    @State
    var message: String = "Hello World"
    var controller: SvgaController = SvgaController()
    var listScroller: Scroller = Scroller()
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

                        Button('9闪退')
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                controller.setText("测试替换文本","banner")
                                controller.clearDynamicObjects()
                                this.controller.setImage('1.png', '99')
                                this.controller.onFinished(test1)
                                this.controller.onFrame(test2)
                                this.controller.onPercentage(test3)
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
func test2(str: Float64) {

}
func test3(str: Float64) {

}
func test1() {

}