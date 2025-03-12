/**
 * Created on 2025/1/11
 */
package svga.utils

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.file_fs.*
import encoding.base64.*
import std.random.*
import std.time.DateTime
import tpc.BasicServicesKit.zlib.decompressFile

public class FileManager {
    public static func saveAudio(src: String, fileDir: String): Int32 {
        try {
            if (!FileFs.access(fileDir)) {
                FileFs.mkdir(fileDir)
            }
            let m: Random = Random()
            m.seed = 3
            DateTime.now().nanosecond
            var filePath = fileDir + '/' + "${DateTime.now().nanosecond} + ${m.nextUInt64()}" + '.mp3'
            var file = FileFs.open(filePath, mode: READ_WRITE.mode)
            var buf = fromBase64String(src).getOrThrow()
            FileFs.write(file.fd, buf)
            return file.fd
        } catch (err: Exception) {
            AlertDialog.show(AlertDialogParamWithConfirm('保存沙箱失败' + err.toString()))
            return -1
        }
        0
    }

    public static func saveAndUnzipFile(data: Array<Byte>, p: String): ?String {
        try {
            // 创建目录
            FileFs.mkdir(p)
            var filePath = p + '/' + '.zip'
            var file = FileFs.open(filePath, mode: (READ_WRITE.mode | CREATE.mode))
            FileFs.write(file.fd, data)
            FileFs.close(file.fd)
            var path = p + '/'
            FileFs.mkdir(path)
            //(?BusinessException, ?T) -> Unit  使用tpc的解压
            decompressFile(filePath, path, {a, b =>})
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
