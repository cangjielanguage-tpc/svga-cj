/**
 * Created on 2025/1/9
 */
package svga.player
//import tpc.AbilityKit.kit_common.ApplicationStateChangeCallback
//import tpc.AbilityKit.ability_common.ApplicationContextType
//import tpc.TelephonyKit.observer.ObserverEventType
//import ohos.emitter.EventCallback
//import tpc.UIKit.Observer.TabContentInfo
//import ohos.observer.*

public enum PlayerStatus {
    | NORMAL
    | INIT
    | PLAY
    | PAUSE
    | STOP
}

public class StateController {
    private var owner: Player
    private var status: PlayerStatus = PlayerStatus.NORMAL
    private var applicationStateChangeCallback: ApplicationStateChangeCallback
    init(player: Player) {
        this.owner = player
        this.applicationStateChangeCallback= ApplicationStateChangeCallback(
            {
                =>
                player.animator()?.play()
            },
            {
                =>
                player.animator()?.pause()
            }
        )
        if(let Some(v) <- this.owner.uiContext()) {
            var applicationContext = v.getApplicationContext()
            applicationContext.on(ApplicationContextType.APPLICATION_STATE_CHANGE,this.applicationStateChangeCallback)
        }
//        this.initfunc()
    }

    func release() {
        if(let Some(v) <- this.owner.uiContext()) {
            var applicationContext = v.getApplicationContext()
            applicationContext.off(ApplicationContextType.APPLICATION_STATE_CHANGE,callback:this.applicationStateChangeCallback)
        }
    }

//    func initfunc() {
//        this.ListenAppStateChange()
//        this.ListenPageStateChange()
//    }

//    private func ListenAppStateChange() {
//        var applicationContext=this.owner.uiContext().getOrThrow().getApplicationContext()
//    }
//
//    private func ListenPageStateChange() {
//        on.(ObserverType.OBSERVER_NAV_DESTINATION_UPDATE,EventCallback1(this))
//        on.(ObserverType.OBSERVER_ROUTER_PAGE_UPDATE,EventCallback1(this))
//    }

    func pageUpdateCallback(flag: Bool) {// true 为页面重写显示
        match (this.owner.pageUpdateMode()) {
            case pause =>
            // 暂停
                this.owner.pauseAnimation()
            case release =>
            // 销毁
                this.owner.release();
            case _=> ()
        }
    }
}

class EventCallback1 <: Callback1Argument<TabContentInfo> {
    var con: StateController
    public init(con: StateController){
        this.con = con
    }

    public open func invoke(val: TabContentInfo):Unit {
        con.pageUpdateCallback(true)
    }
}
