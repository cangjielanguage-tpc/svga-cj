/**
 * Created on 2025/1/8
 */
package ohos_app_cangjie_svga.controller

import ohos.file_fs.*

public class SourceManager {
    private var _basePath: String = ""

    public func basePath(): String {
        return this._basePath
    }

    //  func constructor(context: Context) {
    //    this._basePath = context.cacheDir + '/svga' + util.generateRandomUUID()
    //    this.init()
    //  }

    private init() {
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
