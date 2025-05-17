/**
 * Created on 2025/1/11
 */
package svga.utils


import tpc.ImageKit.image.*
//import ohos.image.*
//import ohos.component.*
import svga.proto.MovieEntity
//import std.io.ByteBuffer
//import std.io.readToEnd
import std.collection.ArrayList
import std.collection.HashMap
import zlib4cj.*
import svga.global.*
import std.regex.*
import std.convert.*
import svga.proto.RepeatedMessage
import svga.proto.ShapeEntity_ShapeType
import svga.proto.ShapeEntity
public func Inflate(src: Array<Byte>): Future<MovieEntity> {
    let fut: Future<MovieEntity> = spawn {
        =>
        var ubuf: Array<Byte> = Array<Byte>()
        try {
            ubuf = src.slice(0, 4)
        } catch (e: Exception) {
        }
        if (ubuf.size == 4 && ubuf[0] == 80 && ubuf[1] == 75 && ubuf[2] == 3 && ubuf[3] == 4) {
            try {
                var result = InflateV1(src)
            } catch (e: Exception) {
                AlertDialog.show(AlertDialogParamWithConfirm('1.x版本解析失败' + e.toString()))
            }
            let res = MovieEntity()
            res.unpack(src.toArray())
            return res
        } else {
            let result: ArrayList<Byte> = Zlib.uncompress(src, wrap: ZLIB)
            var res = MovieEntity()
            res.unpack(result.toArray())
            var lastShapes = RepeatedMessage<ShapeEntity>()
            for (sprite in res.sprites) {
                for(frame in sprite.frames) {
                    if(frame.shapes.size>0 && frame.shapes[0].type_ == ShapeEntity_ShapeType.KEEP) {
                        frame.shapes=lastShapes
                    } else {
                    	lastShapes = frame.shapes
                    }
                }
            }
            return res
        }
    }
    return fut
}

func InflateV1(src: Array<Byte>): Unit {
    let m:Random=Random(3)
    var filePath = globalcontext.getOrThrow().tempDir + '/'+ "${DateTime.now().nanosecond} + ${m.nextUInt64()}"
    let paths = FileManager.saveAndUnzipFile(src, filePath)
    if (let Some(path) <- paths) {
        let files = FileManager.getFiles(path)
        //        console.log("解压结果==" + files?.toString())
        var version: String = "1.0"
        if (let Some(v) <- files) {
            if (v.contains("movie.binary")) {
                version = '1.5'
            }
        }
        // 读取movie.spec文件为字符串
        var str = FileManager.readString(path + "/movie.spec")
        if (str.isEmpty()) {
            return
        }
        // 替换ver键为version
        str = Regex(#""ver""#).matcher(str).replace("\"version\"")
        str = Regex(#""version":"[^"]+""#).matcher(str).replace('"version":"' + version + '"')
        let movieStartIndex = str.indexOf('"movie":').getOrThrow() + '"movie":'.size;
        let movieEndIndex = str.indexOf('}', movieStartIndex).getOrThrow() + 1;
        let movieContent = str[movieStartIndex..movieEndIndex]

        // 获取 viewBox 的宽度和高度
        let viewBoxStartIndex = movieContent.indexOf('"viewBox":').getOrThrow() + '"viewBox":'.size;
        let viewBoxEndIndex = movieContent.indexOf('}', viewBoxStartIndex).getOrThrow() + 1;
        let viewBoxContent = movieContent[viewBoxStartIndex..viewBoxEndIndex]

        // 提取 width 和 height
        let widthStartIndex = viewBoxContent.indexOf('"width":').getOrThrow() + '"width":'.size;
        let widthEndIndex = viewBoxContent.indexOf(',', widthStartIndex).getOrThrow();
        let viewBoxWidth = viewBoxContent[widthStartIndex..widthEndIndex]

        let heightStartIndex = viewBoxContent.indexOf('"height":').getOrThrow() + '"height":'.size;
        let heightEndIndex = viewBoxContent.indexOf('}', heightStartIndex).getOrThrow();
        let viewBoxHeight = viewBoxContent[heightStartIndex..heightEndIndex]

        // 使用 replace 方法替换 movie 为 params，并构建新的字符串
        str = str[0..(movieStartIndex - '"movie":'.size)] +
            "\"params\":{\"viewBoxWidth\":${viewBoxWidth},\"viewBoxHeight\":${viewBoxHeight}" + str[movieEndIndex..] // 追加剩余部分

        // 如果是videoSize 则
        if (str.contains('videoSize')) {
            //查找并提取 width、height、FPS 和 frames 的值
            var width: Int64 = 0
            try {
                var scc = Regex(#""width":(\d+)"#).matcher(str).find().getOrThrow().matchStr()
                width = Int64.parse(scc[#""width":"#.size..scc.size])
            } catch (e: Exception) {}
            var height: Int64 = 0
            try {
                var scc = Regex(#""height":(\d+)"#).matcher(str).find().getOrThrow().matchStr()
                height = Int64.parse(scc[#""height":"#.size..scc.size])
            } catch (e: Exception) {
            }
            var fps: Int64 = 0
            try {
                var scc = Regex(#""FPS":(\d+)"#).matcher(str).find().getOrThrow().matchStr()
                fps = Int64.parse(scc[#""FPS":"#.size..scc.size])
            } catch (e: Exception) {
            }
            var frames: Int64 = 0
            try {
                var scc = Regex(#""frames":(\d+)"#).matcher(str).find().getOrThrow().matchStr()
                frames = Int64.parse(scc[#""frames":"#.size..scc.size])
            } catch (e: Exception) {
            }

            // 根据提取的值构造新的 JSON 字符串
            str = Regex(#""videoSize":{[^}]*},?"#).matcher(str).replace("")
            str = Regex(#""FPS":\d+,?"#).matcher(str).replace("")
            str = Regex(#""frames":\d+,?"#).matcher(str).replace("")
            let tmpss = #", "params": { "videoBoxWidth": "# + "${width}" + #", "videoBoxHeight": "# + "${height}" +
                #", "fps": "# + "${fps}" + #", "frames": "# + "${frames}" + #" }}\n"#
            str = Regex(#"}$"#).matcher(str).replace(tmpss)
        }

        var imageObj: HashMap<String, String> = HashMap<String, String>()
        if (str.contains('images')) {
            // 找到 "images" 的开始和结束位置
            let imagesStart = str.indexOf('"images":{').getOrThrow();
            let imagesEnd = str.indexOf('}', imagesStart).getOrThrow() + 1

            // 提取 images 的子字符串
            var imagesString = str[imagesStart..imagesEnd]

            // 删除 "images" 字段，获取键值对
            imagesString = imagesString.replace('"images":', '')

            // 输出提取的 images 内容
            //          console.log(imagesString);

            // 如果需要将其转换为对象，可以再解析一次
            //          imageObj = JSON.parse(imagesString) as Record<string, string>;

        }
        var imgMap: HashMap<String, PixelMap> = HashMap<String, PixelMap>()

        if (!imageObj.isEmpty()) {
        } else {
        }
    }
}
