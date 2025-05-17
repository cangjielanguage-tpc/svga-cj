/**
 * Created on 2025/1/9
 */
package svga.model

//import ohos.base.Length
//import ohos.component.FontStyle
import tpc.UIKit.component_interop.*
public class TextMap {
    public var text: String
    public var size: ?Length
    public var color: ?String
    public var offset: ?TextOffset
    public var family: ?String
    public var style: String
    public var weight: ?SVGAFontWeight

    public init(text!: String = "", size!: ?Length = None, color!: ?String = None, offset!: ?TextOffset = None,
        family!: ?String = None, style!: String = "", weight!: ?SVGAFontWeight = None) {
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
            case w100 => "100"
            case w200 => "200"
            case w300 => "300"
            case w400 => "400"
            case w500 => "500"
            case w600 => "600"
            case w700 => "700"
            case w800 => "800"
            case w900 => "900"
        }
    }
}
