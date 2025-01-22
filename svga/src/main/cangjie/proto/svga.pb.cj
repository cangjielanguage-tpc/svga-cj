package ohos_app_cangjie_svga.proto

import std.collection.*

public class MovieParams <: MessageLite & TypedMessage<MovieParams> {
    private var p_viewBoxWidth: Float32
    private var p_viewBoxHeight: Float32
    private var p_fps: Int32
    private var p_frames: Int32

    public init(
        viewBoxWidth!: Float32 = Float32(.0),
        viewBoxHeight!: Float32 = Float32(.0),
        fps!: Int32 = Int32(0),
        frames!: Int32 = Int32(0)
    ) {
        this.p_viewBoxWidth = viewBoxWidth
        this.p_viewBoxHeight = viewBoxHeight
        this.p_fps = fps
        this.p_frames = frames
        m_init()
    }

    public init(src: MovieParams__Builder) {
        this.p_viewBoxWidth = src.viewBoxWidth
        this.p_viewBoxHeight = src.viewBoxHeight
        this.p_fps = src.fps
        this.p_frames = src.frames
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public mut prop viewBoxWidth: Float32 { get() { p_viewBoxWidth } set(_v) { p_viewBoxWidth = _v; markDirty() } }

    public mut prop viewBoxHeight: Float32 { get() { p_viewBoxHeight } set(_v) { p_viewBoxHeight = _v; markDirty() } }

    public mut prop fps: Int32 { get() { p_fps } set(_v) { p_fps = _v; markDirty() } }

    public mut prop frames: Int32 { get() { p_frames } set(_v) { p_frames = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (p_viewBoxWidth != .0) { _x += 1 + 4 }
        if (p_viewBoxHeight != .0) { _x += 1 + 4 }
        if (p_fps != 0) { _x += 1 + varintSize(p_fps) }
        if (p_frames != 0) { _x += 1 + varintSize(p_frames) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (p_viewBoxWidth != .0) { _x.write(p_viewBoxWidth) }
        if (p_viewBoxHeight != .0) { _x.write(p_viewBoxHeight) }
        if (p_fps != 0) { _x.write(p_fps) }
        if (p_frames != 0) { _x.write(p_frames) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_viewBoxWidth == .0 && p_viewBoxHeight == .0 && p_fps == 0 && p_frames == 0
    }

    protected func m_clear(): Unit {
        p_viewBoxWidth = .0
        p_viewBoxHeight = .0
        p_fps = 0
        p_frames = 0
    }

    public operator func !=(src: MovieParams): Bool { !(this == src) }
    public operator func ==(src: MovieParams): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_viewBoxWidth == src.p_viewBoxWidth && p_viewBoxHeight == src.p_viewBoxHeight && p_fps == src.p_fps &&
        p_frames == src.p_frames
    }

    public func mergeFrom(src: MovieParams): Unit {
        if (src.p_viewBoxWidth != .0) { p_viewBoxWidth = src.p_viewBoxWidth }
        if (src.p_viewBoxHeight != .0) { p_viewBoxHeight = src.p_viewBoxHeight }
        if (src.p_fps != 0) { p_fps = src.p_fps }
        if (src.p_frames != 0) { p_frames = src.p_frames }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: MovieParams): MovieParams {
        p_viewBoxWidth = src.p_viewBoxWidth
        p_viewBoxHeight = src.p_viewBoxHeight
        p_fps = src.p_fps
        p_frames = src.p_frames
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): MovieParams {
        return MovieParams().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_viewBoxWidth = src.parseFloat32()
                case 2 => p_viewBoxHeight = src.parseFloat32()
                case 3 => p_fps = src.parseInt32()
                case 4 => p_frames = src.parseInt32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (p_viewBoxWidth != .0) { out.append(13); out.packFixed(p_viewBoxWidth) }
        if (p_viewBoxHeight != .0) { out.append(21); out.packFixed(p_viewBoxHeight) }
        if (p_fps != 0) { out.append(24); out.packVarint(p_fps) }
        if (p_frames != 0) { out.append(32); out.packVarint(p_frames) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (p_viewBoxWidth != .0) { _x.append("viewBoxWidth", p_viewBoxWidth) }
        if (p_viewBoxHeight != .0) { _x.append("viewBoxHeight", p_viewBoxHeight) }
        if (p_fps != 0) { _x.append("fps", p_fps) }
        if (p_frames != 0) { _x.append("frames", p_frames) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { MovieParams() }
    public static func newBuilder() { MovieParams__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = MovieParams(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = MovieParams(); _x.unpack(src); _x }
}

public class MovieParams__Builder {
    public var viewBoxWidth: Float32 = Float32(.0)
    public func setViewBoxWidth(viewBoxWidth: Float32) { this.viewBoxWidth = viewBoxWidth; return this }

    public var viewBoxHeight: Float32 = Float32(.0)
    public func setViewBoxHeight(viewBoxHeight: Float32) { this.viewBoxHeight = viewBoxHeight; return this }

    public var fps: Int32 = Int32(0)
    public func setFps(fps: Int32) { this.fps = fps; return this }

    public var frames: Int32 = Int32(0)
    public func setFrames(frames: Int32) { this.frames = frames; return this }

    public func build() { MovieParams(this) }
}

public class SpriteEntity <: MessageLite & TypedMessage<SpriteEntity> {
    private var p_imageKey: String
    public let frames: RepeatedMessage<FrameEntity>
    private var p_matteKey: String

    public init(
        imageKey!: String = "",
        frames!: Array<FrameEntity> = [],
        matteKey!: String = ""
    ) {
        this.p_imageKey = imageKey
        this.frames = RepeatedMessage<FrameEntity>(frames)
        this.p_matteKey = matteKey
        m_init()
    }

    public init(src: SpriteEntity__Builder) {
        this.p_imageKey = src.imageKey
        this.frames = RepeatedMessage<FrameEntity>(src.frames)
        this.p_matteKey = src.matteKey
        m_init()
    }

    private func m_init() {
        m_init(frames)
        m_innerInit()
    }

    public mut prop imageKey: String { get() { p_imageKey } set(_v) { p_imageKey = _v; markDirty() } }

    public mut prop matteKey: String { get() { p_matteKey } set(_v) { p_matteKey = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!p_imageKey.isEmpty()) { _x += 1 + binSize(p_imageKey) }
        if (!frames.isEmpty()) { for (_i in frames) { _x += 1 + binSize(_i) } }
        if (!p_matteKey.isEmpty()) { _x += 1 + binSize(p_matteKey) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!p_imageKey.isEmpty()) { _x.write(p_imageKey.hashCode()) }
        if (!frames.isEmpty()) { _x.write(frames.hashCode()) }
        if (!p_matteKey.isEmpty()) { _x.write(p_matteKey.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_imageKey.isEmpty() && frames.isEmpty() && p_matteKey.isEmpty()
    }

    protected func m_clear(): Unit {
        p_imageKey = ""
        frames.clear()
        p_matteKey = ""
    }

    public operator func !=(src: SpriteEntity): Bool { !(this == src) }
    public operator func ==(src: SpriteEntity): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_imageKey == src.p_imageKey && frames == src.frames && p_matteKey == src.p_matteKey
    }

    public func mergeFrom(src: SpriteEntity): Unit {
        if (!src.p_imageKey.isEmpty()) { p_imageKey = src.p_imageKey }
        if (!src.frames.isEmpty()) { frames.appendAll(src.frames) }
        if (!src.p_matteKey.isEmpty()) { p_matteKey = src.p_matteKey }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: SpriteEntity): SpriteEntity {
        p_imageKey = src.p_imageKey
        frames.copyFrom(src.frames)
        p_matteKey = src.p_matteKey
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): SpriteEntity {
        return SpriteEntity().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_imageKey = src.parseString()
                case 2 => s_add(frames, src)
                case 3 => p_matteKey = src.parseString()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (!p_imageKey.isEmpty()) { out.append(10); out.packBin(p_imageKey) }
        if (!frames.isEmpty()) { for (_i in frames) { out.append(18); out.packVarint(_i.size); _i.pack(out) } }
        if (!p_matteKey.isEmpty()) { out.append(26); out.packBin(p_matteKey) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!p_imageKey.isEmpty()) { _x.append("imageKey", p_imageKey) }
        if (!frames.isEmpty()) { _x.append("frames", frames) }
        if (!p_matteKey.isEmpty()) { _x.append("matteKey", p_matteKey) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { SpriteEntity() }
    public static func newBuilder() { SpriteEntity__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = SpriteEntity(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = SpriteEntity(); _x.unpack(src); _x }
}

public class SpriteEntity__Builder {
    public var imageKey: String = ""
    public func setImageKey(imageKey: String) { this.imageKey = imageKey; return this }

    public var frames: Array<FrameEntity> = []
    public func setFrames(frames: Array<FrameEntity>) { this.frames = frames; return this }

    public var matteKey: String = ""
    public func setMatteKey(matteKey: String) { this.matteKey = matteKey; return this }

    public func build() { SpriteEntity(this) }
}

public class AudioEntity <: MessageLite & TypedMessage<AudioEntity> {
    private var p_audioKey: String
    private var p_startFrame: Int32
    private var p_endFrame: Int32
    private var p_startTime: Int32
    private var p_totalTime: Int32

    public init(
        audioKey!: String = "",
        startFrame!: Int32 = Int32(0),
        endFrame!: Int32 = Int32(0),
        startTime!: Int32 = Int32(0),
        totalTime!: Int32 = Int32(0)
    ) {
        this.p_audioKey = audioKey
        this.p_startFrame = startFrame
        this.p_endFrame = endFrame
        this.p_startTime = startTime
        this.p_totalTime = totalTime
        m_init()
    }

    public init(src: AudioEntity__Builder) {
        this.p_audioKey = src.audioKey
        this.p_startFrame = src.startFrame
        this.p_endFrame = src.endFrame
        this.p_startTime = src.startTime
        this.p_totalTime = src.totalTime
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public mut prop audioKey: String { get() { p_audioKey } set(_v) { p_audioKey = _v; markDirty() } }

    public mut prop startFrame: Int32 { get() { p_startFrame } set(_v) { p_startFrame = _v; markDirty() } }

    public mut prop endFrame: Int32 { get() { p_endFrame } set(_v) { p_endFrame = _v; markDirty() } }

    public mut prop startTime: Int32 { get() { p_startTime } set(_v) { p_startTime = _v; markDirty() } }

    public mut prop totalTime: Int32 { get() { p_totalTime } set(_v) { p_totalTime = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!p_audioKey.isEmpty()) { _x += 1 + binSize(p_audioKey) }
        if (p_startFrame != 0) { _x += 1 + varintSize(p_startFrame) }
        if (p_endFrame != 0) { _x += 1 + varintSize(p_endFrame) }
        if (p_startTime != 0) { _x += 1 + varintSize(p_startTime) }
        if (p_totalTime != 0) { _x += 1 + varintSize(p_totalTime) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!p_audioKey.isEmpty()) { _x.write(p_audioKey.hashCode()) }
        if (p_startFrame != 0) { _x.write(p_startFrame) }
        if (p_endFrame != 0) { _x.write(p_endFrame) }
        if (p_startTime != 0) { _x.write(p_startTime) }
        if (p_totalTime != 0) { _x.write(p_totalTime) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_audioKey.isEmpty() && p_startFrame == 0 && p_endFrame == 0 && p_startTime == 0 && p_totalTime == 0
    }

    protected func m_clear(): Unit {
        p_audioKey = ""
        p_startFrame = 0
        p_endFrame = 0
        p_startTime = 0
        p_totalTime = 0
    }

    public operator func !=(src: AudioEntity): Bool { !(this == src) }
    public operator func ==(src: AudioEntity): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_audioKey == src.p_audioKey && p_startFrame == src.p_startFrame && p_endFrame == src.p_endFrame &&
        p_startTime == src.p_startTime && p_totalTime == src.p_totalTime
    }

    public func mergeFrom(src: AudioEntity): Unit {
        if (!src.p_audioKey.isEmpty()) { p_audioKey = src.p_audioKey }
        if (src.p_startFrame != 0) { p_startFrame = src.p_startFrame }
        if (src.p_endFrame != 0) { p_endFrame = src.p_endFrame }
        if (src.p_startTime != 0) { p_startTime = src.p_startTime }
        if (src.p_totalTime != 0) { p_totalTime = src.p_totalTime }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: AudioEntity): AudioEntity {
        p_audioKey = src.p_audioKey
        p_startFrame = src.p_startFrame
        p_endFrame = src.p_endFrame
        p_startTime = src.p_startTime
        p_totalTime = src.p_totalTime
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): AudioEntity {
        return AudioEntity().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_audioKey = src.parseString()
                case 2 => p_startFrame = src.parseInt32()
                case 3 => p_endFrame = src.parseInt32()
                case 4 => p_startTime = src.parseInt32()
                case 5 => p_totalTime = src.parseInt32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (!p_audioKey.isEmpty()) { out.append(10); out.packBin(p_audioKey) }
        if (p_startFrame != 0) { out.append(16); out.packVarint(p_startFrame) }
        if (p_endFrame != 0) { out.append(24); out.packVarint(p_endFrame) }
        if (p_startTime != 0) { out.append(32); out.packVarint(p_startTime) }
        if (p_totalTime != 0) { out.append(40); out.packVarint(p_totalTime) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!p_audioKey.isEmpty()) { _x.append("audioKey", p_audioKey) }
        if (p_startFrame != 0) { _x.append("startFrame", p_startFrame) }
        if (p_endFrame != 0) { _x.append("endFrame", p_endFrame) }
        if (p_startTime != 0) { _x.append("startTime", p_startTime) }
        if (p_totalTime != 0) { _x.append("totalTime", p_totalTime) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { AudioEntity() }
    public static func newBuilder() { AudioEntity__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = AudioEntity(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = AudioEntity(); _x.unpack(src); _x }
}

public class AudioEntity__Builder {
    public var audioKey: String = ""
    public func setAudioKey(audioKey: String) { this.audioKey = audioKey; return this }

    public var startFrame: Int32 = Int32(0)
    public func setStartFrame(startFrame: Int32) { this.startFrame = startFrame; return this }

    public var endFrame: Int32 = Int32(0)
    public func setEndFrame(endFrame: Int32) { this.endFrame = endFrame; return this }

    public var startTime: Int32 = Int32(0)
    public func setStartTime(startTime: Int32) { this.startTime = startTime; return this }

    public var totalTime: Int32 = Int32(0)
    public func setTotalTime(totalTime: Int32) { this.totalTime = totalTime; return this }

    public func build() { AudioEntity(this) }
}

public class Layout <: MessageLite & TypedMessage<Layout> {
    private var p_x: Float32
    private var p_y: Float32
    private var p_width: Float32
    private var p_height: Float32

    public init(
        x!: Float32 = Float32(.0),
        y!: Float32 = Float32(.0),
        width!: Float32 = Float32(.0),
        height!: Float32 = Float32(.0)
    ) {
        this.p_x = x
        this.p_y = y
        this.p_width = width
        this.p_height = height
        m_init()
    }

    public init(src: Layout__Builder) {
        this.p_x = src.x
        this.p_y = src.y
        this.p_width = src.width
        this.p_height = src.height
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public mut prop x: Float32 { get() { p_x } set(_v) { p_x = _v; markDirty() } }

    public mut prop y: Float32 { get() { p_y } set(_v) { p_y = _v; markDirty() } }

    public mut prop width: Float32 { get() { p_width } set(_v) { p_width = _v; markDirty() } }

    public mut prop height: Float32 { get() { p_height } set(_v) { p_height = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (p_x != .0) { _x += 1 + 4 }
        if (p_y != .0) { _x += 1 + 4 }
        if (p_width != .0) { _x += 1 + 4 }
        if (p_height != .0) { _x += 1 + 4 }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (p_x != .0) { _x.write(p_x) }
        if (p_y != .0) { _x.write(p_y) }
        if (p_width != .0) { _x.write(p_width) }
        if (p_height != .0) { _x.write(p_height) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_x == .0 && p_y == .0 && p_width == .0 && p_height == .0
    }

    protected func m_clear(): Unit {
        p_x = .0
        p_y = .0
        p_width = .0
        p_height = .0
    }

    public operator func !=(src: Layout): Bool { !(this == src) }
    public operator func ==(src: Layout): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields && p_x == src.p_x &&
        p_y == src.p_y && p_width == src.p_width && p_height == src.p_height
    }

    public func mergeFrom(src: Layout): Unit {
        if (src.p_x != .0) { p_x = src.p_x }
        if (src.p_y != .0) { p_y = src.p_y }
        if (src.p_width != .0) { p_width = src.p_width }
        if (src.p_height != .0) { p_height = src.p_height }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: Layout): Layout {
        p_x = src.p_x
        p_y = src.p_y
        p_width = src.p_width
        p_height = src.p_height
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): Layout {
        return Layout().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_x = src.parseFloat32()
                case 2 => p_y = src.parseFloat32()
                case 3 => p_width = src.parseFloat32()
                case 4 => p_height = src.parseFloat32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (p_x != .0) { out.append(13); out.packFixed(p_x) }
        if (p_y != .0) { out.append(21); out.packFixed(p_y) }
        if (p_width != .0) { out.append(29); out.packFixed(p_width) }
        if (p_height != .0) { out.append(37); out.packFixed(p_height) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (p_x != .0) { _x.append("x", p_x) }
        if (p_y != .0) { _x.append("y", p_y) }
        if (p_width != .0) { _x.append("width", p_width) }
        if (p_height != .0) { _x.append("height", p_height) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { Layout() }
    public static func newBuilder() { Layout__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = Layout(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = Layout(); _x.unpack(src); _x }
}

public class Layout__Builder {
    public var x: Float32 = Float32(.0)
    public func setX(x: Float32) { this.x = x; return this }

    public var y: Float32 = Float32(.0)
    public func setY(y: Float32) { this.y = y; return this }

    public var width: Float32 = Float32(.0)
    public func setWidth(width: Float32) { this.width = width; return this }

    public var height: Float32 = Float32(.0)
    public func setHeight(height: Float32) { this.height = height; return this }

    public func build() { Layout(this) }
}

public class Transform <: MessageLite & TypedMessage<Transform> {
    private var p_a: Float32
    private var p_b: Float32
    private var p_c: Float32
    private var p_d: Float32
    private var p_tx: Float32
    private var p_ty: Float32

    public init(
        a!: Float32 = Float32(.0),
        b!: Float32 = Float32(.0),
        c!: Float32 = Float32(.0),
        d!: Float32 = Float32(.0),
        tx!: Float32 = Float32(.0),
        ty!: Float32 = Float32(.0)
    ) {
        this.p_a = a
        this.p_b = b
        this.p_c = c
        this.p_d = d
        this.p_tx = tx
        this.p_ty = ty
        m_init()
    }

    public init(src: Transform__Builder) {
        this.p_a = src.a
        this.p_b = src.b
        this.p_c = src.c
        this.p_d = src.d
        this.p_tx = src.tx
        this.p_ty = src.ty
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public mut prop a: Float32 { get() { p_a } set(_v) { p_a = _v; markDirty() } }

    public mut prop b: Float32 { get() { p_b } set(_v) { p_b = _v; markDirty() } }

    public mut prop c: Float32 { get() { p_c } set(_v) { p_c = _v; markDirty() } }

    public mut prop d: Float32 { get() { p_d } set(_v) { p_d = _v; markDirty() } }

    public mut prop tx: Float32 { get() { p_tx } set(_v) { p_tx = _v; markDirty() } }

    public mut prop ty: Float32 { get() { p_ty } set(_v) { p_ty = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (p_a != .0) { _x += 1 + 4 }
        if (p_b != .0) { _x += 1 + 4 }
        if (p_c != .0) { _x += 1 + 4 }
        if (p_d != .0) { _x += 1 + 4 }
        if (p_tx != .0) { _x += 1 + 4 }
        if (p_ty != .0) { _x += 1 + 4 }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (p_a != .0) { _x.write(p_a) }
        if (p_b != .0) { _x.write(p_b) }
        if (p_c != .0) { _x.write(p_c) }
        if (p_d != .0) { _x.write(p_d) }
        if (p_tx != .0) { _x.write(p_tx) }
        if (p_ty != .0) { _x.write(p_ty) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_a == .0 && p_b == .0 && p_c == .0 && p_d == .0 && p_tx == .0 && p_ty == .0
    }

    protected func m_clear(): Unit {
        p_a = .0
        p_b = .0
        p_c = .0
        p_d = .0
        p_tx = .0
        p_ty = .0
    }

    public operator func !=(src: Transform): Bool { !(this == src) }
    public operator func ==(src: Transform): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields && p_a == src.p_a &&
        p_b == src.p_b && p_c == src.p_c && p_d == src.p_d && p_tx == src.p_tx && p_ty == src.p_ty
    }

    public func mergeFrom(src: Transform): Unit {
        if (src.p_a != .0) { p_a = src.p_a }
        if (src.p_b != .0) { p_b = src.p_b }
        if (src.p_c != .0) { p_c = src.p_c }
        if (src.p_d != .0) { p_d = src.p_d }
        if (src.p_tx != .0) { p_tx = src.p_tx }
        if (src.p_ty != .0) { p_ty = src.p_ty }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: Transform): Transform {
        p_a = src.p_a
        p_b = src.p_b
        p_c = src.p_c
        p_d = src.p_d
        p_tx = src.p_tx
        p_ty = src.p_ty
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): Transform {
        return Transform().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_a = src.parseFloat32()
                case 2 => p_b = src.parseFloat32()
                case 3 => p_c = src.parseFloat32()
                case 4 => p_d = src.parseFloat32()
                case 5 => p_tx = src.parseFloat32()
                case 6 => p_ty = src.parseFloat32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (p_a != .0) { out.append(13); out.packFixed(p_a) }
        if (p_b != .0) { out.append(21); out.packFixed(p_b) }
        if (p_c != .0) { out.append(29); out.packFixed(p_c) }
        if (p_d != .0) { out.append(37); out.packFixed(p_d) }
        if (p_tx != .0) { out.append(45); out.packFixed(p_tx) }
        if (p_ty != .0) { out.append(53); out.packFixed(p_ty) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (p_a != .0) { _x.append("a", p_a) }
        if (p_b != .0) { _x.append("b", p_b) }
        if (p_c != .0) { _x.append("c", p_c) }
        if (p_d != .0) { _x.append("d", p_d) }
        if (p_tx != .0) { _x.append("tx", p_tx) }
        if (p_ty != .0) { _x.append("ty", p_ty) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { Transform() }
    public static func newBuilder() { Transform__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = Transform(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = Transform(); _x.unpack(src); _x }
}

public class Transform__Builder {
    public var a: Float32 = Float32(.0)
    public func setA(a: Float32) { this.a = a; return this }

    public var b: Float32 = Float32(.0)
    public func setB(b: Float32) { this.b = b; return this }

    public var c: Float32 = Float32(.0)
    public func setC(c: Float32) { this.c = c; return this }

    public var d: Float32 = Float32(.0)
    public func setD(d: Float32) { this.d = d; return this }

    public var tx: Float32 = Float32(.0)
    public func setTx(tx: Float32) { this.tx = tx; return this }

    public var ty: Float32 = Float32(.0)
    public func setTy(ty: Float32) { this.ty = ty; return this }

    public func build() { Transform(this) }
}

public class ShapeEntity_ShapeArgs <: MessageLite & TypedMessage<ShapeEntity_ShapeArgs> {
    private var p_d: String

    public init(
        d!: String = ""
    ) {
        this.p_d = d
        m_init()
    }

    public init(src: ShapeEntity_ShapeArgs__Builder) {
        this.p_d = src.d
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public mut prop d: String { get() { p_d } set(_v) { p_d = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!p_d.isEmpty()) { _x += 1 + binSize(p_d) }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!p_d.isEmpty()) { _x.write(p_d.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_d.isEmpty()
    }

    protected func m_clear(): Unit {
        p_d = ""
    }

    public operator func !=(src: ShapeEntity_ShapeArgs): Bool { !(this == src) }
    public operator func ==(src: ShapeEntity_ShapeArgs): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields && p_d == src.p_d
    }

    public func mergeFrom(src: ShapeEntity_ShapeArgs): Unit {
        if (!src.p_d.isEmpty()) { p_d = src.p_d }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: ShapeEntity_ShapeArgs): ShapeEntity_ShapeArgs {
        p_d = src.p_d
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): ShapeEntity_ShapeArgs {
        return ShapeEntity_ShapeArgs().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_d = src.parseString()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (!p_d.isEmpty()) { out.append(10); out.packBin(p_d) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!p_d.isEmpty()) { _x.append("d", p_d) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { ShapeEntity_ShapeArgs() }
    public static func newBuilder() { ShapeEntity_ShapeArgs__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = ShapeEntity_ShapeArgs(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = ShapeEntity_ShapeArgs(); _x.unpack(src); _x }
}

public class ShapeEntity_ShapeArgs__Builder {
    public var d: String = ""
    public func setD(d: String) { this.d = d; return this }

    public func build() { ShapeEntity_ShapeArgs(this) }
}

public class ShapeEntity_RectArgs <: MessageLite & TypedMessage<ShapeEntity_RectArgs> {
    private var p_x: Float32
    private var p_y: Float32
    private var p_width: Float32
    private var p_height: Float32
    private var p_cornerRadius: Float32

    public init(
        x!: Float32 = Float32(.0),
        y!: Float32 = Float32(.0),
        width!: Float32 = Float32(.0),
        height!: Float32 = Float32(.0),
        cornerRadius!: Float32 = Float32(.0)
    ) {
        this.p_x = x
        this.p_y = y
        this.p_width = width
        this.p_height = height
        this.p_cornerRadius = cornerRadius
        m_init()
    }

    public init(src: ShapeEntity_RectArgs__Builder) {
        this.p_x = src.x
        this.p_y = src.y
        this.p_width = src.width
        this.p_height = src.height
        this.p_cornerRadius = src.cornerRadius
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public mut prop x: Float32 { get() { p_x } set(_v) { p_x = _v; markDirty() } }

    public mut prop y: Float32 { get() { p_y } set(_v) { p_y = _v; markDirty() } }

    public mut prop width: Float32 { get() { p_width } set(_v) { p_width = _v; markDirty() } }

    public mut prop height: Float32 { get() { p_height } set(_v) { p_height = _v; markDirty() } }

    public mut prop cornerRadius: Float32 { get() { p_cornerRadius } set(_v) { p_cornerRadius = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (p_x != .0) { _x += 1 + 4 }
        if (p_y != .0) { _x += 1 + 4 }
        if (p_width != .0) { _x += 1 + 4 }
        if (p_height != .0) { _x += 1 + 4 }
        if (p_cornerRadius != .0) { _x += 1 + 4 }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (p_x != .0) { _x.write(p_x) }
        if (p_y != .0) { _x.write(p_y) }
        if (p_width != .0) { _x.write(p_width) }
        if (p_height != .0) { _x.write(p_height) }
        if (p_cornerRadius != .0) { _x.write(p_cornerRadius) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_x == .0 && p_y == .0 && p_width == .0 && p_height == .0 && p_cornerRadius == .0
    }

    protected func m_clear(): Unit {
        p_x = .0
        p_y = .0
        p_width = .0
        p_height = .0
        p_cornerRadius = .0
    }

    public operator func !=(src: ShapeEntity_RectArgs): Bool { !(this == src) }
    public operator func ==(src: ShapeEntity_RectArgs): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields && p_x == src.p_x &&
        p_y == src.p_y && p_width == src.p_width && p_height == src.p_height && p_cornerRadius == src.p_cornerRadius
    }

    public func mergeFrom(src: ShapeEntity_RectArgs): Unit {
        if (src.p_x != .0) { p_x = src.p_x }
        if (src.p_y != .0) { p_y = src.p_y }
        if (src.p_width != .0) { p_width = src.p_width }
        if (src.p_height != .0) { p_height = src.p_height }
        if (src.p_cornerRadius != .0) { p_cornerRadius = src.p_cornerRadius }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: ShapeEntity_RectArgs): ShapeEntity_RectArgs {
        p_x = src.p_x
        p_y = src.p_y
        p_width = src.p_width
        p_height = src.p_height
        p_cornerRadius = src.p_cornerRadius
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): ShapeEntity_RectArgs {
        return ShapeEntity_RectArgs().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_x = src.parseFloat32()
                case 2 => p_y = src.parseFloat32()
                case 3 => p_width = src.parseFloat32()
                case 4 => p_height = src.parseFloat32()
                case 5 => p_cornerRadius = src.parseFloat32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (p_x != .0) { out.append(13); out.packFixed(p_x) }
        if (p_y != .0) { out.append(21); out.packFixed(p_y) }
        if (p_width != .0) { out.append(29); out.packFixed(p_width) }
        if (p_height != .0) { out.append(37); out.packFixed(p_height) }
        if (p_cornerRadius != .0) { out.append(45); out.packFixed(p_cornerRadius) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (p_x != .0) { _x.append("x", p_x) }
        if (p_y != .0) { _x.append("y", p_y) }
        if (p_width != .0) { _x.append("width", p_width) }
        if (p_height != .0) { _x.append("height", p_height) }
        if (p_cornerRadius != .0) { _x.append("cornerRadius", p_cornerRadius) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { ShapeEntity_RectArgs() }
    public static func newBuilder() { ShapeEntity_RectArgs__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = ShapeEntity_RectArgs(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = ShapeEntity_RectArgs(); _x.unpack(src); _x }
}

public class ShapeEntity_RectArgs__Builder {
    public var x: Float32 = Float32(.0)
    public func setX(x: Float32) { this.x = x; return this }

    public var y: Float32 = Float32(.0)
    public func setY(y: Float32) { this.y = y; return this }

    public var width: Float32 = Float32(.0)
    public func setWidth(width: Float32) { this.width = width; return this }

    public var height: Float32 = Float32(.0)
    public func setHeight(height: Float32) { this.height = height; return this }

    public var cornerRadius: Float32 = Float32(.0)
    public func setCornerRadius(cornerRadius: Float32) { this.cornerRadius = cornerRadius; return this }

    public func build() { ShapeEntity_RectArgs(this) }
}

public class ShapeEntity_EllipseArgs <: MessageLite & TypedMessage<ShapeEntity_EllipseArgs> {
    private var p_x: Float32
    private var p_y: Float32
    private var p_radiusX: Float32
    private var p_radiusY: Float32

    public init(
        x!: Float32 = Float32(.0),
        y!: Float32 = Float32(.0),
        radiusX!: Float32 = Float32(.0),
        radiusY!: Float32 = Float32(.0)
    ) {
        this.p_x = x
        this.p_y = y
        this.p_radiusX = radiusX
        this.p_radiusY = radiusY
        m_init()
    }

    public init(src: ShapeEntity_EllipseArgs__Builder) {
        this.p_x = src.x
        this.p_y = src.y
        this.p_radiusX = src.radiusX
        this.p_radiusY = src.radiusY
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public mut prop x: Float32 { get() { p_x } set(_v) { p_x = _v; markDirty() } }

    public mut prop y: Float32 { get() { p_y } set(_v) { p_y = _v; markDirty() } }

    public mut prop radiusX: Float32 { get() { p_radiusX } set(_v) { p_radiusX = _v; markDirty() } }

    public mut prop radiusY: Float32 { get() { p_radiusY } set(_v) { p_radiusY = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (p_x != .0) { _x += 1 + 4 }
        if (p_y != .0) { _x += 1 + 4 }
        if (p_radiusX != .0) { _x += 1 + 4 }
        if (p_radiusY != .0) { _x += 1 + 4 }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (p_x != .0) { _x.write(p_x) }
        if (p_y != .0) { _x.write(p_y) }
        if (p_radiusX != .0) { _x.write(p_radiusX) }
        if (p_radiusY != .0) { _x.write(p_radiusY) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_x == .0 && p_y == .0 && p_radiusX == .0 && p_radiusY == .0
    }

    protected func m_clear(): Unit {
        p_x = .0
        p_y = .0
        p_radiusX = .0
        p_radiusY = .0
    }

    public operator func !=(src: ShapeEntity_EllipseArgs): Bool { !(this == src) }
    public operator func ==(src: ShapeEntity_EllipseArgs): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields && p_x == src.p_x &&
        p_y == src.p_y && p_radiusX == src.p_radiusX && p_radiusY == src.p_radiusY
    }

    public func mergeFrom(src: ShapeEntity_EllipseArgs): Unit {
        if (src.p_x != .0) { p_x = src.p_x }
        if (src.p_y != .0) { p_y = src.p_y }
        if (src.p_radiusX != .0) { p_radiusX = src.p_radiusX }
        if (src.p_radiusY != .0) { p_radiusY = src.p_radiusY }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: ShapeEntity_EllipseArgs): ShapeEntity_EllipseArgs {
        p_x = src.p_x
        p_y = src.p_y
        p_radiusX = src.p_radiusX
        p_radiusY = src.p_radiusY
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): ShapeEntity_EllipseArgs {
        return ShapeEntity_EllipseArgs().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_x = src.parseFloat32()
                case 2 => p_y = src.parseFloat32()
                case 3 => p_radiusX = src.parseFloat32()
                case 4 => p_radiusY = src.parseFloat32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (p_x != .0) { out.append(13); out.packFixed(p_x) }
        if (p_y != .0) { out.append(21); out.packFixed(p_y) }
        if (p_radiusX != .0) { out.append(29); out.packFixed(p_radiusX) }
        if (p_radiusY != .0) { out.append(37); out.packFixed(p_radiusY) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (p_x != .0) { _x.append("x", p_x) }
        if (p_y != .0) { _x.append("y", p_y) }
        if (p_radiusX != .0) { _x.append("radiusX", p_radiusX) }
        if (p_radiusY != .0) { _x.append("radiusY", p_radiusY) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { ShapeEntity_EllipseArgs() }
    public static func newBuilder() { ShapeEntity_EllipseArgs__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = ShapeEntity_EllipseArgs(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = ShapeEntity_EllipseArgs(); _x.unpack(src); _x }
}

public class ShapeEntity_EllipseArgs__Builder {
    public var x: Float32 = Float32(.0)
    public func setX(x: Float32) { this.x = x; return this }

    public var y: Float32 = Float32(.0)
    public func setY(y: Float32) { this.y = y; return this }

    public var radiusX: Float32 = Float32(.0)
    public func setRadiusX(radiusX: Float32) { this.radiusX = radiusX; return this }

    public var radiusY: Float32 = Float32(.0)
    public func setRadiusY(radiusY: Float32) { this.radiusY = radiusY; return this }

    public func build() { ShapeEntity_EllipseArgs(this) }
}

public class ShapeEntity_ShapeStyle_RGBAColor <: MessageLite & TypedMessage<ShapeEntity_ShapeStyle_RGBAColor> {
    private var p_r: Float32
    private var p_g: Float32
    private var p_b: Float32
    private var p_a: Float32

    public init(
        r!: Float32 = Float32(.0),
        g!: Float32 = Float32(.0),
        b!: Float32 = Float32(.0),
        a!: Float32 = Float32(.0)
    ) {
        this.p_r = r
        this.p_g = g
        this.p_b = b
        this.p_a = a
        m_init()
    }

    public init(src: ShapeEntity_ShapeStyle_RGBAColor__Builder) {
        this.p_r = src.r
        this.p_g = src.g
        this.p_b = src.b
        this.p_a = src.a
        m_init()
    }

    private func m_init() {
        m_innerInit()
    }

    public mut prop r: Float32 { get() { p_r } set(_v) { p_r = _v; markDirty() } }

    public mut prop g: Float32 { get() { p_g } set(_v) { p_g = _v; markDirty() } }

    public mut prop b: Float32 { get() { p_b } set(_v) { p_b = _v; markDirty() } }

    public mut prop a: Float32 { get() { p_a } set(_v) { p_a = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (p_r != .0) { _x += 1 + 4 }
        if (p_g != .0) { _x += 1 + 4 }
        if (p_b != .0) { _x += 1 + 4 }
        if (p_a != .0) { _x += 1 + 4 }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (p_r != .0) { _x.write(p_r) }
        if (p_g != .0) { _x.write(p_g) }
        if (p_b != .0) { _x.write(p_b) }
        if (p_a != .0) { _x.write(p_a) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_r == .0 && p_g == .0 && p_b == .0 && p_a == .0
    }

    protected func m_clear(): Unit {
        p_r = .0
        p_g = .0
        p_b = .0
        p_a = .0
    }

    public operator func !=(src: ShapeEntity_ShapeStyle_RGBAColor): Bool { !(this == src) }
    public operator func ==(src: ShapeEntity_ShapeStyle_RGBAColor): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields && p_r == src.p_r &&
        p_g == src.p_g && p_b == src.p_b && p_a == src.p_a
    }

    public func mergeFrom(src: ShapeEntity_ShapeStyle_RGBAColor): Unit {
        if (src.p_r != .0) { p_r = src.p_r }
        if (src.p_g != .0) { p_g = src.p_g }
        if (src.p_b != .0) { p_b = src.p_b }
        if (src.p_a != .0) { p_a = src.p_a }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: ShapeEntity_ShapeStyle_RGBAColor): ShapeEntity_ShapeStyle_RGBAColor {
        p_r = src.p_r
        p_g = src.p_g
        p_b = src.p_b
        p_a = src.p_a
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): ShapeEntity_ShapeStyle_RGBAColor {
        return ShapeEntity_ShapeStyle_RGBAColor().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_r = src.parseFloat32()
                case 2 => p_g = src.parseFloat32()
                case 3 => p_b = src.parseFloat32()
                case 4 => p_a = src.parseFloat32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (p_r != .0) { out.append(13); out.packFixed(p_r) }
        if (p_g != .0) { out.append(21); out.packFixed(p_g) }
        if (p_b != .0) { out.append(29); out.packFixed(p_b) }
        if (p_a != .0) { out.append(37); out.packFixed(p_a) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (p_r != .0) { _x.append("r", p_r) }
        if (p_g != .0) { _x.append("g", p_g) }
        if (p_b != .0) { _x.append("b", p_b) }
        if (p_a != .0) { _x.append("a", p_a) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { ShapeEntity_ShapeStyle_RGBAColor() }
    public static func newBuilder() { ShapeEntity_ShapeStyle_RGBAColor__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = ShapeEntity_ShapeStyle_RGBAColor(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = ShapeEntity_ShapeStyle_RGBAColor(); _x.unpack(src); _x }
}

public class ShapeEntity_ShapeStyle_RGBAColor__Builder {
    public var r: Float32 = Float32(.0)
    public func setR(r: Float32) { this.r = r; return this }

    public var g: Float32 = Float32(.0)
    public func setG(g: Float32) { this.g = g; return this }

    public var b: Float32 = Float32(.0)
    public func setB(b: Float32) { this.b = b; return this }

    public var a: Float32 = Float32(.0)
    public func setA(a: Float32) { this.a = a; return this }

    public func build() { ShapeEntity_ShapeStyle_RGBAColor(this) }
}

public enum ShapeEntity_ShapeStyle_LineCap <: Enum<ShapeEntity_ShapeStyle_LineCap> {
    LineCap_BUTT | LineCap_ROUND | LineCap_SQUARE

    public func value(): Int32 {
        match(this) {
            case LineCap_BUTT => 0
            case LineCap_ROUND => 1
            case LineCap_SQUARE => 2
        }
    }

    public func toString(): String {
        match(this) {
            case LineCap_BUTT => "LineCap_BUTT"
            case LineCap_ROUND => "LineCap_ROUND"
            case LineCap_SQUARE => "LineCap_SQUARE"
        }
    }

    public operator func==(value: ShapeEntity_ShapeStyle_LineCap) {
        match((this, value)) {
            case (LineCap_BUTT, LineCap_BUTT) => true
            case (LineCap_ROUND, LineCap_ROUND) => true
            case (LineCap_SQUARE, LineCap_SQUARE) => true
            case _ => false
        }
    }

    public func isEmpty() { match (this) { case LineCap_BUTT => true case _ => false } }

    public static func empty(): ShapeEntity_ShapeStyle_LineCap { LineCap_BUTT }

    public static func parse(value: Int32): ShapeEntity_ShapeStyle_LineCap {
        match(value) {
            case 0 => LineCap_BUTT
            case 1 => LineCap_ROUND
            case 2 => LineCap_SQUARE
            case _ => throw InvalidEnumValueException("ShapeEntity_ShapeStyle_LineCap", value)
        }
    }

    public static func parse(value: String): ShapeEntity_ShapeStyle_LineCap {
        match(value) {
            case "LineCap_BUTT" => LineCap_BUTT
            case "LineCap_ROUND" => LineCap_ROUND
            case "LineCap_SQUARE" => LineCap_SQUARE
            case _ => throw UnmatchedEnumStringException("ShapeEntity_ShapeStyle_LineCap", value)
        }
    }
}

public enum ShapeEntity_ShapeStyle_LineJoin <: Enum<ShapeEntity_ShapeStyle_LineJoin> {
    LineJoin_MITER | LineJoin_ROUND | LineJoin_BEVEL

    public func value(): Int32 {
        match(this) {
            case LineJoin_MITER => 0
            case LineJoin_ROUND => 1
            case LineJoin_BEVEL => 2
        }
    }

    public func toString(): String {
        match(this) {
            case LineJoin_MITER => "LineJoin_MITER"
            case LineJoin_ROUND => "LineJoin_ROUND"
            case LineJoin_BEVEL => "LineJoin_BEVEL"
        }
    }

    public operator func==(value: ShapeEntity_ShapeStyle_LineJoin) {
        match((this, value)) {
            case (LineJoin_MITER, LineJoin_MITER) => true
            case (LineJoin_ROUND, LineJoin_ROUND) => true
            case (LineJoin_BEVEL, LineJoin_BEVEL) => true
            case _ => false
        }
    }

    public func isEmpty() { match (this) { case LineJoin_MITER => true case _ => false } }

    public static func empty(): ShapeEntity_ShapeStyle_LineJoin { LineJoin_MITER }

    public static func parse(value: Int32): ShapeEntity_ShapeStyle_LineJoin {
        match(value) {
            case 0 => LineJoin_MITER
            case 1 => LineJoin_ROUND
            case 2 => LineJoin_BEVEL
            case _ => throw InvalidEnumValueException("ShapeEntity_ShapeStyle_LineJoin", value)
        }
    }

    public static func parse(value: String): ShapeEntity_ShapeStyle_LineJoin {
        match(value) {
            case "LineJoin_MITER" => LineJoin_MITER
            case "LineJoin_ROUND" => LineJoin_ROUND
            case "LineJoin_BEVEL" => LineJoin_BEVEL
            case _ => throw UnmatchedEnumStringException("ShapeEntity_ShapeStyle_LineJoin", value)
        }
    }
}

public class ShapeEntity_ShapeStyle <: MessageLite & TypedMessage<ShapeEntity_ShapeStyle> {
    private var p_fill: PbMessage<ShapeEntity_ShapeStyle_RGBAColor>
    private var p_stroke: PbMessage<ShapeEntity_ShapeStyle_RGBAColor>
    private var p_strokeWidth: Float32
    private var p_lineCap: ShapeEntity_ShapeStyle_LineCap
    private var p_lineJoin: ShapeEntity_ShapeStyle_LineJoin
    private var p_miterLimit: Float32
    private var p_lineDashI: Float32
    private var p_lineDashII: Float32
    private var p_lineDashIII: Float32

    public init(
        fill!: ?ShapeEntity_ShapeStyle_RGBAColor = None,
        stroke!: ?ShapeEntity_ShapeStyle_RGBAColor = None,
        strokeWidth!: Float32 = Float32(.0),
        lineCap!: ShapeEntity_ShapeStyle_LineCap = ShapeEntity_ShapeStyle_LineCap.empty(),
        lineJoin!: ShapeEntity_ShapeStyle_LineJoin = ShapeEntity_ShapeStyle_LineJoin.empty(),
        miterLimit!: Float32 = Float32(.0),
        lineDashI!: Float32 = Float32(.0),
        lineDashII!: Float32 = Float32(.0),
        lineDashIII!: Float32 = Float32(.0)
    ) {
        this.p_fill = PbMessage<ShapeEntity_ShapeStyle_RGBAColor>(fill)
        this.p_stroke = PbMessage<ShapeEntity_ShapeStyle_RGBAColor>(stroke)
        this.p_strokeWidth = strokeWidth
        this.p_lineCap = lineCap
        this.p_lineJoin = lineJoin
        this.p_miterLimit = miterLimit
        this.p_lineDashI = lineDashI
        this.p_lineDashII = lineDashII
        this.p_lineDashIII = lineDashIII
        m_init()
    }

    public init(src: ShapeEntity_ShapeStyle__Builder) {
        this.p_fill = PbMessage(src.fill)
        this.p_stroke = PbMessage(src.stroke)
        this.p_strokeWidth = src.strokeWidth
        this.p_lineCap = src.lineCap
        this.p_lineJoin = src.lineJoin
        this.p_miterLimit = src.miterLimit
        this.p_lineDashI = src.lineDashI
        this.p_lineDashII = src.lineDashII
        this.p_lineDashIII = src.lineDashIII
        m_init()
    }

    private func m_init() {
        if (let Some(_v) <- p_fill.data) { m_init(_v) }
        if (let Some(_v) <- p_stroke.data) { m_init(_v) }
        m_innerInit()
    }

    public mut prop fill: ShapeEntity_ShapeStyle_RGBAColor { get() { p_fill.getOrDefault(this) } set(_v) { p_fill.set(this, _v); markDirty() } }

    public mut prop stroke: ShapeEntity_ShapeStyle_RGBAColor { get() { p_stroke.getOrDefault(this) } set(_v) { p_stroke.set(this, _v); markDirty() } }

    public mut prop strokeWidth: Float32 { get() { p_strokeWidth } set(_v) { p_strokeWidth = _v; markDirty() } }

    public mut prop lineCap: ShapeEntity_ShapeStyle_LineCap { get() { p_lineCap } set(_v) { p_lineCap = _v; markDirty() } }

    public mut prop lineJoin: ShapeEntity_ShapeStyle_LineJoin { get() { p_lineJoin } set(_v) { p_lineJoin = _v; markDirty() } }

    public mut prop miterLimit: Float32 { get() { p_miterLimit } set(_v) { p_miterLimit = _v; markDirty() } }

    public mut prop lineDashI: Float32 { get() { p_lineDashI } set(_v) { p_lineDashI = _v; markDirty() } }

    public mut prop lineDashII: Float32 { get() { p_lineDashII } set(_v) { p_lineDashII = _v; markDirty() } }

    public mut prop lineDashIII: Float32 { get() { p_lineDashIII } set(_v) { p_lineDashIII = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (let Some(_v) <- p_fill.nonEmptyData()) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_stroke.nonEmptyData()) { _x += 1 + binSize(_v) }
        if (p_strokeWidth != .0) { _x += 1 + 4 }
        if (!p_lineCap.isEmpty()) { _x += 1 + varintSize(p_lineCap) }
        if (!p_lineJoin.isEmpty()) { _x += 1 + varintSize(p_lineJoin) }
        if (p_miterLimit != .0) { _x += 1 + 4 }
        if (p_lineDashI != .0) { _x += 1 + 4 }
        if (p_lineDashII != .0) { _x += 1 + 4 }
        if (p_lineDashIII != .0) { _x += 1 + 4 }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (let Some(_v) <- p_fill.nonEmptyData()) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_stroke.nonEmptyData()) { _x.write(_v.hashCode()) }
        if (p_strokeWidth != .0) { _x.write(p_strokeWidth) }
        if (!p_lineCap.isEmpty()) { _x.write(p_lineCap.hashCode()) }
        if (!p_lineJoin.isEmpty()) { _x.write(p_lineJoin.hashCode()) }
        if (p_miterLimit != .0) { _x.write(p_miterLimit) }
        if (p_lineDashI != .0) { _x.write(p_lineDashI) }
        if (p_lineDashII != .0) { _x.write(p_lineDashII) }
        if (p_lineDashIII != .0) { _x.write(p_lineDashIII) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_fill.isEmpty() && p_stroke.isEmpty() && p_strokeWidth == .0 && p_lineCap.isEmpty() && p_lineJoin.isEmpty() &&
        p_miterLimit == .0 && p_lineDashI == .0 && p_lineDashII == .0 && p_lineDashIII == .0
    }

    protected func m_clear(): Unit {
        p_fill.removeFrom(this)
        p_stroke.removeFrom(this)
        p_strokeWidth = .0
        p_lineCap = ShapeEntity_ShapeStyle_LineCap.empty()
        p_lineJoin = ShapeEntity_ShapeStyle_LineJoin.empty()
        p_miterLimit = .0
        p_lineDashI = .0
        p_lineDashII = .0
        p_lineDashIII = .0
    }

    public operator func !=(src: ShapeEntity_ShapeStyle): Bool { !(this == src) }
    public operator func ==(src: ShapeEntity_ShapeStyle): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_fill.data == src.p_fill.data && p_stroke.data == src.p_stroke.data && p_strokeWidth == src.p_strokeWidth &&
        p_lineCap == src.p_lineCap && p_lineJoin == src.p_lineJoin && p_miterLimit == src.p_miterLimit &&
        p_lineDashI == src.p_lineDashI && p_lineDashII == src.p_lineDashII && p_lineDashIII == src.p_lineDashIII
    }

    public func mergeFrom(src: ShapeEntity_ShapeStyle): Unit {
        if (let Some(_v) <- src.p_fill.data) { p_fill.getOrDefault(this).mergeFrom(_v) }
        if (let Some(_v) <- src.p_stroke.data) { p_stroke.getOrDefault(this).mergeFrom(_v) }
        if (src.p_strokeWidth != .0) { p_strokeWidth = src.p_strokeWidth }
        if (!src.p_lineCap.isEmpty()) { p_lineCap = src.p_lineCap }
        if (!src.p_lineJoin.isEmpty()) { p_lineJoin = src.p_lineJoin }
        if (src.p_miterLimit != .0) { p_miterLimit = src.p_miterLimit }
        if (src.p_lineDashI != .0) { p_lineDashI = src.p_lineDashI }
        if (src.p_lineDashII != .0) { p_lineDashII = src.p_lineDashII }
        if (src.p_lineDashIII != .0) { p_lineDashIII = src.p_lineDashIII }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: ShapeEntity_ShapeStyle): ShapeEntity_ShapeStyle {
        p_fill.copyFrom(this, src.p_fill.data)
        p_stroke.copyFrom(this, src.p_stroke.data)
        p_strokeWidth = src.p_strokeWidth
        p_lineCap = src.p_lineCap
        p_lineJoin = src.p_lineJoin
        p_miterLimit = src.p_miterLimit
        p_lineDashI = src.p_lineDashI
        p_lineDashII = src.p_lineDashII
        p_lineDashIII = src.p_lineDashIII
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): ShapeEntity_ShapeStyle {
        return ShapeEntity_ShapeStyle().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_fill.getOrDefault(this).unpack(subReader(src))
                case 2 => p_stroke.getOrDefault(this).unpack(subReader(src))
                case 3 => p_strokeWidth = src.parseFloat32()
                case 4 => p_lineCap = ShapeEntity_ShapeStyle_LineCap.parse(src.parseInt32())
                case 5 => p_lineJoin = ShapeEntity_ShapeStyle_LineJoin.parse(src.parseInt32())
                case 6 => p_miterLimit = src.parseFloat32()
                case 7 => p_lineDashI = src.parseFloat32()
                case 8 => p_lineDashII = src.parseFloat32()
                case 9 => p_lineDashIII = src.parseFloat32()
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (let Some(_v) <- p_fill.nonEmptyData()) { out.append(10); out.packVarint(_v.size); _v.pack(out) }
        if (let Some(_v) <- p_stroke.nonEmptyData()) { out.append(18); out.packVarint(_v.size); _v.pack(out) }
        if (p_strokeWidth != .0) { out.append(29); out.packFixed(p_strokeWidth) }
        if (!p_lineCap.isEmpty()) { out.append(32); out.packVarint(p_lineCap) }
        if (!p_lineJoin.isEmpty()) { out.append(40); out.packVarint(p_lineJoin) }
        if (p_miterLimit != .0) { out.append(53); out.packFixed(p_miterLimit) }
        if (p_lineDashI != .0) { out.append(61); out.packFixed(p_lineDashI) }
        if (p_lineDashII != .0) { out.append(69); out.packFixed(p_lineDashII) }
        if (p_lineDashIII != .0) { out.append(77); out.packFixed(p_lineDashIII) }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (let Some(_v) <- p_fill.nonEmptyData()) { _x.append("fill", _v) }
        if (let Some(_v) <- p_stroke.nonEmptyData()) { _x.append("stroke", _v) }
        if (p_strokeWidth != .0) { _x.append("strokeWidth", p_strokeWidth) }
        if (!p_lineCap.isEmpty()) { _x.append("lineCap", p_lineCap) }
        if (!p_lineJoin.isEmpty()) { _x.append("lineJoin", p_lineJoin) }
        if (p_miterLimit != .0) { _x.append("miterLimit", p_miterLimit) }
        if (p_lineDashI != .0) { _x.append("lineDashI", p_lineDashI) }
        if (p_lineDashII != .0) { _x.append("lineDashII", p_lineDashII) }
        if (p_lineDashIII != .0) { _x.append("lineDashIII", p_lineDashIII) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { ShapeEntity_ShapeStyle() }
    public static func newBuilder() { ShapeEntity_ShapeStyle__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = ShapeEntity_ShapeStyle(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = ShapeEntity_ShapeStyle(); _x.unpack(src); _x }
}

public class ShapeEntity_ShapeStyle__Builder {
    public var fill: ?ShapeEntity_ShapeStyle_RGBAColor = None
    public func setFill(fill: ShapeEntity_ShapeStyle_RGBAColor) { this.fill = fill; return this }

    public var stroke: ?ShapeEntity_ShapeStyle_RGBAColor = None
    public func setStroke(stroke: ShapeEntity_ShapeStyle_RGBAColor) { this.stroke = stroke; return this }

    public var strokeWidth: Float32 = Float32(.0)
    public func setStrokeWidth(strokeWidth: Float32) { this.strokeWidth = strokeWidth; return this }

    public var lineCap: ShapeEntity_ShapeStyle_LineCap = ShapeEntity_ShapeStyle_LineCap.empty()
    public func setLineCap(lineCap: ShapeEntity_ShapeStyle_LineCap) { this.lineCap = lineCap; return this }

    public var lineJoin: ShapeEntity_ShapeStyle_LineJoin = ShapeEntity_ShapeStyle_LineJoin.empty()
    public func setLineJoin(lineJoin: ShapeEntity_ShapeStyle_LineJoin) { this.lineJoin = lineJoin; return this }

    public var miterLimit: Float32 = Float32(.0)
    public func setMiterLimit(miterLimit: Float32) { this.miterLimit = miterLimit; return this }

    public var lineDashI: Float32 = Float32(.0)
    public func setLineDashI(lineDashI: Float32) { this.lineDashI = lineDashI; return this }

    public var lineDashII: Float32 = Float32(.0)
    public func setLineDashII(lineDashII: Float32) { this.lineDashII = lineDashII; return this }

    public var lineDashIII: Float32 = Float32(.0)
    public func setLineDashIII(lineDashIII: Float32) { this.lineDashIII = lineDashIII; return this }

    public func build() { ShapeEntity_ShapeStyle(this) }
}

public enum ShapeEntity_ShapeType <: Enum<ShapeEntity_ShapeType> {
    SHAPE | RECT | ELLIPSE | KEEP

    public func value(): Int32 {
        match(this) {
            case SHAPE => 0
            case RECT => 1
            case ELLIPSE => 2
            case KEEP => 3
        }
    }

    public func toString(): String {
        match(this) {
            case SHAPE => "SHAPE"
            case RECT => "RECT"
            case ELLIPSE => "ELLIPSE"
            case KEEP => "KEEP"
        }
    }

    public operator func==(value: ShapeEntity_ShapeType) {
        match((this, value)) {
            case (SHAPE, SHAPE) => true
            case (RECT, RECT) => true
            case (ELLIPSE, ELLIPSE) => true
            case (KEEP, KEEP) => true
            case _ => false
        }
    }

    public func isEmpty() { match (this) { case SHAPE => true case _ => false } }

    public static func empty(): ShapeEntity_ShapeType { SHAPE }

    public static func parse(value: Int32): ShapeEntity_ShapeType {
        match(value) {
            case 0 => SHAPE
            case 1 => RECT
            case 2 => ELLIPSE
            case 3 => KEEP
            case _ => throw InvalidEnumValueException("ShapeEntity_ShapeType", value)
        }
    }

    public static func parse(value: String): ShapeEntity_ShapeType {
        match(value) {
            case "SHAPE" => SHAPE
            case "RECT" => RECT
            case "ELLIPSE" => ELLIPSE
            case "KEEP" => KEEP
            case _ => throw UnmatchedEnumStringException("ShapeEntity_ShapeType", value)
        }
    }
}

public class ShapeEntity <: MessageLite & TypedMessage<ShapeEntity> {
    private var p_type: ShapeEntity_ShapeType
    private var p_styles: PbMessage<ShapeEntity_ShapeStyle>
    private var p_transform: PbMessage<Transform>
    private var p_args: ShapeEntity_Oneof_Args

    public init(
        type_!: ShapeEntity_ShapeType = ShapeEntity_ShapeType.empty(),
        styles!: ?ShapeEntity_ShapeStyle = None,
        transform!: ?Transform = None,
        args!: ShapeEntity_Oneof_Args = ShapeEntity_Oneof_Args.None
    ) {
        this.p_type = type_
        this.p_styles = PbMessage<ShapeEntity_ShapeStyle>(styles)
        this.p_transform = PbMessage<Transform>(transform)
        this.p_args = args
        m_init()
    }

    public init(src: ShapeEntity__Builder) {
        this.p_type = src.type_
        this.p_styles = PbMessage(src.styles)
        this.p_transform = PbMessage(src.transform)
        this.p_args = src.args
        m_init()
    }

    private func m_init() {
        if (let Some(_v) <- p_styles.data) { m_init(_v) }
        if (let Some(_v) <- p_transform.data) { m_init(_v) }
        m_init(p_args)
        m_innerInit()
    }

    public mut prop type_: ShapeEntity_ShapeType { get() { p_type } set(_v) { p_type = _v; markDirty() } }

    public mut prop styles: ShapeEntity_ShapeStyle { get() { p_styles.getOrDefault(this) } set(_v) { p_styles.set(this, _v); markDirty() } }

    public mut prop transform: Transform { get() { p_transform.getOrDefault(this) } set(_v) { p_transform.set(this, _v); markDirty() } }

    public mut prop args: ShapeEntity_Oneof_Args { get() { p_args } set(_v) { m_assign(p_args, _v); p_args = _v; markDirty() } }

    public prop hasShape: Bool { get() { match(p_args) { case Shape(_) => true case _ => false } } }
    public mut prop shape: ShapeEntity_ShapeArgs { get() { match (p_args) { case Shape(_v) => _v case _ => throw UnexpectedOneofException() } } set(_v) { m_assign(p_args, _v); p_args = ShapeEntity_Oneof_Args.Shape(_v); markDirty() } }

    public prop hasRect: Bool { get() { match(p_args) { case Rect(_) => true case _ => false } } }
    public mut prop rect: ShapeEntity_RectArgs { get() { match (p_args) { case Rect(_v) => _v case _ => throw UnexpectedOneofException() } } set(_v) { m_assign(p_args, _v); p_args = ShapeEntity_Oneof_Args.Rect(_v); markDirty() } }

    public prop hasEllipse: Bool { get() { match(p_args) { case Ellipse(_) => true case _ => false } } }
    public mut prop ellipse: ShapeEntity_EllipseArgs { get() { match (p_args) { case Ellipse(_v) => _v case _ => throw UnexpectedOneofException() } } set(_v) { m_assign(p_args, _v); p_args = ShapeEntity_Oneof_Args.Ellipse(_v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!p_type.isEmpty()) { _x += 1 + varintSize(p_type) }
        if (let Some(_v) <- p_styles.nonEmptyData()) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_transform.nonEmptyData()) { _x += 1 + binSize(_v) }
        match (p_args) {
            case Shape(_v) => _x += 1 + binSize(_v)
            case Rect(_v) => _x += 1 + binSize(_v)
            case Ellipse(_v) => _x += 1 + binSize(_v)
            case _ => ()
        }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!p_type.isEmpty()) { _x.write(p_type.hashCode()) }
        if (let Some(_v) <- p_styles.nonEmptyData()) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_transform.nonEmptyData()) { _x.write(_v.hashCode()) }
        if (!p_args.isEmpty()) { _x.write(p_args.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_type.isEmpty() && p_styles.isEmpty() && p_transform.isEmpty() && p_args.isEmpty()
    }

    protected func m_clear(): Unit {
        p_type = ShapeEntity_ShapeType.empty()
        p_styles.removeFrom(this)
        p_transform.removeFrom(this)
        m_assign(p_args); p_args = None
    }

    public operator func !=(src: ShapeEntity): Bool { !(this == src) }
    public operator func ==(src: ShapeEntity): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_type == src.p_type && p_styles.data == src.p_styles.data && p_transform.data == src.p_transform.data &&
        p_args == src.p_args
    }

    public func mergeFrom(src: ShapeEntity): Unit {
        if (!src.p_type.isEmpty()) { p_type = src.p_type }
        if (let Some(_v) <- src.p_styles.data) { p_styles.getOrDefault(this).mergeFrom(_v) }
        if (let Some(_v) <- src.p_transform.data) { p_transform.getOrDefault(this).mergeFrom(_v) }
        if (!src.p_args.isEmpty()) { args = src.p_args.clone() }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: ShapeEntity): ShapeEntity {
        p_type = src.p_type
        p_styles.copyFrom(this, src.p_styles.data)
        p_transform.copyFrom(this, src.p_transform.data)
        m_assign(p_args); p_args = m_init(src.p_args.clone())
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): ShapeEntity {
        return ShapeEntity().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_type = ShapeEntity_ShapeType.parse(src.parseInt32())
                case 10 => p_styles.getOrDefault(this).unpack(subReader(src))
                case 11 => p_transform.getOrDefault(this).unpack(subReader(src))
                case 2 => args = ShapeEntity_Oneof_Args.Shape(ShapeEntity_ShapeArgs.fromBytes(subReader(src)))
                case 3 => args = ShapeEntity_Oneof_Args.Rect(ShapeEntity_RectArgs.fromBytes(subReader(src)))
                case 4 => args = ShapeEntity_Oneof_Args.Ellipse(ShapeEntity_EllipseArgs.fromBytes(subReader(src)))
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (!p_type.isEmpty()) { out.append(8); out.packVarint(p_type) }
        if (let Some(_v) <- p_styles.nonEmptyData()) { out.append(82); out.packVarint(_v.size); _v.pack(out) }
        if (let Some(_v) <- p_transform.nonEmptyData()) { out.append(90); out.packVarint(_v.size); _v.pack(out) }
        match (p_args) {
            case Shape(_v) => out.append(18); out.packVarint(_v.size); _v.pack(out)
            case Rect(_v) => out.append(26); out.packVarint(_v.size); _v.pack(out)
            case Ellipse(_v) => out.append(34); out.packVarint(_v.size); _v.pack(out)
            case _ => ()
        }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!p_type.isEmpty()) { _x.append("type", p_type) }
        if (let Some(_v) <- p_styles.nonEmptyData()) { _x.append("styles", _v) }
        if (let Some(_v) <- p_transform.nonEmptyData()) { _x.append("transform", _v) }
        if (!p_args.isEmpty()) { _x.append(p_args.which(), p_args) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { ShapeEntity() }
    public static func newBuilder() { ShapeEntity__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = ShapeEntity(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = ShapeEntity(); _x.unpack(src); _x }
}

public class ShapeEntity__Builder {
    public var type_: ShapeEntity_ShapeType = ShapeEntity_ShapeType.empty()
    public func setType(type_: ShapeEntity_ShapeType) { this.type_ = type_; return this }

    public var styles: ?ShapeEntity_ShapeStyle = None
    public func setStyles(styles: ShapeEntity_ShapeStyle) { this.styles = styles; return this }

    public var transform: ?Transform = None
    public func setTransform(transform: Transform) { this.transform = transform; return this }

    public var args = ShapeEntity_Oneof_Args.None
    public func setArgs(args: ShapeEntity_Oneof_Args) { this.args = args; return this }

    public func build() { ShapeEntity(this) }
}

public enum ShapeEntity_Oneof_Args <: OneofGroup & Equatable<ShapeEntity_Oneof_Args> {
    Shape(ShapeEntity_ShapeArgs) | Rect(ShapeEntity_RectArgs) | Ellipse(ShapeEntity_EllipseArgs) | None

    public func clone(): ShapeEntity_Oneof_Args {
        match (this) {
            case Shape(v) => ShapeEntity_Oneof_Args.Shape(v.clone())
            case Rect(v) => ShapeEntity_Oneof_Args.Rect(v.clone())
            case Ellipse(v) => ShapeEntity_Oneof_Args.Ellipse(v.clone())
            case _ => this
        }
    }

    public func mutableData(): ?MessageLite {
        match (this) {
            case Shape(v) => v
            case Rect(v) => v
            case Ellipse(v) => v
            case _ => Option<MessageLite>.None
        }
    }

    public func isEmpty(): Bool {
        match (this) {
            case None => true
            case _ => false
        }
    }

    public operator func !=(that: ShapeEntity_Oneof_Args): Bool { !(this == that) }
    public operator func ==(that: ShapeEntity_Oneof_Args): Bool {
        match ((this, that)) {
            case (Shape(v1), Shape(v2)) => v1 == v2
            case (Rect(v1), Rect(v2)) => v1 == v2
            case (Ellipse(v1), Ellipse(v2)) => v1 == v2
            case (None, None) => true
            case _ => false
        }
    }

    public func toString() {
        match (this) {
            case Shape(v) => v.toString()
            case Rect(v) => v.toString()
            case Ellipse(v) => v.toString()
            case None => ""
        }
    }

    public func hashCode(): Int64 {
        match (this) {
            case Shape(v) => v.hashCode()
            case Rect(v) => v.hashCode()
            case Ellipse(v) => v.hashCode()
            case None => 0
        }
    }

    public func which() {
        match (this) {
            case Shape(_) => "shape"
            case Rect(_) => "rect"
            case Ellipse(_) => "ellipse"
            case None => ""
        }
    }
}

public class FrameEntity <: MessageLite & TypedMessage<FrameEntity> {
    private var p_alpha: Float32
    private var p_layout: PbMessage<Layout>
    private var p_transform: PbMessage<Transform>
    private var p_clipPath: String
    public let shapes: RepeatedMessage<ShapeEntity>

    public init(
        alpha!: Float32 = Float32(.0),
        layout!: ?Layout = None,
        transform!: ?Transform = None,
        clipPath!: String = "",
        shapes!: Array<ShapeEntity> = []
    ) {
        this.p_alpha = alpha
        this.p_layout = PbMessage<Layout>(layout)
        this.p_transform = PbMessage<Transform>(transform)
        this.p_clipPath = clipPath
        this.shapes = RepeatedMessage<ShapeEntity>(shapes)
        m_init()
    }

    public init(src: FrameEntity__Builder) {
        this.p_alpha = src.alpha
        this.p_layout = PbMessage(src.layout)
        this.p_transform = PbMessage(src.transform)
        this.p_clipPath = src.clipPath
        this.shapes = RepeatedMessage<ShapeEntity>(src.shapes)
        m_init()
    }

    private func m_init() {
        if (let Some(_v) <- p_layout.data) { m_init(_v) }
        if (let Some(_v) <- p_transform.data) { m_init(_v) }
        m_init(shapes)
        m_innerInit()
    }

    public mut prop alpha: Float32 { get() { p_alpha } set(_v) { p_alpha = _v; markDirty() } }

    public mut prop layout: Layout { get() { p_layout.getOrDefault(this) } set(_v) { p_layout.set(this, _v); markDirty() } }

    public mut prop transform: Transform { get() { p_transform.getOrDefault(this) } set(_v) { p_transform.set(this, _v); markDirty() } }

    public mut prop clipPath: String { get() { p_clipPath } set(_v) { p_clipPath = _v; markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (p_alpha != .0) { _x += 1 + 4 }
        if (let Some(_v) <- p_layout.nonEmptyData()) { _x += 1 + binSize(_v) }
        if (let Some(_v) <- p_transform.nonEmptyData()) { _x += 1 + binSize(_v) }
        if (!p_clipPath.isEmpty()) { _x += 1 + binSize(p_clipPath) }
        if (!shapes.isEmpty()) { for (_i in shapes) { _x += 1 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (p_alpha != .0) { _x.write(p_alpha) }
        if (let Some(_v) <- p_layout.nonEmptyData()) { _x.write(_v.hashCode()) }
        if (let Some(_v) <- p_transform.nonEmptyData()) { _x.write(_v.hashCode()) }
        if (!p_clipPath.isEmpty()) { _x.write(p_clipPath.hashCode()) }
        if (!shapes.isEmpty()) { _x.write(shapes.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_alpha == .0 && p_layout.isEmpty() && p_transform.isEmpty() && p_clipPath.isEmpty() && shapes.isEmpty()
    }

    protected func m_clear(): Unit {
        p_alpha = .0
        p_layout.removeFrom(this)
        p_transform.removeFrom(this)
        p_clipPath = ""
        shapes.clear()
    }

    public operator func !=(src: FrameEntity): Bool { !(this == src) }
    public operator func ==(src: FrameEntity): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_alpha == src.p_alpha && p_layout.data == src.p_layout.data && p_transform.data == src.p_transform.data &&
        p_clipPath == src.p_clipPath && shapes == src.shapes
    }

    public func mergeFrom(src: FrameEntity): Unit {
        if (src.p_alpha != .0) { p_alpha = src.p_alpha }
        if (let Some(_v) <- src.p_layout.data) { p_layout.getOrDefault(this).mergeFrom(_v) }
        if (let Some(_v) <- src.p_transform.data) { p_transform.getOrDefault(this).mergeFrom(_v) }
        if (!src.p_clipPath.isEmpty()) { p_clipPath = src.p_clipPath }
        if (!src.shapes.isEmpty()) { shapes.appendAll(src.shapes) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: FrameEntity): FrameEntity {
        p_alpha = src.p_alpha
        p_layout.copyFrom(this, src.p_layout.data)
        p_transform.copyFrom(this, src.p_transform.data)
        p_clipPath = src.p_clipPath
        shapes.copyFrom(src.shapes)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): FrameEntity {
        return FrameEntity().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_alpha = src.parseFloat32()
                case 2 => p_layout.getOrDefault(this).unpack(subReader(src))
                case 3 => p_transform.getOrDefault(this).unpack(subReader(src))
                case 4 => p_clipPath = src.parseString()
                case 5 => s_add(shapes, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (p_alpha != .0) { out.append(13); out.packFixed(p_alpha) }
        if (let Some(_v) <- p_layout.nonEmptyData()) { out.append(18); out.packVarint(_v.size); _v.pack(out) }
        if (let Some(_v) <- p_transform.nonEmptyData()) { out.append(26); out.packVarint(_v.size); _v.pack(out) }
        if (!p_clipPath.isEmpty()) { out.append(34); out.packBin(p_clipPath) }
        if (!shapes.isEmpty()) { for (_i in shapes) { out.append(42); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (p_alpha != .0) { _x.append("alpha", p_alpha) }
        if (let Some(_v) <- p_layout.nonEmptyData()) { _x.append("layout", _v) }
        if (let Some(_v) <- p_transform.nonEmptyData()) { _x.append("transform", _v) }
        if (!p_clipPath.isEmpty()) { _x.append("clipPath", p_clipPath) }
        if (!shapes.isEmpty()) { _x.append("shapes", shapes) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { FrameEntity() }
    public static func newBuilder() { FrameEntity__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = FrameEntity(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = FrameEntity(); _x.unpack(src); _x }
}

public class FrameEntity__Builder {
    public var alpha: Float32 = Float32(.0)
    public func setAlpha(alpha: Float32) { this.alpha = alpha; return this }

    public var layout: ?Layout = None
    public func setLayout(layout: Layout) { this.layout = layout; return this }

    public var transform: ?Transform = None
    public func setTransform(transform: Transform) { this.transform = transform; return this }

    public var clipPath: String = ""
    public func setClipPath(clipPath: String) { this.clipPath = clipPath; return this }

    public var shapes: Array<ShapeEntity> = []
    public func setShapes(shapes: Array<ShapeEntity>) { this.shapes = shapes; return this }

    public func build() { FrameEntity(this) }
}

public class MovieEntity <: MessageLite & TypedMessage<MovieEntity> {
    private var p_version: String
    private var p_params: PbMessage<MovieParams>
    public let images: MapField<String, BytesSlice>
    public let sprites: RepeatedMessage<SpriteEntity>
    public let audios: RepeatedMessage<AudioEntity>

    public init(
        version!: String = "",
        params!: ?MovieParams = None,
        images!: Array<(String, BytesSlice)> = [],
        sprites!: Array<SpriteEntity> = [],
        audios!: Array<AudioEntity> = []
    ) {
        this.p_version = version
        this.p_params = PbMessage<MovieParams>(params)
        this.images = MapField<String, BytesSlice>(images)
        this.sprites = RepeatedMessage<SpriteEntity>(sprites)
        this.audios = RepeatedMessage<AudioEntity>(audios)
        m_init()
    }

    public init(src: MovieEntity__Builder) {
        this.p_version = src.version
        this.p_params = PbMessage(src.params)
        this.images = MapField<String, BytesSlice>(src.images)
        this.sprites = RepeatedMessage<SpriteEntity>(src.sprites)
        this.audios = RepeatedMessage<AudioEntity>(src.audios)
        m_init()
    }

    private func m_init() {
        if (let Some(_v) <- p_params.data) { m_init(_v) }
        m_init(images)
        m_init(sprites)
        m_init(audios)
        m_innerInit()
    }

    public mut prop version: String { get() { p_version } set(_v) { p_version = _v; markDirty() } }

    public mut prop params: MovieParams { get() { p_params.getOrDefault(this) } set(_v) { p_params.set(this, _v); markDirty() } }

    protected func m_size(): Int64 {
        var _x = 0
        if (!p_version.isEmpty()) { _x += 1 + binSize(p_version) }
        if (let Some(_v) <- p_params.nonEmptyData()) { _x += 1 + binSize(_v) }
        if (!images.isEmpty()) { for ((_k, _v) in images) { var _s = 0; if (!_k.isEmpty()) { _s += 1 + binSize(_k) }; if (!_v.isEmpty()) { _s += 1 + binSize(_v) }; _x += 1 + varintSize(_s) + _s } }
        if (!sprites.isEmpty()) { for (_i in sprites) { _x += 1 + binSize(_i) } }
        if (!audios.isEmpty()) { for (_i in audios) { _x += 1 + binSize(_i) } }
        return _x
    }

    protected func m_hashCode(): Int64 {
        var _x = DefaultHasher()
        if (!p_version.isEmpty()) { _x.write(p_version.hashCode()) }
        if (let Some(_v) <- p_params.nonEmptyData()) { _x.write(_v.hashCode()) }
        if (!images.isEmpty()) { _x.write(images.hashCode()) }
        if (!sprites.isEmpty()) { _x.write(sprites.hashCode()) }
        if (!audios.isEmpty()) { _x.write(audios.hashCode()) }
        return _x.finish()
    }

    protected func m_isEmpty(): Bool {
        p_version.isEmpty() && p_params.isEmpty() && images.isEmpty() && sprites.isEmpty() && audios.isEmpty()
    }

    protected func m_clear(): Unit {
        p_version = ""
        p_params.removeFrom(this)
        images.clear()
        sprites.clear()
        audios.clear()
    }

    public operator func !=(src: MovieEntity): Bool { !(this == src) }
    public operator func ==(src: MovieEntity): Bool {
        hashCode() == src.hashCode() && size == src.size && unknownFields == src.unknownFields &&
        p_version == src.p_version && p_params.data == src.p_params.data && images == src.images &&
        sprites == src.sprites && audios == src.audios
    }

    public func mergeFrom(src: MovieEntity): Unit {
        if (!src.p_version.isEmpty()) { p_version = src.p_version }
        if (let Some(_v) <- src.p_params.data) { p_params.getOrDefault(this).mergeFrom(_v) }
        if (!src.images.isEmpty()) { images.putAll(src.images) }
        if (!src.sprites.isEmpty()) { sprites.appendAll(src.sprites) }
        if (!src.audios.isEmpty()) { audios.appendAll(src.audios) }
        if (!src.unknownFields.isEmpty()) { unknownFields.appendAll(src.unknownFields) }
        markDirty()
    }

    public func copyFrom(src: MovieEntity): MovieEntity {
        p_version = src.p_version
        p_params.copyFrom(this, src.p_params.data)
        images.copyFrom(src.images)
        sprites.copyFrom(src.sprites)
        audios.copyFrom(src.audios)
        m_innerCopyFrom(src)
        return this
    }

    public func clone(): MovieEntity {
        return MovieEntity().copyFrom(this)
    }

    public func unpack<T>(src: T): Unit where T <: BytesReader {
        while (!src.isEmpty()) {
            let _x = src.parseTag()
            match (_x[0]) {
                case 1 => p_version = src.parseString()
                case 2 => p_params.getOrDefault(this).unpack(subReader(src))
                case 3 => let _s = subReader(src); var _k = ""; var _v = BytesSlice(); while (!_s.isEmpty()) { match (_s.parseTag()[0]) { case 1 => _k = _s.parseString() case 2 => _v = _s.parseBytesSlice() case _ => throw ParseValueExecption("map") } }; s_add(images, _k, _v)
                case 4 => s_add(sprites, src)
                case 5 => s_add(audios, src)
                case _ => m_unknown(src, _x)
            }
        }
        markDirty()
    }

    public func pack<T>(out: T): Unit where T <: BytesWriter {
        if (!p_version.isEmpty()) { out.append(10); out.packBin(p_version) }
        if (let Some(_v) <- p_params.nonEmptyData()) { out.append(18); out.packVarint(_v.size); _v.pack(out) }
        if (!images.isEmpty()) { for ((_k, _v) in images) { out.append(26); var _s = 0; if (!_k.isEmpty()) { _s += 1 + binSize(_k) }; if (!_v.isEmpty()) { _s += 1 + binSize(_v) }; out.packVarint(_s); if (!_k.isEmpty()) { out.append(10); out.packBin(_k) }; if (!_v.isEmpty()) { out.append(18); out.packBin(_v) } } }
        if (!sprites.isEmpty()) { for (_i in sprites) { out.append(34); out.packVarint(_i.size); _i.pack(out) } }
        if (!audios.isEmpty()) { for (_i in audios) { out.append(42); out.packVarint(_i.size); _i.pack(out) } }
        m_unknown(out)
    }

    public func toString(): String {
        var _x = StructPrinter()
        if (!p_version.isEmpty()) { _x.append("version", p_version) }
        if (let Some(_v) <- p_params.nonEmptyData()) { _x.append("params", _v) }
        if (!images.isEmpty()) { _x.append("images", images) }
        if (!sprites.isEmpty()) { _x.append("sprites", sprites) }
        if (!audios.isEmpty()) { _x.append("audios", audios) }
        return _x.done().toString()
    }

    public func packi(out: BytesWriter) { match (out) { case _x: SimpleWriter => pack(_x) case _ => pack(out) } }
    public func unpacki(src: BytesReader) { match (src) { case _x: SimpleReader => unpack(_x) case _ => unpack(src) } }

    public static func empty() { MovieEntity() }
    public static func newBuilder() { MovieEntity__Builder() }
    public static func fromBytes(src: Collection<Byte>) { let _x = MovieEntity(); _x.unpack(src); _x }
    public static func fromBytes(src: BytesReader) { let _x = MovieEntity(); _x.unpack(src); _x }
}

public class MovieEntity__Builder {
    public var version: String = ""
    public func setVersion(version: String) { this.version = version; return this }

    public var params: ?MovieParams = None
    public func setParams(params: MovieParams) { this.params = params; return this }

    public var images: Array<(String, BytesSlice)> = []
    public func setImages(images: Array<(String, BytesSlice)>) { this.images = images; return this }

    public var sprites: Array<SpriteEntity> = []
    public func setSprites(sprites: Array<SpriteEntity>) { this.sprites = sprites; return this }

    public var audios: Array<AudioEntity> = []
    public func setAudios(audios: Array<AudioEntity>) { this.audios = audios; return this }

    public func build() { MovieEntity(this) }
}
