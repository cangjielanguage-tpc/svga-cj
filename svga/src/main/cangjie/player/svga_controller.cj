/**
 * Created on 2025/1/9
 */
package svga.player

//import ohos.matrix4
import ohos.animator.*
import svga.parser.*
import svga.proto.*
import std.math.*
import ohos.base.Length
import ohos.prompt_action.PromptAction

public struct SvgaPlayerProps {
    var pageUpdateMode: PageUpdateMode
    var loops: Int32
    var autoRelease: Bool // true 页面销毁时自动执行清理 不传默认为true
    var clearsAfterStop: Bool
    var fillMode: AnimatorFill

    public init(pageUpdateMode!: PageUpdateMode = PageUpdateMode.pause, loops!: Int32 = -1, autoRelease!: Bool = true,
        clearsAfterStop!: Bool = true, fillMode!: AnimatorFill = AnimatorFill.Forwards) {
        this.pageUpdateMode = pageUpdateMode
        this.loops = loops
        this.autoRelease = autoRelease
        this.clearsAfterStop = clearsAfterStop
        this.fillMode = fillMode
    }
}

//@Observed
public class CanvasSizeAndTrans {
    public var width: Length = 100.percent
    public var height: Length = 100.percent
    //var transformValue: matrix4.Matrix4Transit = Mtrix4.identity()
    public var scaleValue: ScaleOptions = ScaleOptions(x: 1.0, y: 1.0)
}

public class SvgaController {
    public init(props!: ?SvgaPlayerProps = None) {
        if (let Some(props) <- props) {
            this._pageUpdateMode = props.pageUpdateMode
            this._loops = props.loops
            this._autoRelease = props.autoRelease
            this._clearsAfterStop = props.clearsAfterStop
            this._fillMode = props.fillMode
        }
    }

    private var _loops: Int32 = -1;

    public func getloops(): Int32 {
        return this._loops;
    }

    private var _autoRelease: Bool = true;

    public func getautoRelease(): Bool {
        return this._autoRelease;
    }

    private var _clearsAfterStop: Bool = true;

    public func getclearsAfterStop(): Bool {
        return this._clearsAfterStop;
    }

    private var _fillMode: AnimatorFill = AnimatorFill.Forwards;

    public func getfillMode(): AnimatorFill {
        return this._fillMode;
    }

    private var _player: ?Player = None;

    public func getplayer(): Player {
        if (this._player.isNone()) {
            throw Exception('播放器未初始化')
        }
        return this._player.getOrThrow()
    }

    public func setplayer(value: Player) {
        this._player = value
        this._player?.setLoops(this.getloops())
        this._player?.pageUpdateMode(this.getpageUpdateMode())
        this._player?.autoRelease(this.getautoRelease())
        this._player?.clearsAfterStop(this.getclearsAfterStop())
        this._player?.fillMode(this.getfillMode())
    }

    private var _parser: ?Parser = None

    public func setparser(value: Parser) {
        this._parser = value
    }

    private var _pageUpdateMode: PageUpdateMode = PageUpdateMode.pause;

    public func getpageUpdateMode(): PageUpdateMode {
        return this._pageUpdateMode;
    }

    public func load(source: String, success!: ?SuccessFn = None, failure!: ?FailureFn = None, autoPlay!: Bool = true) {
        var _success = success
        var _failure = failure
        if (this._player.isNone() || this._parser.isNone()) {
            PromptAction.showToast(message: '未初始化完成，请稍后再试')
            return;
        }
        if (autoPlay) {
            if (_success.isNone()) {
                _success = {
                    videoItem => if (let Some(v) <- this._player) {
                        v.setVideoItem(videoItem)
                        v.startAnimation(false)
                    }
                }
            }
        } else {
            if (_success.isNone()) {
                _success = {
                    videoItem => this._player.getOrThrow().setVideoItem(videoItem)
                }
            }
        }
        if (_failure.isNone()) {
            _failure = {
                BusinessError =>
                //                                AlertDialog.show({
                //                                  message: JSON.stringify(err)
                //                                })
            }
        }
        this._parser.getOrThrow().load(source, _success.getOrThrow(), _failure.getOrThrow())
    }

    func setVideoItem(videoItem: MovieEntity) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setVideoItem(videoItem)
    }

    public func startAnimation(reverse!: Bool = false) {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.startAnimation(reverse)
    }

    public func startAnimationWithRane(range: SvgaRange, reverse!: Bool = false) {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.startAnimationWithRange(range, reverse: reverse)
    }

    public func pauseAnimation() {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.pauseAnimation()
    }

    public func stopAnimation(clears: Bool) {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.stopAnimation(clears)
    }

    public func setContentMode(mode: PLAYER_CONTENT_MODE) {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setContentMode(mode)
    }

    public func clear() {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.clear()
    }

    public func stepToFrame(frame: Float64, andPlay!: Bool = true) {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.stepToFrame(frame, andPlay: andPlay)
    }

    public func stepToPercentage(percentage: Int64, andPlay: Bool) {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.stepToPercentage(percentage, andPlay)
    }

    public func clearDynamicObjects() {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.clearDynamicObjects()
    }

    public func setLoops(loops: Int32) {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setLoops(loops)
    }

    public func setCurRate(curRate: Float64) {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setCurRate(curRate)
    }

    //回收资源
    public func release() {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.release()
    }
}
