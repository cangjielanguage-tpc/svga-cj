/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.player

import std.random.*
import std.time.DateTime

public class SourceManager {
    private var _basePath: String = ""

    public func basePath(): String {
        return this._basePath
    }

    init(context: Context) {
        let m: Random = Random(3)
        this._basePath = context.cacheDir + '/svga' + "${DateTime.now().nanosecond} + ${m.nextUInt64()}"
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
