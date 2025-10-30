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
    public static func saveAudio(src: String, fileDir: String): Int32 {
        try {
            if (!FileFs.access(fileDir)) {
                FileFs.mkdir(fileDir)
            }
            let m: Random = Random(3)
            DateTime.now().nanosecond
            var filePath = fileDir + '/' + "${DateTime.now().nanosecond} + ${m.nextUInt64()}" + '.mp3'
            var file = FileFs.open(filePath, mode: OpenMode.READ_WRITE.mode)
            var buf = fromBase64String(src).getOrThrow()
            FileFs.write(file.fd, buf)
            return file.fd
        } catch (err: Exception) {
            Hilog.error(0, "ERROR", "Failed to save sandbox ,error ${err.toString()}")
            return -1
        }
        0
    }

    public static func saveAndUnzipFile(data: Array<Byte>, p: String): ?String {
        try {
            FileFs.mkdir(p)
            let m: Random = Random(3)
            var filePath = p + '/' + "${DateTime.now().nanosecond}" + " ${m.nextUInt64()}" + '.zip'
            var file1 = FileFs.open(filePath, mode: (READ_WRITE.mode | CREATE.mode))
            FileFs.close(file1.fd)
            var file = stdfs.File(filePath, stdfs.OpenMode.ReadWrite)
            file.write(data)
            file.close()
            var file2 = stdfs.File(filePath, stdfs.OpenMode.Read)
            var res = readToEnd(file2)
            file2.close()
            let m1: Random = Random(3)
            var path = p + '/' + "${DateTime.now().nanosecond}" + "${m1.nextUInt64()}"
            FileFs.mkdir(path)
            return path
        } catch (e: Exception) {
            return None
        }
    }

    public static func removeFile(path: String): Unit {
        try {
            let stat = FileFs.stat(path)
            if (stat.isFile()) {
                FileFs.unlink(path)
            } else if (stat.isDirectory()) {
                FileFs.rmdir(path)
            }
        } catch (e: Exception) {
        }
    }

    public static func getFiles(path: String): ?Array<String> {
        try {
            if (!FileFs.access(path)) {
                return None
            }
            if (!FileFs.stat(path).isDirectory()) {
                return None
            }
            return FileFs.listFile(path)
        } catch (e: Exception) {
            return None
        }
    }

    public static func readString(path: String): String {
        if (!FileFs.access(path)) {
            return ""
        }
        return FileFs.readText(path)
    }
}
