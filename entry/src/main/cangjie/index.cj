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
class EntryView {
    @State
    var message: String = "Hello World"
    var controller: SvgaController = SvgaController()

    public func build() {
        Column {
            Column {
                    SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller)
            }
            .width(30.percent)
        }

    }
}
