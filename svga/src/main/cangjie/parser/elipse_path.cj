package svga.parser

import svga.proto.*

public class EllipsePath <: BezierPath {
    public var _x: Float64
    public var _y: Float64
    public var _radiusX: Float64
    public var _radiusY: Float64

    public init(
        x: Float64,
        y: Float64,
        radiusX: Float64,
        radiusY: Float64,
        transform: ?Transform,
        styles: ?ShapeEntity_ShapeStyle
    ) {
        super('', transform, styles);
        this._x = x
        this._y = y
        this._radiusX = radiusX
        this._radiusY = radiusY
        this.transform = transform
        this.styles = styles
    }
}
