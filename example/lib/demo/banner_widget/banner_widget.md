<!-- 这是只是一个例子 -->

## 简介
* 名称：轮播组件
* 概述：一个定时自定义的轮播组件
* 作者：linyueyang

## 导入（安装）
  import 'package:magpie_fly/magpie_fly.dart';

## 概述
构成简单分三个部分
1.PageView
2.Timer定时器实现轮播
3.指示器

页面主体基于PageView，对外暴露单页View自定义；Timer定时器实现轮播，
PageController 控制页面自定播放，监听页面变换，同步指示器。

## 使用

效果：
{{"demo": "lib/demo/banner_widget/banner_widget_demo.dart", "code": true}}

## 参数配置

| 参数 | 描述 |
| --- | --- |
| buildShowView | 每页Widget |
| data | List数据集 |
| height | 组件高度 |
| width | 组件宽度 |
| delayTime | 延迟轮播时间 |
| scrollTime | 单次轮播时间 |
| onBannerClickListener | 单次轮播时间 |
| indicatorSelectColor | 指示器选中颜色 |
| indicatorRadius | 指示器大小 |
| indicatorRight | 指示器位置距右侧 |
| indicatorBottom | 指示器位置距底部 |