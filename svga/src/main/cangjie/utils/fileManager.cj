/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025-2025. All rights reserved.
 */
package svga.utils

import ohos.file_fs.*
import stdx.encoding.base64.*
internal import std.random.*
internal import std.time.DateTime
import std.fs as stdfs
import ohos.hilog.Hilog
import std.io.readToEnd

public class FileManager {

    public static func readString(path: String): String {
        if (!FileFs.access(path)) {
            return ""
        }
        return FileFs.readText(path)
    }
}
