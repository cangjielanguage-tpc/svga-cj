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
//    private var applicationStateChangeCallback: ApplicationStateChangeCallback
    init(player: Player) {
        this.owner = player

    }

    func release() {

    }

}


