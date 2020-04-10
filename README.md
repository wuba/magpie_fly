[toc]

# magpie_fly

Magpie-fly 是58集体出品组件库，封装了多种常用组件，以满足开发者需求。(Magpie-fly is a component library produced by 58 Group, which encapsulates a variety of common components to meet the needs of developers)

## Pub使用

1. Depend on it
Add this to your package's pubspec.yaml
```
dependencies:
  magpie_fly: ^0.0.1
```

2. Install it
You can install packages from the command line:
```
$ flutter pub get
```

3. Import it
Now in your Dart code, you can use:
```
import 'package:magpie_fly/magpie_fly.dart';
```

## 组件目录
lib/src/
```
lib
├── magpie_fly.dart
└── src
    ├── banner
    ├── drag
    ├── feed
    ├── horizontal_scroll
    ├── popup_window
    ├── search_input
    ├── sliver
```

## 组件清单

| 组件                 | 说明                                          |
| -------------------- | --------------------------------------------- |
| 视频滚动检测播放控件 | 用于视频列表的滚动检测和播放控制 |
| 安全区吸顶组件 | Sliver状态栏安全区吸顶 |
| 全屏拖动按钮 | 可用于右下角的广告位 |
| 尾部弹性ScrollView | 一个支持滑动回弹加载更多的组件 |
| popup_window | 一个支持任意方向上的popwindow |
| 搜索组件 | 提供常用带阴影和不带阴影的搜索组件 |



## 致谢
在开发过程中，我们使用到了一些第三方依赖库，在此特别感谢Flutter&Dart社区的开发者们。[provider](https://pub.dev/packages/provider)、[cupertino_icons](https://pub.dev/packages/cupertino_icons)、[video_player](https://pub.dev/packages/video_player)、[flutter_markdown](https://pub.dev/packages/flutter_markdown)、[android_intent](https://pub.dev/packages/android_intent)、[flutter_webview_plugin](https://pub.dev/packages/flutter_webview_plugin)、[fluttertoast](https://pub.dev/packages/fluttertoast)
