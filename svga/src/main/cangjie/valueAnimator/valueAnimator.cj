/**
 * Created on 2025/1/14
 */
package svga.valueAnimator

import ohos.component.ExpectedFrameRateRange
import ohos.animator.*
import std.math.*
import svga.parser.*
import ohos.ability.*

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
    public var loops: Int32 = 1
    public var fillRule: AnimatorFill = AnimatorFill.Forwards
    public var FPS: Float64 = 20.0
    public var onUpdate: ?(Float64) -> Unit = None;
    private var uicontext: ?AbilityContext = None
    private var resetFlag: Bool = false

    public init(uicontext: ?AbilityContext) {
        this.uicontext = uicontext
    }

    private var _status: AnimatorPlayStatus = AnimatorPlayStatus.INACTIVE

    public func getstatus(): AnimatorPlayStatus {
        return this._status
    }

    var onStart: () -> Unit = {
        =>
    }
    public var onEnd: () -> Unit = {
        =>
    }

    public func start(frame: ?Float64, reverse!: Bool = false) {
        if (this._animator.isNone()) {
            this.resetFlag = (frame.isSome() && frame.getOrThrow() != this.startValue && frame.getOrThrow() <= this
                .endValue)
            this._animator = AnimatorResult(
                AnimatorOptions(
                    duration: if (frame.isSome() && frame.getOrThrow() < this.endValue && frame.getOrThrow() > this
                        .startValue) {
                        Int32(this.duration * (this.endValue - frame.getOrThrow()) / (this.endValue - this.startValue))
                    } else {
                        Int32(this.duration)
                    },
                    easing: "linear",
                    delay: 0,
                    fill: this.fillRule,
                    direction: AnimatorDirection.Normal,
                    iterations: this.loops,
                    begin: if (let Some(v) <- frame) {
                        v
                    } else {
                        this.startValue
                    },
                    end: this.endValue
                )
            )
            this._animator.getOrThrow().setExpectedFrameRateRange(ExpectedFrameRateRange(min:0,max:120,expected:Int32(this.FPS)))
        }
        this._animator.getOrThrow().onframe = {
            frame => if (let Some(function) <- this.onUpdate) {
                function(frame)
            }
        }
        this._animator.getOrThrow().onrepeat = {
            =>
            // 在启动动画时 指定开始位置 在一次结束后要重置动画参数 确保动画能够播放完整
            if (this.resetFlag) {
                this
                    ._animator
                    .getOrThrow()
                    .reset(
                        AnimatorOptions(
                            duration: Int32(this.duration),
                            easing: "linear",
                            delay: 0,
                            fill: this.fillRule,
                            direction: AnimatorDirection.Normal,
                            iterations: this.loops,
                            begin: this.startValue,
                            end: this.endValue
                        )
                    )
                this.resetFlag = false
            }
        }
        this._animator.getOrThrow().onfinish = {
            =>
            this._status = AnimatorPlayStatus.FINISH
            //console.log("动画状态11:" + this._status)
            this.onEnd()
        }

        if (reverse) {
            this._animator.getOrThrow().reverse()
        } else {
            this._animator.getOrThrow().play()
        }
        this._status = AnimatorPlayStatus.PLAY
        this.onStart()
    }

    public func reverse(currentValue: ?Float64) {
        this.start(currentValue, reverse: true)
    }

    public func release() {
        if(let Some(animator)<-this._animator){
            animator.finish()
        }
        this._animator = None
        this._status = AnimatorPlayStatus.INACTIVE
    }

    public func stop() {
        this._animator?.cancel()
        this._animator = None
        this._status = AnimatorPlayStatus.INACTIVE
    }

    public func pause() {
        match (this._status) {
            case AnimatorPlayStatus.PLAY =>
                this._animator?.pause()
                this._status = AnimatorPlayStatus.PAUSE
            case _ => ()
        }
    }

    public func play() {
        match (this._status) {
            case AnimatorPlayStatus.FINISH => ()
            case _ =>
                this._animator?.play()
                this._status = AnimatorPlayStatus.PLAY
        }
    }
}
