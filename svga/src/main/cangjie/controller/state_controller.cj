/**
 * Created on 2025/1/9
 */
package ohos_app_cangjie_svga.controller
import ohos_app_cangjie_svga.player.*

public enum PlayerStatus {
  | NORMAL
  | INIT
  | PLAY
  | PAUSE
  | STOP
}

public class StateController {
  private var owner: Player;
  private var status: PlayerStatus = PlayerStatus.NORMAL

  init(player: Player) {
    this.owner = player
    this.initfunc()
  }

  func release() {
//    var applicationContext = this.owner.context?.getApplicationContext()
//    applicationContext?.off('applicationStateChange', this.ApplicationStateChangeCallback)
//    this.owner.uiContext?.getUIObserver().off('navDestinationUpdate', (info) => this.PageStateChangeCallback(info))
//    this.owner.uiContext?.getUIObserver().off('routerPageUpdate', (info) => this.PageStateChangeCallback(info))
  }

   func initfunc() {
//    this.ListenAppStateChange()
//    this.ListenPageStateChange()
  }

  // 监听应用前后台状态切换
//  private func ApplicationStateChangeCallback(): ApplicationStateChangeCallback {
//    onApplicationForeground() {
//      this.animator?.play()
//    },
//    onApplicationBackground() {
//      this.animator?.pause()
//    }
//  }
//
//  private func ListenAppStateChange() {
//    const applicationContext = this.owner.context?.getApplicationContext()
//    applicationContext?.on('applicationStateChange', this.ApplicationStateChangeCallback)
//  }
//
//  /**
//   * 页面切换处理
//   * @param flag true： 页面重写显示
//   */
//  private func pageUpdateCallback(flag?: boolean) { // true 为页面重写显示
//    switch (this.owner.pageUpdateMode) {
//      case 'pause':
//        // 暂停
//        flag ? this.owner.playAnimation() : this.owner.pauseAnimation()
//        break;
//      case 'release':
//        // 销毁
//        flag ? undefined : this.owner.release();
//        break;
//    }
//  }
//
//  private PageStateChangeCallback(info: RouterPageInfo | NavDestinationInfo) {
//    if (Object.keys(info).includes('pageId')) {
//      // router路由管理
//      if (this.owner.pageName && this.owner.pageName === info.name &&
//        this.owner.pageIndex === (info as RouterPageInfo).index.toString()
//      ) {
//        switch (info.state) {
//          case uiObserver.RouterPageState.ON_PAGE_HIDE:
//            // 页面隐藏
//            this.pageUpdateCallback();
//            break;
//          case uiObserver.RouterPageState.ON_PAGE_SHOW:
//            // 页面重新显示
//            this.pageUpdateCallback(true)
//        }
//
//      }
//    }
//    if (Object.keys(info).includes('navDestinationId')) {
//      // navigation路由管理
//      if (this.owner.pageName && this.owner.pageName === info.name &&
//        this.owner.pageIndex === (info as NavDestinationInfo).index.toString()) {
//        switch (info.state) {
//          case uiObserver.NavDestinationState.ON_HIDDEN:
//            this.pageUpdateCallback();
//            break;
//          case uiObserver.NavDestinationState.ON_SHOWN:
//            this.pageUpdateCallback(true)
//        }
//      }
//    }
//
//    if ((Object.keys(info).includes('pageId') && info.state === uiObserver.RouterPageState.ABOUT_TO_DISAPPEAR &&
//      info.name === this.owner.pageName && this.owner.pageIndex === (info as RouterPageInfo).index.toString()) ||
//      (Object.keys(info).includes('navDestinationId') && info.state === uiObserver.NavDestinationState.ON_DISAPPEAR &&
//        info.name === this.owner.pageName && this.owner.pageIndex === (info as NavDestinationInfo).index.toString())) {
//      this.owner.autoRelease && this.owner.release()
//    }
//  }
//
//  private ListenPageStateChange() {
//    this.owner.uiContext?.getUIObserver().on('navDestinationUpdate', (info) => this.PageStateChangeCallback(info))
//    this.owner.uiContext?.getUIObserver().on('routerPageUpdate', (info) => this.PageStateChangeCallback(info))
//  }
}