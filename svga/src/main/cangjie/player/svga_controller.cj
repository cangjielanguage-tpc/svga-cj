/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.player

import ohos.matrix4
import kit.UIKit.ScaleOptions
import ohos.animator.*
import svga.parser.*
import svga.proto.*
import std.math.*
import ohos.base.Length
import svga.model.TextMap

public struct SvgaPlayerProps {
    public var pageUpdateMode: PageUpdateMode
    public var loops: Int32
    public var autoRelease: Bool // true 页面销毁时自动执行清理 不传默认为true
    public var clearsAfterStop: Bool
    public var fillMode: AnimatorFill

    public init(pageUpdateMode!: PageUpdateMode = PageUpdateMode.pause, loops!: Int32 = -1, autoRelease!: Bool = true,
        clearsAfterStop!: Bool = true, fillMode!: AnimatorFill = AnimatorFill.Forwards) {
        this.pageUpdateMode = pageUpdateMode
        this.loops = loops
        this.autoRelease = autoRelease
        this.clearsAfterStop = clearsAfterStop
        this.fillMode = fillMode
    }
}

public class CanvasSizeAndTrans {
    public var width: Length = 100.percent
    public var height: Length = 100.percent
    public var transformValue: matrix4.Matrix4Transit = Matrix4.identity()
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

    private var _loading: Bool = false
    public func load(source: String, autoPlay!: Bool = true) {
        if (this._player.isNone() || this._parser.isNone()) {
            PromptAction.showToast(message: '未初始化完成，请稍后再试')
            return;
        }

        if (this._loading) {
            return
        }
        this._loading = true
        let res = this._parser.getOrThrow().load(source)
        if (let Some(v) <- res) {
            this._loading = false
            this._player?.setVideoItem(v)
            if(autoPlay) {
                this._player?.startAnimation(false)
            }
        }
    }

    func setVideoItem(videoItem: MovieEntity) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player.getOrThrow().setVideoItem(videoItem)
    }

    public func startAnimation(reverse!: Bool = false) {
        if (this._player.isNone() || this._player.getOrThrow().videoItem().isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player.getOrThrow().startAnimation(reverse)
    }

    public func startAnimationWithRange(range: SvgaRange, reverse!: Bool = false) {
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
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.stopAnimation(clears)
    }

    public func setContentMode(mode: PLAYER_CONTENT_MODE) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setContentMode(mode)
    }

    public func clear() {
        if (this._player.isNone() ) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.clear()
    }

    public func stepToFrame(frame: Float64, andPlay!: Bool = true) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.stepToFrame(frame, andPlay: andPlay)
    }

    public func stepToPercentage(percentage: Int64, andPlay: Bool) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.stepToPercentage(percentage, andPlay)
    }


    public func setImage(urlOrResource: ImageSource, forKey: String, transform!: ?Transform = None) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setImage(urlOrResource,forKey,transform)
    }

    public func setImage(urlOrResource: String, forKey: String, transform!: ?Transform = None) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setImage(urlOrResource,forKey,transform)
    }

    public func setText(textORMap: String, forKey: String) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setText(textORMap,forKey)
    }

    public func setText(textORMap: TextMap, forKey: String) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setText(textORMap,forKey)
    }

    public func clearDynamicObjects() {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.clearDynamicObjects()
    }

    public func onFinished(callback: () -> Unit) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.onFinished(callback)
    }

    public func onFrame(callback: (Float64) -> Unit) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.onFrame(callback)
    }

    public func onPercentage(callback: (Float64) -> Unit) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.onPercentage(callback)
    }

    public func setLoops(loops: Int32) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setLoops(loops)
    }

    public func setCurRate(curRate: Float64) {
        if (this._player.isNone()) {
            throw Exception('请在资源加载后调用')
        }
        this._player?.setCurRate(curRate)
    }

    //回收资源
    public func release() {
        this._player?.release()
    }
}
