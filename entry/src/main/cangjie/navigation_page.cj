package ohos_app_cangjie_entry

import tpc.UIKit.Text
import tpc.UIKit.Button
import tpc.UIKit.Column
import tpc.UIKit.CustomView
import tpc.UIKit.component_interop.*
import tpc.UIKit.global.*

import ohos.state_macro_manage.*
import ohos.state_manage.LocalStorage
import ohos.state_manage.ObservedProperty
import ohos.state_manage.SubscriberManager
import ohos.state_manage.ViewStackProcessor
import ohos.state_macro_manage.HybridComponentEntry
import ohos.hybrid_base.CJPageEntry
import ohos.hybrid_base.HybridComponentBase
import cj_res_entry.app

import svga.player.*

@HybridComponentEntry
@Component
class NavigationPage {
    @State
    var message: String = "Hello World---A"
    @State
    var ren: Bool = false
    @State
    var pageStack: NavPathStack = NavPathStack()

    public func aboutToAppear(): Unit {
        setTimeout( {m =>
          this.ren = true
        }, 3000, Array<String>())
    }
    public func build() {
        Navigation(this.pageStack) {
            Column {
                Text(this.message)
                if (this.ren) {
//                    SvgaPlayer({
//                        url: @r('app.media.onlyimage')
//                    })
//                    .width('100%')
//                    .aspectRatio(1)
                }
                Button('进入二级')
                  .onClick{
                    => this.pageStack.pushPathByName("PageOne", "", false)
                  }
            }
        }
    }
}

// 跳转页面入口函数

@Builder
public func PageOneBuilder() {
  PageOne()
}

@Component
public class PageOne {
    @Consume
    var pageStack: NavPathStack
    var constroller: SvgaController =  SvgaController()
    public func build() {
        NavDestination() {
          Column() {
    //        SvgaPlayer({
    //          url: "",
    //          controller: this.constroller
    //        })
    //          .width('100%')
    //          .aspectRatio(1)
            Button("进入三级")
              .onClick {
                    => this.pageStack.pushPathByName("PageTwo", "", false)
              }
            Button("渲染")
              .onClick{
                => this.constroller.load(@r(app.media.index))
              }
          }
        }
    .title("PageOne")

  }
}

@Builder
public func PageTwoBuilder() {
  PageTwo()
}
@Component
public class PageTwo {
  @Consume
  var pageStack: NavPathStack

  public func build() {
    NavDestination() {
      Text("三级页面")
    }
    .title("PageTwo")
  }
}
