/**
 * Created on 2025/1/11
 */
package svga.utils

import tpc.CoreFileKit.fs.*
import tpc.UIKit.AlertDialog
import tpc.UIKit.AlertDialogParamWithConfirm
import encoding.base64.*
import std.random.*
import std.time.DateTime

public class FileManager {
    public static func saveAudio(src: String, fileDir: String): Int32 {
        try {
            if (!access(fileDir)) {
                mkdir(fileDir)
            }
            let m: Random = Random()
            m.seed = 3
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
}
