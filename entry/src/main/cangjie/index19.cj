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
class EntryView19 {
    @State
    var message: String = "Hello World"
    var controller: SvgaController = SvgaController()
    var listScroller: Scroller = Scroller()
    public func build() {
        Column {
            Column {
                    SvgaPlayer(url: "kingset.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller)
            }
            .height(70.percent)


                        Button('setImage')
                            .width(90.percent)
                            .height(35)
                            .shape(ShapeType.Normal)
                            .backgroundColor(Color.GREEN)
                            .onClick {
                                =>
                                controller.setImage("/data/storage/el1/bundle/entry/resources/resfile/2.png", "99")
                            }


        }

    }
}
