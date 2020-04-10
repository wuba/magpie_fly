import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//回弹printer
//需要画圆弧、长方形、text

class TopicFooterPainter extends CustomPainter {
  TopicFooterPainter(
      {this.text,
      this.arcWidth = 0,
      this.rectWidth = 0,
      this.startDrawX = 0,
      this.textStyle});
  double arcWidth; //圆弧的size
  double rectWidth; //矩形的size
  double startDrawX; //开始绘制的x坐标
  String text; //需要绘制的text
  TextStyle textStyle;
  Color paintColor; //画笔颜色
  Paint dPaint = Paint(); //画笔
  Path _arcPath; //画圆弧的path

  @override
  void paint(Canvas canvas, Size size) {
    //给画笔设置属性
    dPaint
      ..color =
          paintColor == null ? Color.fromRGBO(237, 239, 241, 1) : paintColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 3;

    //设置圆弧的最大宽度，圆弧最大为半圆，所以宽最大为高的一半
    arcWidth = min(arcWidth, size.height / 2);
    //圆弧的宽大于0，画圆弧
    if (arcWidth > 0) {
      _drawArc(canvas, size, dPaint);
    }
    //画矩形
    if (rectWidth > 0) {
      canvas.drawRect(
          Rect.fromLTRB(arcWidth + startDrawX, 0,
              arcWidth + rectWidth + startDrawX + 10, size.height),
          dPaint);
    }
    //画文字
    if (text != null && text.length > 0) {
      _drawText(canvas, size, dPaint);
    }
  }

  //画圆弧
  void _drawArc(Canvas canvas, Size size, Paint paint) {
    if (_arcPath == null) {
      _arcPath = Path(); //初始化
    }
    _arcPath.reset(); //重置
    if (size.width <= rectWidth) {
      //总的宽度小于矩形的宽，不画圆弧
      return;
    }
    //贝塞尔曲线画圆弧
    var startPoint = Offset(arcWidth + startDrawX, 0); //圆弧起点
    var controlPoint1 = Offset(startDrawX - arcWidth * 0.2, 0); //圆弧控制点1
    var controlPoint2 =
        Offset(startDrawX - arcWidth * 0.2, size.height); //圆弧控制点2
    var endPoint = Offset(arcWidth + startDrawX, size.height); //圆弧终点

    _arcPath.moveTo(startPoint.dx, startPoint.dy);
    _arcPath.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    canvas.drawPath(_arcPath, paint);
  }

  //垂直绘制文字
  void _drawText(Canvas canvas, Size size, Paint paint) {
    if (textStyle == null) {
      textStyle =
          TextStyle(color: Color.fromRGBO(141, 145, 147, 1), fontSize: 15);
    }
    var left = arcWidth + startDrawX;
    var textWidth = 0.0; //一个字的宽度
    //中心点
    var offsetX = left + rectWidth / 2.0 - textWidth / 2.0;
    var offsetY = (size.height - _findAllTextHeight()) / 2;
    //遍历text，一个字一个字的画上去
    for (var rune in text.runes) {
      var str = String.fromCharCode(rune);
      var span = TextSpan(style: textStyle, text: str);
      var tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl);
      tp.layout();
      tp.paint(canvas, Offset(offsetX, offsetY));
      offsetY += tp.height;
    }
  }

  //得到text文字的所有总高度
  double _findAllTextHeight() {
    var allHeight = 0.0;
    for (var rune in text.runes) {
      var str = String.fromCharCode(rune);
      var span = TextSpan(style: textStyle, text: str);
      var tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      allHeight += tp.height;
    }
    return allHeight;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
