/**
 * Created on 2025/1/9
 */
package svga.player

import tpc.UIKit.matrix4
import tpc.UIKit.ResourceStr
import tpc.UIKit.animator.*
import tpc.UIKit.*
import svga.parser.*
import svga.proto.*
import std.math.*

public struct SvgaPlayerProps {
    var pageUpdateMode: ?PageUpdateMode = None
    var loops: ?Float64 = None
    var autoRelease: ?Bool = None // true 页面销毁时自动执行清理 不传默认为true
    var clearsAfterStop: ?Bool = None
    var fillMode: ?AnimatorFill = AnimatorFill.None
}

//@Observed
public class CanvasSizeAndTrans {
    var width: String = '100%'
    var height: String = '100%'
    var transformValue: matrix4.Matrix4Transit = matrix4.identity()
    var scaleValue: ScaleOptions = ScaleOptions(x: 1.0, y: 1.0)
}

public class SvgaController {
    public init(props!: ?SvgaPlayerProps = None) {
        if (let Some(val) <- props?.pageUpdateMode) {
            this._pageUpdateMode = val.getOrThrow()
        } else {
            this._pageUpdateMode = PageUpdateMode.pause
        }

        if (let Some(val) <- props?.loops) {
            this._loops = val.getOrThrow()
        } else {
            this._loops = Float64.Inf
        }

        if (let Some(val) <- props?.autoRelease) {
            this._autoRelease = val.getOrThrow()
        } else {
            this._autoRelease = true
        }

        if (let Some(val) <- props?.clearsAfterStop) {
            this._clearsAfterStop = val.getOrThrow()
        } else {
            this._clearsAfterStop = true
        }

        if (let Some(val) <- props?.fillMode) {
            this._fillMode = val.getOrThrow()
        } else {
            this._fillMode = AnimatorFill.Forwards
        }
    }

    private var _loops: Float64 = Float64.Inf;

    public func getloops(): Float64 {
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
        //            this._player.getOrThrow().setLoops(this.loops)
        //            this._player.pageUpdateMode = this.pageUpdateMode
        //            this._player.autoRelease = this.autoRelease
        //            this._player.clearsAfterStop = this.clearsAfterStop
        //            this._player.fillMode = this.fillMode
    }

    private var _parser: ?Parser = None

    public func setparser(value: Parser) {
        this._parser = value
    }

    private var _pageUpdateMode: PageUpdateMode = PageUpdateMode.pause;

    public func getpageUpdateMode(): PageUpdateMode {
        return this._pageUpdateMode;
    }

    public func load(source: ResourceStr, success!: ?SuccessFn = None, failure!: ?FailureFn = None, autoPlay!: Bool = true) {
        var _success = success
        var _failure = failure
        if (this._player.isNone() || this._parser.isNone()) {
            //      promptAction.showToast({
            //        message: '未初始化完成，请稍后再试'
            //      })
            return;
        }
        if (autoPlay) {
            if (_success.isNone()) {
                _success = {
                    videoItem => if (let Some(v) <- this._player) {
                        //                        v.setVideoItem(videoItem)
                        //                        v.startAnimation(false)
                    }
                }
            }
        } else {
            if (_success.isNone()) {
                //                _success = {
                //                    videoItem => this._player.getOrThrow().setVideoItem(videoItem)
                //                }
            }
        }
        if (_failure.isNone()) {
            //                  failure = { BusinessError =>
            //                    AlertDialog.show({
            //                      message: JSON.stringify(err)
            //                    })
            //                  }
        }
        this._parser.getOrThrow().load(source, _success.getOrThrow(), _failure.getOrThrow())
    }

    func setVideoItem(videoItem: MovieEntity) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        //this._player.getOrThrow().setVideoItem(videoItem)
    }

    func sfunctartAnimation(reverse!: Bool = false) {
        //        if (this._player.isNone() || this._player.getOrThrow().videoItem.isNone()) {
        //            throw Exception('请在资源加载后调用')
        //        }
        //this._player.getOrThrow().startAnimation(reverse)
    }

    public func stopAnimation(clears: ?Bool) {}
}
