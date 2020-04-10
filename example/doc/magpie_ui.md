
[toc]

# Magpie Fly使用文档

## 简介
Magpie Fly 是58集体出品组件库，封装了多种常用组件，以满足开发者需求。<br>

包含内容：

* 视频Feed流滚动探测播放插件

* 混合嵌套列列表中的吸顶安全区解决⽅方案

* 一个支持多种形式的高性能轮播组件

* 一个带阻尼回弹效果的横向加载更多组件

* 一个任意位置，箭头跟踪View的弹层效果组件

* 可拖动的按钮（可用于悬浮广告位)

* 带阴影描边的搜索输入框


## 基础环境

开始使用前，请确保基础环境配置正常<br>
如有问题，请参考https://flutterchina.club/setup-macos/

* `flutter --version`
```
Flutter 1.12.13+hotfix.6 • channel beta • https://github.com/flutter/flutter.git
Framework • revision 18cd7a3601 (13 天前) • 2019-12-11 06:35:39 -0800
Engine • revision 2994f7e1e6
Tools • Dart 2.7.0
```

* `dart --version`
```
Dart VM version: 2.7.0 (Mon Dec 2 20:10:59 2019 +0100) on "macos_x64"
```

* `pub --version`
```
Pub 2.7.0
```

* `flutter doctor`
```
检查有没有缺失项
```

## 使用方式

* 添加依赖
```
dependencies
    magpie_fly: ^0.0.1
```
* 下载依赖
```
flutter pub get
```
* 导入
```
import 'package:magpie_fly/magpie_fly.dart';
```


## 如何快速创建组件模块？
参考: [快速接入组件](doc/how_to_add_component.md)


