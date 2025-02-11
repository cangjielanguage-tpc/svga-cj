/**
 * Created on 2025/2/11
 */
package ohos_app_cangjie_entry.pages

import tpc.UIKit.*
import ohos.hybrid_base.*
import ohos.state_macro_manage.*
import ohos.state_macro_manage.HybridComponentEntry

@HybridComponentEntry
@Component
class About {
    @State
    var message: String = "关于";

    func build() {
        RelativeContainer() {
            Text(this.message)
                .id('AboutHelloWorld')
                .fontSize(50)
                .fontWeight(FontWeight.Bold)
                .alignRules(
                    AlignRuleOption(center: VerticalAnchor('__container__', VerticalAlign.Center),
                        middle: HorizontalAnchor('__container__', HorizontalAlign.Center)))
        }.height('100%').width('100%')
    }
}
