/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.model

import ohos.base.Length
import ohos.component.FontStyle
import ohos.base.Color
import kit.UIKit.*
public class TextMap {
    public var text: String
    public var size: ?Length
    public var color: ?Color
    public var offset: ?TextOffset
    public var family: ?String
    public var style: FontStyle
    public var weight: ?FontWeight

    public init(text!: String = "", size!: ?Length = None, color!: ?Color = None, offset!: ?TextOffset = None,
        family!: ?String = None, style!: FontStyle = FontStyle.Normal, weight!: ?FontWeight  = None) {
        this.text = text
        this.size = size
        this.color = color
        this.offset = offset
        this.family = family
        this.style = style
        this.weight = weight
    }
}

public class TextOffset {
    public var x: Float64
    public var y: Float64

    public init(x!: Float64 = 0.0, y!: Float64 = 0.0) {
        this.x=x
        this.y=y
    }
}

