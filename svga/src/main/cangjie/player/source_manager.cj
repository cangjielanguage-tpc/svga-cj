/**
 * Created on 2025/1/8
 */
package svga.player

import tpc.CoreFileKit.fs.*
import tpc.AbilityKit.Context
import std.random.*
import std.time.DateTime

public class SourceManager {
    private var _basePath: String = ""

    public func basePath(): String {
        return this._basePath
    }

    init(context: Context) {
        let m: Random = Random()
        m.seed = 3
        DateTime.now().nanosecond
        this._basePath = context.cacheDir + '/svga' + "${DateTime.now().nanosecond} + ${m.nextUInt64()}"
        initSourceManager()
    }

    private func initSourceManager() {
        spawn {
            => mkdir(this._basePath)
        }
    }

    public func release() {
        spawn {
            => if (access(this._basePath)) {
                rmdir(this._basePath)
            }
        }
    }
}
