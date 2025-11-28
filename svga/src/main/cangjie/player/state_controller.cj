/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.player

import ohos.observer.*

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
        this.applicationStateChangeCallback = ApplicationStateChangeCallback(
            onApplicationForeground: {
                => player.animator()?.play()
            },
            onApplicationBackground: {
                => player.animator()?.pause()
            }
        )
    }

    func release() {
    }

    func pageUpdateCallback(_: Bool) {
        // true 为页面重写显示
        match (this.owner.pageUpdateMode()) {
            case pause =>
                // 暂停
                this.owner.pauseAnimation()
            case release =>
                // 销毁
                this.owner.release();
            case _ => ()
        }
    }
}

class EventCallback1 <: Callback1Argument<TabContentInfo> {
    var con: StateController
    public init(con: StateController) {
        this.con = con
    }

    public open func invoke(_: TabContentInfo): Unit {
        con.pageUpdateCallback(true)
    }
}
