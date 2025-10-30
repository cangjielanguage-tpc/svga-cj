/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.audio

import kit.MediaKit.*
import ohos.base.BusinessException
import std.random.*
import std.time.DateTime
import ohos.base.Callback1Argument
import ohos.base.Callback3ArgumentWithReturn

class SeekDoneCallback <: Callback1Argument<Int32> {
    var src: AVPlayer
    public init(sc: AVPlayer) {
        this.src = sc
    }
    public open func invoke(seekDoneTime: Int32): Unit {
        this.src.play()
    }
}

class ErrorCallback <: Callback1Argument<BusinessException> {
    var src: AVPlayer
    public init(sc: AVPlayer) {
        this.src = sc
    }
    public open func invoke(e: BusinessException): Unit {
        this.src.reset()
    }
}

class StateChangeCallback <: OnAVPlayerStateChangeHandle {
    var src: AVPlayerClass
    public init(sc: AVPlayerClass) {
        this.src = sc
    }
    public open func invoke(state: AVPlayerState, reason: StateChangeReason): Unit {
        match (state) {
            case idle => ()
            case initialized => src.player?.prepare()
            case prepared =>
                if (src.seekPlay) {
                    src.player?.play()
                    src.seekPlay = false
                }
            case stopped => src.player?.prepare()
            case _ => ()
        }
    }
}

class AVDataCallback <: Callback3ArgumentWithReturn<Array<UInt8>, UInt32, Int64, Int32> {
    var src: AVPlayerClass
    public init(sc: AVPlayerClass) {
        this.src = sc
    }
    public open func invoke(buffer: Array<UInt8>, length: UInt32, poss: Int64): Int32 {
        var pos = poss
        if (pos == 0) {
            pos = 0
        }
        if (!src.buf.isEmpty()) {
            return -1
        }
        var sb = src.buf.slice(pos, pos + Int64(length))
        var tmps = buffer.clone()
        for (i in 0..sb.size) {
            tmps[i] = sb[i]
        }
        if (sb.size != 0) {
            return Int32(sb.size)
        } else {
            return -1
        }
        return 0
    }
}

public class AVPlayerClass {
    var player: ?AVPlayer = None
    var id: String = ""
    public var seekPlay: Bool = false
    public var buf: Array<Byte> = Array<Byte>()
    public var dataSrc: ?AVDataSrcDescriptor = None
    public init() {
        let m1: Random = Random(3)
        this.id = "${DateTime.now().nanosecond}+${m1.nextUInt64()}"
    }
    public func initPlayer(buf: Array<Byte>): Bool {
        this.buf = buf
        try {
            this.player = createAVPlayer()
            this.player.getOrThrow().on(AVPlayerCallbackType.SeekDone, SeekDoneCallback(this.player.getOrThrow()))
            this.player.getOrThrow().on(AVPlayerCallbackType.AVError, ErrorCallback(this.player.getOrThrow()))
            this.player.getOrThrow().on(AVPlayerCallbackType.StateChange, StateChangeCallback(this))
            this.dataSrc = AVDataSrcDescriptor(this.buf.size, AVDataCallback(this))
            var AVMetadata = createAVMetadataExtractor()
            AVMetadata.dataSrc = this.dataSrc.getOrThrow()
            this.player.getOrThrow().fdSrc = AVMetadata.fdSrc
            return true
        } catch (e: Exception) {
            return false
        }
    }

    // 单曲播放
    public func play() {
        var states: Array<AVPlayerState> = [AVPlayerState.Prepared, AVPlayerState.Paused, AVPlayerState.Completed]
        if (let Some(v) <- this.player) {
            if (states.contains(v.state)) {
                v.play()
            }
        }
    }

    // 设置进度
    public func seek(seek: Int32, autoplay!: Bool = true) {
        var states: Array<AVPlayerState> = [AVPlayerState.Prepared, AVPlayerState.Paused, AVPlayerState.Completed,
            AVPlayerState.Playing]
        if (let Some(v) <- this.player) {
            if (states.contains(v.state)) {
                this.seekPlay = autoplay
                v.seek(seek)
            }
        }
    }

    // 暂停
    public func pause() {
        if (let Some(v) <- this.player) {
            if (v.state == AVPlayerState.Playing) {
                v.pause()
            }
        }
    }

    // 停止
    public func stop() {
        var states: Array<AVPlayerState> = [AVPlayerState.Completed, AVPlayerState.Playing, AVPlayerState.Prepared,
            AVPlayerState.Paused]
        if (let Some(v) <- this.player) {
            if (states.contains(v.state)) {
                v.stop()
            }
        }
    }

    // 删除
    public func release() {
        if (let Some(v) <- this.player) {
            v.release()
        }
    }
}
