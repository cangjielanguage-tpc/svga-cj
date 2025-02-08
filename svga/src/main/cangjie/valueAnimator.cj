/**
 * Created on 2025/1/14
 */
package svga

import tpc.UIKit.animator.*
import tpc.UIKit.UIContext.*
import std.math.*
import svga.parser.*

public enum AnimatorPlayStatus {
    | INACTIVE // 初始状态
    | PLAY // 播放中
    | FINISH // 播放完成
    | PAUSE // 暂停
}

public class ValueAnimator {
    var _animator: ?AnimatorResult = None
    public var startValue: Float64 = 0.0
    public var endValue: Float64 = 0.0
    public var duration: Float64 = 0.0
    public var loops: Float64 = 1.0
    public var fillRule: AnimatorFill = AnimatorFill.Forwards
    public var FPS: Float64 = 20.0
    public var onUpdate: ?(Float64) -> Unit = None;
    private var uicontext: ?UIContext = None
    private var resetFlag: Bool = false

    public init(uicontext: ?UIContext) {
        this.uicontext = uicontext
    }

    private var _status: AnimatorPlayStatus = AnimatorPlayStatus.INACTIVE

    public func getstatus(): AnimatorPlayStatus {
        return this._status
    }

    var onStart: () -> Unit = {
        =>
    }
    var onEnd: () -> Unit = {
        =>
    }

    public func start(frame: ?Float64, reverse!: Bool = false) {
        if (this._animator.isNone()) {
            this.resetFlag = (frame.isSome() && frame.getOrThrow() != this.startValue && frame.getOrThrow() <= this
                .endValue)
            this._animator = this
                .uicontext
                .getOrThrow()
                .createAnimator(
                    //this._animator = this.uicontext!.createAnimator(
                    AnimatorOptions(
                        {
                            => if (frame.isSome() && frame.getOrThrow() < this.endValue && frame.getOrThrow() > this
                                .startValue) {
                                return this.duration * (this.endValue - frame.getOrThrow()) / (this.endValue - this
                                    .startValue)
                            } else {
                                this.duration
                            }
                        }(),
                        "linear",
                        0.0,
                        this.fillRule,
                        AnimatorDirection.Normal,
                        this.loops,
                        {
                            => if (let Some(v) <- frame) {
                                return v
                            } else {
                                this.startValue
                            }
                        }(),
                        this.endValue
                    )
                )
            //            this._animator.getOrThrow().setExpectedFrameRateRange(
            //                0,
            //                120,
            //                this.FPS
            //            )
            if (reverse) {
                this._animator.getOrThrow().reverse()
            } else {
                this._animator.getOrThrow().play()
            }
            this._status = AnimatorPlayStatus.PLAY
            this.onStart()
        }
        this._animator.getOrThrow().onFrame = {
            frame => if (let Some(function) <- this.onUpdate) {
                function(frame)
            }
        }
        this._animator.getOrThrow().onRepeat = {
            =>
            // 在启动动画时 指定开始位置 在一次结束后要重置动画参数 确保动画能够播放完整
            if (this.resetFlag) {
                this
                    ._animator
                    .getOrThrow()
                    .reset(
                        AnimatorOptions(
                            this.duration,
                            "linear",
                            0.0,
                            this.fillRule,
                            AnimatorDirection.Normal,
                            this.loops,
                            this.startValue,
                            this.endValue
                        )
                    )
                this.resetFlag = false
            }
        }
        this._animator.getOrThrow().onFinish = {
            =>
            this._status = AnimatorPlayStatus.FINISH
            //console.log("动画状态11:" + this._status)
            this.onEnd()
        }
    }

    public func reverse(currentValue: ?Float64) {
        this.start(currentValue, reverse: true)
    }

    public func release() {
        this._animator.getOrThrow().finish()
        this._animator = None
        this._status = AnimatorPlayStatus.INACTIVE
    }

    public func stop() {
        this._animator.getOrThrow().cancel()
        this._animator = None
        this._status = AnimatorPlayStatus.INACTIVE
    }

    public func pause() {
        match (this._status) {
            case AnimatorPlayStatus.PLAY =>
                this._animator.getOrThrow().pause()
                this._status = AnimatorPlayStatus.PAUSE
            case _ => ()
        }
    }

    public func play() {
        match (this._status) {
            case AnimatorPlayStatus.FINISH => ()
            case _ =>
                this._animator.getOrThrow().play()
                this._status = AnimatorPlayStatus.PLAY
        }
    }
}
