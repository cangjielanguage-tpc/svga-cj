/**
 * Created on 2025/1/9
 */
package svga.model

import tpc.UIKit.Length

public class TextMap {
    var text: String = ""
    var size: ?Length = None
    var color: ?String = None
    var offset: ?TextOffset = None
    var family: ?String = None
    var style: ?String = None
    var weight: ?SVGAFontWeight = None
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
}
