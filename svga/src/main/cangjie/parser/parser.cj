package svga.parser

import svga.proto.*

public type Tag = UInt32

public type SuccessFn = (MovieEntity) -> Unit

public type FailureFn = (Object) -> Unit

public class Parser {
    public init(ABcontext: AbilityContext) {
        globalcontext = ABcontext
    }

    /**
     * url: 资源路径
     * success(VideoEntity videoItem)
     */
    public func load(url: String): ?MovieEntity {
        this.loadViaWorker(url)
    }

    public func loadViaWorker(url: String): ?MovieEntity {
        MockWorker.load(url)
    }
}
