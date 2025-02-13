/**
 * Created on 2025/1/16
 */
package svga.parser

import svga.proto.*
import tpc.UIKit.ResourceStr

public type Tag = UInt32

public type SuccessFn = (MovieEntity) -> Unit

public type FailureFn = (Object) -> Unit

public class Parser {
    init() {
    }

    /**
     * url: 资源路径
     * success(VideoEntity videoItem)
     */
    public func load(url: ResourceStr, success: SuccessFn, failure: FailureFn) {
        this.loadViaWorker(url, success, failure);
    }

    public func loadViaWorker(url: ResourceStr, success: SuccessFn, failure: FailureFn) {
        MockWorker.load(
            url,
            {
                MockWorkerResponseData => success(MockWorkerResponseData.movie);
            },
            failure
        )
    }
}
