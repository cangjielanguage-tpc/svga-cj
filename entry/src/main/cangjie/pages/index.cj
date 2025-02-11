/**
 * Created on 2025/2/11
 */
package ohos_app_cangjie_entry.pages

import tpc.UIKit.Button
import tpc.UIKit.Column
import ohos.state_macro_manage.State
import ohos.state_macro_manage.Component
import ohos.hybrid_base.HybridComponentBase
import ohos.state_macro_manage.HybridComponentEntry
import cj_res_entry.app
import ohos.router.*
import tpc.UIKit.component_interop.*
import std.unittest.entryMain

@HybridComponentEntry
@Component
class Index {
    @State
    var message: String = 'Hello World';

    func build() {
        Column() {
            //Navigator('pages/TestPage2')
            //      Navigator( target: 'pages/TestPage2', type: NavigationType.Push ) {
            //        Button('svga页面-svgaplayer组件').padding(10)
            //      }.margin(10)

            Button('navigation路由').onClick {
                event => Router.push(url: 'pages/NavigationPage')
            }
        }.height('100%').width('100%').justifyContent(FlexAlign.Center)
    }
}
