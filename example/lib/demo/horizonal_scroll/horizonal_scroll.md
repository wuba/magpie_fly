
# HorizontalScrollView

## 简介
* 名称：HorizontalScrollView
* 概述：带阻尼回弹效果的横向加载更多组件，可用默认样式，也可自定义样式
* 作者：吴丹

## 导入（安装）
    import 'package:magpie_fly/magpie_fly.dart';

## 概述
* 支持滑动到最右侧之后显示画圆弧加载效果
* 支持滑动到最右侧之后显示text类型的加载中效果
* 支持自定义最右侧加载更多视图效果
* 使用简单，易于上手
* 纯flutter实现，不容易带来兼容问题

## 使用
### 使用默认底部样式
{{"demo": "lib/demo/horizonal_scroll/HorizontalScrollDefault.dart", "code": true}}

### 使用带文字底部样式
{{"demo": "lib/demo/horizonal_scroll/HorizontalScrollText.dart", "code": true}}

### 使用自定义底部样式
{{"demo": "lib/demo/horizonal_scroll/HorizontalScrollCustom.dart", "code": true}}

## 参数配置

| 参数 | 描述 |
| --- | --- |
| itemCount | scrollview上的item个数 |
| footerWidth | 底部footer的宽度 |
| onFooterLoadingCallBack | 加载更多回调 |
| footerView | 底部footerview，已实现FooterDefaultView和FooterTextView |
| footerShowStyle | 有三个值： dismiss：回弹之后footer全部不显示；showHalf：回弹之后footer显示一半；showWhole：回弹之后footer全部显示 |
| footViewFlowScrollAlways | 滑动到最后，footerview是否跟着scrollview滑动 |
| itembuilder | scollview上的item实现 |