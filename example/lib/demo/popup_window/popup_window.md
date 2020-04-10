
[toc]

## 简介
* 名称：PopupWindow
* 概述：flutter 实现类似 android popupwindow 悬浮窗效果
* 作者：张凯晓

## 导入（安装）
  import 'package:magpie_fly/magpie_fly.dart';

## 概述
flutter 实现类似 android popupwindow 悬浮窗效果

## 使用

效果：
{{"demo": "lib/demo/popup_window/popup_window_demo.dart","jump":true}}


## 参数配置

| 参数 | 描述 |
| --- | --- |
| context | BuildContext |
| popKey | 宿主Widget key |
| popDirection  | 悬浮窗显示位置，默认下方 |
| popWidget | 悬浮窗内容Widget |
| offset  | 悬浮窗偏移量 |