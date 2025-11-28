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

    init(_: Context) {
        let m: Random = Random(3)
        this._basePath = "svga" + "${DateTime.now().nanosecond} + ${m.nextUInt64()}"
        initSourceManager()
    }

    private func initSourceManager() {
    }

    public func release(): Unit {
    }
}
