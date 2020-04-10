//底部加载更多

import 'dart:math';
import 'package:flutter/material.dart';
import 'footer_view.dart';

enum FooterViewShowStyle {
  dismiss, //滑动到最底部，回弹之后，不显示footerview
  showHalf, //滑动到最底部，回弹之后，显示一半footerview3
  showWhole //滑动到最底部，回弹之后，完全footerview
}

class HorizontalScrollView extends StatefulWidget {
  HorizontalScrollView(
      {this.footerView, //footerview可用定义好的，也可自定义
      this.itemMargin = const EdgeInsets.all(0),
      this.itembuilder,
      this.itemCount = 0,
      this.footerWidth = 0,
      this.width,
      this.height,
      this.footerShowStyle = FooterViewShowStyle.showHalf,
      this.footViewFlowScrollAlways = false,
      this.onFooterLoadingCallBack});

  final EdgeInsets itemMargin;
  final IndexedWidgetBuilder itembuilder;
  final int itemCount;
  final Widget footerView;
  final FooterViewShowStyle footerShowStyle;
  final bool footViewFlowScrollAlways; //footerview滑动到它的宽度之后，是否还跟着scrollview滑动
  final double footerWidth;
  final double height;
  final double width;
  final VoidCallback onFooterLoadingCallBack;

  @override
  State<StatefulWidget> createState() => _HorizontalScrollViewState();
}

class _HorizontalScrollViewState extends State<HorizontalScrollView> {
  ScrollController _scrollController;
  double _fotterViewRight = 0;

  @override
  void initState() {
    super.initState();
    _fotterViewRight = -widget.footerWidth;
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollUpdate);
  }

  double _showFooterWidth() {
    switch (widget.footerShowStyle) {
      case FooterViewShowStyle.dismiss:
        return 0;
      case FooterViewShowStyle.showHalf:
        return widget.footerWidth / 2;
      case FooterViewShowStyle.showWhole:
        return widget.footerWidth;
    }
    return 0;
  }

  void _scrollUpdate() {
    if (widget.footerView == null) return;
    //超出scrollview最大宽度的部分
    var outRangeOffset = _scrollController.position.pixels -
        _scrollController.position.maxScrollExtent +
        _showFooterWidth();
    var _fresh = false; //是否刷新

    //如果footerLeft大于0，说明footview需要跟着scroll滑动了
    if (outRangeOffset >= 0) {
      var footerViewRight = min(0, outRangeOffset - widget.footerWidth);
      if (widget.footViewFlowScrollAlways == true) {
        footerViewRight = outRangeOffset - widget.footerWidth;
      }
      footerViewRight = footerViewRight.toDouble();
      if (_fotterViewRight != footerViewRight) {
        _fotterViewRight = footerViewRight;
        _fresh = true;
      }
    } else if (_fotterViewRight != -widget.footerWidth) {
      _fotterViewRight = -widget.footerWidth;
      _fresh = true;
    }
    if (widget.footerView is FootBaseView) {
      var footerView = widget.footerView as FootBaseView;
      footerView.onScrollUpdate(_scrollController, outRangeOffset);
    }
    if (_fresh) {
      setState(() {});
    }
  }

  void _onPointerUp(){
    var outRangeOffset = _scrollController.position.pixels -
        _scrollController.position.maxScrollExtent +
        _showFooterWidth();
    if(widget.onFooterLoadingCallBack != null){
      if(outRangeOffset > _showFooterWidth() + widget.footerWidth/2){
        widget.onFooterLoadingCallBack();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height ?? 0,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: widget.itemMargin.bottom,
            right: _fotterViewRight,
            top: widget.itemMargin.top,
            child: widget.footerView ?? Text(''),
          ),
          Listener(
            onPointerCancel: (event){_onPointerUp();},
            onPointerUp: (event){_onPointerUp();},
            child: CustomScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                    List.generate(widget.itemCount, (index) {
                  return Container(
                    margin: widget.itemMargin,
                    child: widget.itembuilder(context, index) ?? Text(''),
                  );
                })),
              ),
              SliverToBoxAdapter(
                child: Container(
                  width: _showFooterWidth(), //假的footerview
                ),
              )
            ],
          ),
          )
        ],
      ),
    );
  }
}
