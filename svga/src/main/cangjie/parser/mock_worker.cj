/**
 * Created on 2025/2/6
 */
package svga.parser

import svga.proto.*
import tpc.ImageKit.image.*

public type DecodeCbFn = (MockWorkerDecodeResponseData) -> Unit

public open class MockWorkerDecodeResponseData {
    public var key: String = ""

    public var bitmap: ?PixelMap = None

    public var fd: ?Float64 = None
}
