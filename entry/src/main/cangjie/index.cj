package ohos_app_cangjie_entry

import tpc.UIKit.Text
import tpc.UIKit.Button
import tpc.UIKit.Column
import tpc.UIKit.CustomView
internal import tpc.AbilityKit.UIAbilityContext

import ohos.state_macro_manage.State
import ohos.state_macro_manage.Component
import ohos.state_manage.LocalStorage
import ohos.state_manage.ObservedProperty
import ohos.state_manage.SubscriberManager
import ohos.state_manage.ViewStackProcessor
import ohos.state_macro_manage.HybridComponentEntry
import ohos.hybrid_base.CJPageEntry
import ohos.hybrid_base.HybridComponentBase
import cj_res_entry.app
import tpc.UIKit.component_interop.*
import svga.*
import svga.player.*

@HybridComponentEntry
@Component
class Index {
    @State
    var msg: String = "Hello"
    var controller: SvgaController = SvgaController()
    public func build() {
        Column {
            SvgaPlayer(url: "angel.svga",abilitycontext: getContext(),controller: this.controller)
        }.width(300)
        .aspectRatio(1)
        .backgroundColor(Color.BLACK)
    }

}
func getContext(): UIAbilityContext {
    match (globalcontext) {
        case Some(context)  => context
    	case _=> throw Exception("can not get globalcontext")
    }
}