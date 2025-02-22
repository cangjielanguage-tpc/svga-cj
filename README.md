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

- 兼容svga 1.x，2.0版本资源；

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

### 功能示例

用例代码在entry目录下 [功能示例](entry/src/main/cangjie/src/index.cj)

## 约束与限制

在下述版本验证通过：

    DevEco Studio 5.0.2 Release(5.0.7.200) 
    Cangjie Support Plugin 5.0.7.100

## 开源协议

本项目基于 [Apache License 2.0](./LICENSE)，请自由的享受和参与开源。

## 参与贡献

欢迎给我们提交 PR，欢迎给我们提交 Issue，欢迎参与任何形式的贡献。