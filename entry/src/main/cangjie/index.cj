package ohos_app_cangjie_entry

internal import ohos.base.LengthProp
internal import ohos.component.Column
internal import ohos.component.Row
internal import ohos.component.Text
internal import ohos.component.CustomView
internal import ohos.component.CJEntry
internal import ohos.component.loadNativeView
internal import ohos.component.FontWeight
internal import ohos.state_manage.SubscriberManager
internal import ohos.state_manage.ObservedProperty
internal import ohos.state_manage.LocalStorage
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Component
import ohos.state_manage.LocalStorage
import ohos.state_manage.ObservedProperty
import ohos.state_manage.SubscriberManager
import ohos.state_manage.ViewStackProcessor
import ohos.state_macro_manage.Entry
import ohos.state_macro_manage.Component
import ohos.state_macro_manage.State
import ohos.state_macro_manage.r
internal import ohos.ability.UIAbilityContext
import svga.*
import svga.player.*
@Entry
@Component
class EntryView {
    @State
    var message: String = "Hello World"
    var controller: SvgaController = SvgaController()
    func build() {
        Column {
              SvgaPlayer(url: "angel.svga",abilitycontext: getContext(),controller: Option<SvgaController>.Some(controller))
        }
    }
}
func getContext(): UIAbilityContext {
    match (globalcontext) {
        case Some(context)  => context
    	case _=> throw Exception("can not get globalcontext")
    }
}