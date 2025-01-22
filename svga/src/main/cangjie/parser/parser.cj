/**
 * Created on 2025/1/16
 */
package ohos_app_cangjie_svga.parser

import ohos_app_cangjie_svga.proto.*
import ohos.resource_manager as UIresource

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
    public func load(url: UIresource.Resource, success: SuccessFn, failure: FailureFn) {
        //this.loadViaWorker(url, success, failure);
    }

    public func loadViaWorker(url: UIresource.Resource, success: SuccessFn, failure: FailureFn) {
        //        MockWorker(url, (data: MockWorkerResponseData) => {
        //          success(data.movie);
        //        }, failure)
    }
}

