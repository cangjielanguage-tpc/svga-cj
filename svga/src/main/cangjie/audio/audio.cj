/**
 * Created on 2025/1/23
 */
package svga.audio

//import tpc.MediaKit.media.*
//import tpc.UIKit.component_utils.*
//import tpc.BasicServicesKit.*
import std.collection.*
import ohos.base.BusinessException

public class AVPlayerClass {
//    var player: ?AVPlayer = None
    var id: String = "";
    private var seekPlay: Bool = false

    public init() {
        // this.id = utils.generateRandomUUID()
    }

//    public func initPlayer(url: String): Bool {
//        try {
//            createAVPlayer({exception: ?BusinessException, avplayer: ?AVPlayer => this.player = avplayer.getOrThrow()})
//            let player = this.player.getOrThrow()
//
//            //缓存后 播放状态不对
//            //            player.on(SeekDone.SeekDone, Callback1Argument<Float64>())
//            //            player.on(StateChange.StateChange, Callback2Argument<AVPlayerState, StateChangeReason>())
//            //                (state) => {
//            //                    switch (state) {
//            //                      case 'initialized':
//            //                        this.player?.prepare()
//            //                        break;
//            //                      case 'prepared':
//            //                        if (this.seekPlay) {
//            //                          this.player?.play();
//            //                          this.seekPlay = false
//            //                        }
//            //                        break;
//            //                      case 'stopped':
//            //                    // this.player?.prepare()
//            //                    }
//
//            player.url = url
//            return true
//        } catch (e: Exception) {
//            return false
//        }
//    }
//
//    // 单曲播放
    public func play() {
//        var states: Array<AVPlayerState> = [AVPlayerState.PREPARED, AVPlayerState.PAUSED, AVPlayerState.COMPLETED]
//        if (this.player.isSome()) {
//            match (this.player.getOrThrow().state) {
//                case AVPlayerState.PREPARED => this.player.getOrThrow().play({a: ?BusinessException, b: ?Unit =>})
//                case AVPlayerState.PAUSED => this.player.getOrThrow().play({a: ?BusinessException, b: ?Unit =>})
//                case AVPlayerState.COMPLETED => this.player.getOrThrow().play({a: ?BusinessException, b: ?Unit =>})
//                case AVPlayerState.STOPPED =>
//                    this.seekPlay = true
//                    this.player.getOrThrow().prepare({a: ?BusinessException, b: ?Unit =>})
//                case _ => ()
//            }
//        }
    }

    // 设置进度
    public func seek(seek: Int32, autoplay!: Bool = true) {
//        if (this.player.isSome()) {
//            match (this.player.getOrThrow().state) {
//                case AVPlayerState.PREPARED =>
//                    this.seekPlay = autoplay
//                    this.player.getOrThrow().seek(seek)
//                case AVPlayerState.PLAYING =>
//                    this.seekPlay = autoplay
//                    this.player.getOrThrow().seek(seek)
//                case AVPlayerState.COMPLETED =>
//                    this.seekPlay = autoplay
//                    this.player.getOrThrow().seek(seek)
//                case AVPlayerState.PAUSED =>
//                    this.seekPlay = autoplay
//                    this.player.getOrThrow().seek(seek)
//                case _ => ()
//            }
//        }
    }

    // 播放 暂停
    public func pause() {
//        if (this.player.isSome()) {
//            match (this.player.getOrThrow().state) {
//                case AVPlayerState.PLAYING => this.player.getOrThrow().pause({a: ?BusinessException, b: ?Unit =>})
//                case _ => ()
//            }
//        }
    }

    // 停止
    public func stop() {
//        if (this.player.isSome()) {
//            match (this.player.getOrThrow().state) {
//                case AVPlayerState.COMPLETED => this.player.getOrThrow().stop({a: ?BusinessException, b: ?Unit =>})
//                case AVPlayerState.PLAYING => this.player.getOrThrow().stop({a: ?BusinessException, b: ?Unit =>})
//                case AVPlayerState.PREPARED => this.player.getOrThrow().stop({a: ?BusinessException, b: ?Unit =>})
//                case AVPlayerState.PAUSED => this.player.getOrThrow().stop({a: ?BusinessException, b: ?Unit =>})
//                case _ => ()
//            }
//        }
    }

//    // 删除
    public func release() {
//        if (let Some(player) <- this.player) {
//            player.release
//        }
    }
}
