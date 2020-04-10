## 简介
* 名称：ScrollDetectListener
* 概述：视频滚动检测播放控件
* 作者：吴朝彬

## 导入（安装）
 
> import 'package:magpie_fly/magpie_fly.dart';

## 概述
* 视频列表Feed流中对视频的播放控制
* 插件本身没有内嵌播放器，Demo使用了video_player插件，接入时可以选择性替换为自身的视频播放器。

## 使用

* 使用ScrollDetectListener包裹ListView，ListView为业务相关的视频流帖子。
* 视频帖子使用MetaConsumer包裹；

效果：
{{"demo": "lib/demo/video/video_feed_demo.dart", "jump":true}}

## 参数配置

| 参数 | 描述 |
| --- | --- |
| detect | 初次展示列表时是否主动触发播放检测 |
| offset | 检测起始位置，如果非全屏，写列表上方的高度|
|percentIn|帖子被认定处于屏幕内的最小百分比，低于改值时帖子只有部分在屏幕内，不会触发播放|
| onVisible | 检测回调，参数为检测到的屏幕中视频帖子数组|
| child | 展示列表|

  