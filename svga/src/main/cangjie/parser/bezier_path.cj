/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.parser

import svga.proto.*

public open class BezierPath {
    public var d: String
    public var transform: ?Transform
    public var styles: ?ShapeEntity_ShapeStyle
    public var _shape: ?String = None;
    public init(d: String, transform: ?Transform, styles: ?ShapeEntity_ShapeStyle) {
        this.d = d
        this.transform = transform
        this.styles = styles
    }
}
