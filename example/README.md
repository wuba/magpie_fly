
[toc]

# Magpie-fly
Magpie-fly 是58集体出品组件库，封装了多种常用组件，以满足开发者需求。

## 功能
1. 58公众号信息
 * 显示了58公众号信息，方便58获取最新资讯
2. 组件列表和详情
 * 详情页通过加载markdown的方式进行显示
1. [使用文档](doc/magpie_ui.md)及[贡献流程文档](doc/contribution.md)
 * 介绍了组件库的使用方式和接入组件的具体流程
4. create_demo脚本
 * 自动生成demo.dart，.page.json，demo.md，让开发者能快速的接入组件

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

## 配置编辑器（二选一）
[安装Android Studio](https://flutterchina.club/get-started/editor/)
[安装Visual Studio](https://flutterchina.club/get-started/editor/#vscode)

## 运行
用编辑器打开下载好的Magpie-fly工程，运行
```
magpie_fly/example/lib/main.dart
```

## 整体设计
1. 目录结构

* 各个组件的代码在项目根目录/lib下，每个文件夹对应一个组件。
```
lib
├── magpie_ui.dart
└── src
|    ├── drag
|    │   └── draggable_btn.dart
|    ├── feed
|    │   ├── meta_consumer.dart
|    │   ├── scroll_detect_listener.dart
|    │   ├── video_meta.dart
|    │   └── video_play_model.dart
```

* 组件的演示demo以及文档都在`/example/lib/demo`目录下，每个文件夹对应一个组件，里面有`xxx_xxx_demo.dart`、对应的文档`xxx.md`以及描述组件的信息文件.page.json，执行create_demo.sh脚本之后，会自动生成默认生成这三个文件，一般不需要修改。
```
demo
│   ├── draggable_btn
│   │   ├── drag_btn_demo.dart
│   │   ├── .page.json
│   │   └── dragable_btn.md
│   ├── horizonal_scroll
│   │   ├── HorizontalScrollCustom.dart
│   │   ├── HorizontalScrollDefault.dart
│   │   ├── HorizontalScrollText.dart
│   │   ├── component
│   │   │   └── card.dart
│   │   └── horizonal_scroll.md
│   │   └── .page.json
```

2 组件详情页采用markdown+组件+代码的组合方式，介绍组件的详细信息和组件效果，在查看文档的同时还能操作具体组件。
![](http://wos.58cdn.com.cn/IjGfEdCbIlr/ishare/2921ed14-4356-4651-9466-74d8bb855ee3效果.jpg)

## 组件接入
请参考[how_to_add_component.md](doc/how_to_add_component.md)

## 整体效果
![](Magpie.gif)

## Magpie-fly优势
- 整合了开发过程中常用的组件
- 采用Markdown+组件+代码的方式介绍具体组件的使用和效果
- 可添加常用widget的使用方式，让想学习flutter
快速上手