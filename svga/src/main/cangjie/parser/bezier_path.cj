/**
 * Created on 2025/1/9
 */
package svga.parser

public class BezierPath {
    var d: String
    //  var transform: ?Transform;
    //  var styles: ?ShapeStyle | undefined;
    var _shape: ?String = None;
    //  init(d: string, transform: Transform | undefined, styles: ShapeStyle | undefined) {
    init(d: String) {
        this.d = d
    }
}
