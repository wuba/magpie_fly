<!-- 这是只是一个例子 -->

## 简介
* 名称：NestedScrollViewHeaderSliversBuilder
* 概述：安全区吸顶组件
* 作者：吴朝彬

## 导入（安装）

> import 'package:magpie_fly/magpie_fly.dart';

## 概述
混合吸顶处理可以结合`SliverAppbar`，吸顶效果根据头部的交互差异有不同效果。NestedScrollViewHeaderSliversBuilder提供了一种简单的吸顶效果。

## 使用
pinnedBuilder可以配合NestedScrollView的headerSliverBuilder使用。

效果：
{{"demo": "lib/demo/pinned_sliver/pinned_sliver_demo.dart", "jump":true, "appbar": false}}


## 参数配置

| 参数 | 描述 |
| --- | --- |
| placeHolderSize | 状态栏渐变的最大高度 |
| color | 状态栏吸顶颜色，滑动过程中会绑定透明度渐变 |
| height | 整个header的固定高度 |
| headerBuilder | 作为header展示的内容 |
| builder |返回header之外的其他headerSliverBuilder |

  