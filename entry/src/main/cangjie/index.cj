package ohos_app_cangjie_entry

//import ohos.state_macro_manage.Entry
//import ohos.state_macro_manage.Component
//import ohos.state_macro_manage.State
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*

import svga.*
import svga.player.*

internal import ohos.ability.AbilityContext

import ohos.system_date_time.*
import ohos.hilog.Hilog

@Entry
@Component
class EntryView {
    @State
    var message: String = "Hello World"
    var controller: SvgaController = SvgaController(props:SvgaPlayerProps(loops:1))
//    var controller: SvgaController = SvgaController()

    public func build() {
        Column {
            SvgaPlayer(url: "angel.svga", abilitycontext: globalcontext.getOrThrow(), controller: controller)
        }.width(100.percent)
        .aspectRatio(1)
        .backgroundColor(Color.BLUE)
    }
}