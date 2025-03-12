/**
 * Created on 2025/1/8
 */
package svga.player

import std.random.*
import std.time.DateTime

public class SourceManager {
    private var _basePath: String = ""

    public func basePath(): String {
        return this._basePath
    }

    init(context: AbilityContext) {
        let m: Random = Random()
        m.seed = 3
        DateTime.now().nanosecond
        this._basePath = context.filesDir + '/svga' + "${DateTime.now().nanosecond} + ${m.nextUInt64()}"
        initSourceManager()
    }

    private func initSourceManager() {
        spawn {
            => FileFs.mkdir(this._basePath)
        }
    }

    public func release() {
        spawn {
            => if (FileFs.access(this._basePath)) {
                FileFs.rmdir(this._basePath)
            }
        }
    }
}
