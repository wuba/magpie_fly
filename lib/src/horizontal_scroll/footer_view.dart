import 'dart:math';
import 'package:flutter/material.dart';
import 'footer_default_painter.dart';

abstract class FootBaseView {
  //outRangeOffset ：超出scrollview的contentsize部分
  void onScrollUpdate(ScrollController scrollController, double outRangeOffset){}
}

_FooterDefaultViewState _state;
//默认的footerview
class FooterDefaultView extends StatefulWidget implements FootBaseView{

  FooterDefaultView({@required this.height, this.width = 70});
  
  final double width;
  final double height;

  @override
  State<StatefulWidget> createState() {
    _state = _FooterDefaultViewState();
    return _state;
  }

  @override
  void onScrollUpdate(ScrollController scrollController, double outRangeOffset) {
    if(_state != null) {
      _state.onScrollUpdate(scrollController, outRangeOffset);
    }
  }
}

class _FooterDefaultViewState extends State<FooterDefaultView>{

  TopicFooterPainter _footerPainter;

  @override
  void dispose() {
    super.dispose();
    _state = null;
  }

  void onScrollUpdate(ScrollController scrollController, double outRangeOffset) {
    var _fresh = false;
    var arcWidth = 0.0;
    //大于widget.width的部分画半圆
    if(outRangeOffset > widget.width){
      arcWidth = outRangeOffset - widget.width;
    }
    arcWidth = min(widget.height / 2, arcWidth);
    if (_footerPainter.arcWidth != arcWidth) {
      _footerPainter.arcWidth = arcWidth;
      _footerPainter.text = arcWidth>0?'松开查看':'查看更多';
      _fresh = true;
    }

    if (_fresh) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _footerPainter =
        TopicFooterPainter(rectWidth: widget.width, text: '查看更多');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CustomPaint(
          painter: _footerPainter,
          size: Size(widget.width + _footerPainter.arcWidth, widget.height),
        ),
      );
  }
}


//直接显示text的footerview
class FooterTextView extends StatelessWidget implements FootBaseView{
  FooterTextView({@required this.height, this.width = 70, this.text = '加载中...'});
  
  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Center(
        child: Text(text),
      ),
    );
  }

  @override
  void onScrollUpdate(ScrollController scrollController, double footerViewX) {
  }

}