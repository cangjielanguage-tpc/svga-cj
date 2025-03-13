<div align="center">
<h1>svga-cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v1.0.0-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.53.18-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-NA-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## 介绍

svga-cj是一个动画库，它可以解析svga格式的动画，并在移动设备上进行本地渲染。

## 特性

- 支持加载svga格式的动画
- 支持动画播放，暂停，快进等功能

### 源码目录

```shell
/svga-cj             # 项目根目录
├─AppScope
├─doc                         # API文档和使用手册存放目录                   
├─entry                       # 示例代码文件夹    
├─hvigor                      # 构建工具目录              
├─svga                        # 弹幕库文件夹                   
│  └─src
│      └─main
│          ├─cangjie
│          │  └─src           # 库源代码目录
│          └─resources
├─README.md                   # svga库介绍及使用说明
```
### 接口说明

主要类和函数接口说明详见 [API](doc/feature_api.md)

## 使用说明

### 编译构建
1. 通过module引入
    1. 克隆下载项目
    2. 将svga模块拷贝到应用项目下
    3. 将svga模块当module引用，修改项目下的 build-profile.json5 文件，在 modules 字段添加下面代码
       ```json
       {
       "name": "svga",
       "srcPath": "./svga"
       }
       ```
    4. 修改自身应用 entry 下的 oh-package.json5 文件，在 dependencies 字段添加 "svga": "file:../svga"
       ```json
       {
          "name": "entry",
          "version": "1.0.0",
          "description": "Please describe the basic information.",
          "main": "",
          "author": "",
          "license": "",
         "dependencies": {
             "svga": "file:../svga"
         }
       }
       ```
    5. 修改自身应用 entry/src/main/cangjie 下的 cjpm.toml 文件，在 [dependencies] 字段下添加 svga = {path = "../../../../svga/src/main/cangjie", version = "1.0.0"}
       ```toml
       [dependencies]
           svga = {path = "../../../../svga/src/main/cangjie", version = "1.0.0"}
       ```
    6. 在项目中使用 import svga.* 引用svga项目
       ```cangjie
       import svga.*
       ```

### 功能示例

```cangjie
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import svga.*
import svga.player.*

@HybridComponentEntry
@Component
class Index {
    @State
    var controller: SvgaController = SvgaController()
    public func build() {
        Column {
              SvgaPlayer(url: "angel.svga",abilitycontext: getContext(),controller: controller)
        }
    }
}
```

## 约束与限制

在下述版本验证通过：

    DevEco Studio 5.0.2 Release(5.0.7.200) 
    Cangjie Support Plugin 5.0.7.100

1. 只支持2.0版本svga资源
2. 不支持音频动画播放

## 开源协议

本项目基于 [Apache License 2.0](./LICENSE)，请自由的享受和参与开源。

## 参与贡献

欢迎给我们提交 PR，欢迎给我们提交 Issue，欢迎参与任何形式的贡献。