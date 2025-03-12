/**
 * Created on 2025/1/9
 */
package svga.model

import ohos.base.Length
import ohos.component.FontStyle

public class TextMap {
    public var text: String
    public var size: ?Length
    public var color: ?String
    public var offset: ?TextOffset
    public var family: ?String
    public var style: ?FontStyle
    public var weight: ?SVGAFontWeight

    public init(text!: String = "", size!: ?Length = None, color!: ?String = None, offset!: ?TextOffset = None,
        family!: ?String = None, style!: FontStyle = FontStyle.Normal, weight!: ?SVGAFontWeight = None) {
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
    var x: Float64 = 0.0
    var y: Float64 = 0.0
}

public enum SVGAFontWeight {
    | normal
    | bold
    | bolder
    | lighter
    | w100
    | w200
    | w300
    | w400
    | w500
    | w600
    | w700
    | w800
    | w900

    public func toString(): String {
        match (this) {
            case normal => "normal"
            case bold => "bold"
            case bolder => "bolder"
            case lighter => "lighter"
            case w100 => "w100"
            case w200 => "w200"
            case w300 => "w300"
            case w400 => "w400"
            case w500 => "w500"
            case w600 => "w600"
            case w700 => "w700"
            case w800 => "w800"
            case w900 => "w900"
        }
    }
}
