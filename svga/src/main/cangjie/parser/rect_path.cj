/**
 * Created on 2025/2/7
 */
package svga.parser

import svga.proto.*

public class RectPath <: BezierPath {
    public var _x: Float64
    public var _y: Float64
    public var _width: Float64
    public var _height: Float64
    public var _cornerRadius: Float64

    public init(
        x: Float64,
        y: Float64,
        width: Float64,
        height: Float64,
        cornerRadius: Float64,
        transform: ?Transform,
        styles: ?ShapeEntity_ShapeStyle
    ) {
        super('', transform, styles);
        this._x = x
        this._y = y
        this._width = width
        this._height = height
        this._cornerRadius = cornerRadius
        this.transform = transform
        this.styles = styles
    }
}
