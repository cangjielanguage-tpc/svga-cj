/**
 * Created on 2025/1/11
 */
package svga.utils

//import ohos.file_fs.*
import tpc.CoreFileKit.fs.*
internal import tpc.UIKit.*
import encoding.base64.*
internal import std.random.*
internal import std.time.DateTime
//import kit.AbilityKit.*
import std.fs as stdfs
//import std.io.readToEnd
public class FileManager {
    public static func saveAudio(src: String, fileDir: String): Int32 {
        try {
            if (!access(fileDir)) {
                mkdir(fileDir)
            }
            let m: Random = Random(3)
            DateTime.now().nanosecond
            var filePath = fileDir + '/' + "${DateTime.now().nanosecond} + ${m.nextUInt64()}" + '.mp3'
            var file = open(filePath, mode: OpenMode.READ_WRITE)
            var buf = fromBase64String(src).getOrThrow()
            write(file.fd, buf)
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
            mkdir(p)
            let m: Random = Random(3)
            var filePath = p + '/' + "${DateTime.now().nanosecond} + ${m.nextUInt64()}" + '.zip'
            var file1 = open(filePath, mode: (OpenMode.READ_WRITE | OpenMode.CREATE))
            close(file1.fd)
            var file = stdfs.File(filePath,stdfs.OpenOption.Open(true,true))
            file.write(data)
            file.close()
            var file2 = stdfs.File(filePath,stdfs.OpenOption.Open(true,false))
//            var res=readToEnd(file2)
            file2.close()
            let m1: Random = Random(3)
            var path = p + '/' + "${DateTime.now().nanosecond} + ${m1.nextUInt64()}"
            mkdir(path)
//            Zip.deCompressFile(filePath,path)
            return path
        } catch (e: Exception) {
            return None
        }
    }

    public static func removeFile(path: String): Unit {
        try {
            let stat = stat(path)
            if (stat.isFile()) {
                unlink(path)
            } else if (stat.isDirectory()) {
                rmdir(path)
            }
        } catch (e: Exception) {
        }
    }

    public static func getFiles(path: String): ?Array<String> {
        try {
            if (!access(path)) {
                return None
            }
            if (!stat(path).isDirectory()) {
                return None
            }
            return listFile(path)
        } catch (e: Exception) {
            return None
        }
    }

    public static func readString(path: String): String {
        if (!access(path)) {
            return ""
        }
        return readText(path)
    }
}
