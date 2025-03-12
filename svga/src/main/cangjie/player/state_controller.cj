/**
 * Created on 2025/1/9
 */
package svga.player

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

    init(player: Player) {
        this.owner = player
        this.initfunc()
    }

    func release() {
    }

    func initfunc() {
    }
}
