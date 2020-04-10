## 简介
* 名称：SearchInput
* 概述：支持阴影效果的输入框
* 作者：李义新

## 导入（安装）
    import 'package:magpie_fly/magpie_fly.dart';

## 概述
* 本组件可以设置输入框描边阴影效果，也可以纯色描边，解决TextFiled不支持border渐变描边。


## 使用

 * 默认带阴影效果（isBorderShadow=false可以关闭阴影）

{{"demo": "lib/demo/search_input/search_input_demo.dart"}}


## 属性

| 参数 | 描述 |
| --- | --- |
| isBorderShadow | 是否描边带阴影 |
| prefixIconColor | 放大镜icon颜色 |
| borderColor | 描边颜色 |
| fillColor | 填充颜色 |
| hintText | 提示文案 |
| hintTextColor | 提示文字颜色 |
| blurRadius | 描边宽度 |
| circleRadius | 圆角弧度 |
