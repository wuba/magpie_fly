import 'dart:async';
import 'package:flutter/material.dart';

const int IntegerMax = 0x7fffffff;

typedef BuildShowView = Widget Function(int index, dynamic itemData);
typedef OnBannerClickListener = void Function(int index, dynamic itemData);

class BannerWidget extends StatefulWidget {
  final List data;
  final BuildShowView buildShowView;
  final OnBannerClickListener onBannerClickListener;
  final int delayTime;
  final int scrollTime;
  final double height;
  final double width;
  final Color indicatorSelectColor;
  final Color indicatorColor;
  final double indicatorRadius;
  final double indicatorRight;
  final double indicatorBottom;

  BannerWidget(
      {Key key,
      @required this.data,
      @required this.buildShowView,
      this.delayTime = 3, //延迟轮播时间
      this.scrollTime = 200, //单次轮播时间
      this.onBannerClickListener, //点击回调
      this.height = 200, //轮播高度
      this.width = 200, //轮播高度
      this.indicatorSelectColor = Colors.white, //指示器选中颜色
      this.indicatorColor = Colors.grey, //指示器默认颜色
      this.indicatorRadius = 5, //指示器大小
      this.indicatorRight = 30, //指示器位置距右侧
      this.indicatorBottom = 10 //指示器位置距底部
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BannerState();
  }
}

class BannerState extends State<BannerWidget> {
  final PageController pageController =
      PageController(initialPage: IntegerMax ~/ 2);

  Timer timer;
  int _curIndex = 0;

  @override
  void initState() {
    super.initState();
    resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedWidget(
        position: getPosition(),
        child: Stack(
          children: <Widget>[
            initPageView(),
            IndicatorView(
              length: widget.data.length,
              indicatorSelectColor: widget.indicatorSelectColor,
              indicatorColor: widget.indicatorColor,
              indicatorRadius: widget.indicatorRadius,
              indicatorRight: widget.indicatorRight,
              indicatorBottom: widget.indicatorBottom,
            ),
          ],
        ));
  }

  int getPosition() {
    return _curIndex % widget.data.length;
  }

  int indexToPosition(int index) {
    return index % widget.data.length;
  }

  void clearTimer() {
    timer.cancel();
    timer = null;
  }

  void resetTimer() {
    timer = Timer.periodic(Duration(seconds: widget.delayTime), (Timer timer) {
//      var i = getPosition() + 1;
      //print("88888:" + getPosition().toString());
      pageController.animateToPage(pageController.page.toInt() + 1,
          duration: Duration(milliseconds: widget.scrollTime),
          curve: Curves.linear);
    });
  }

  Widget initPageView() {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: widget.data.length == 0
          ? null
          : GestureDetector(
              onTap: () {
                widget.onBannerClickListener(
                    getPosition(), widget.data[getPosition()]);
              },
              child: PageView.builder(
                  controller: pageController,
                  physics:
                      const PageScrollPhysics(parent: ClampingScrollPhysics()),
                  onPageChanged: (index) {
                    //监听变换 主要为了同步指示器
                    setState(() {
                      _curIndex = index;
                    });
                  },
                  itemCount: IntegerMax,
                  itemBuilder: (BuildContext context, int index) {
                    return widget.buildShowView(
                        index, widget.data[indexToPosition(index)]);
                  }),
            ),
    );
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }
}

class _InheritedWidget extends InheritedWidget {
  _InheritedWidget({
    Key key,
    @required Widget child,
    @required this.position,
  }) : super(key: key, child: child);

  final int position;

  static _InheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_InheritedWidget);
  }

  @override
  bool updateShouldNotify(_InheritedWidget oldWidget) {
    return position != oldWidget.position;
  }
}

//指示器view
class IndicatorView extends StatefulWidget {
  final Color indicatorSelectColor;
  final Color indicatorColor;
  final double indicatorRadius;
  final double indicatorRight;
  final double indicatorBottom;
  final int length;

  //final int position;

  const IndicatorView({
    Key key,
    this.indicatorSelectColor = Colors.white,
    this.indicatorColor = Colors.grey,
    this.indicatorRadius = 5,
    this.indicatorRight = 30,
    this.indicatorBottom = 10,
    this.length = 0,
    //this.position = 0
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return IndicatorState();
  }
}

class IndicatorState extends State<IndicatorView> {
  @override
  Widget build(BuildContext context) {
    return initIndicator(context);
  }

  Widget initIndicator(BuildContext context) {
    double dindicatorRight;
    if (widget.indicatorRight != 0) {
      dindicatorRight = widget.indicatorRight;
    }

    return Positioned(
      right: dindicatorRight,
      bottom: widget.indicatorBottom,
      child: Row(
        children: initIndicatorItem(context),
      ),
    );
  }

  List<Widget> initIndicatorItem(BuildContext context) {
    var items = <Widget>[];
    for (var i = 0; i < widget.length; i++) {
      items.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: ClipOval(
          child: Container(
            width: widget.indicatorRadius,
            height: widget.indicatorRadius,
            color: i == _InheritedWidget.of(context).position
                ? widget.indicatorSelectColor
                : widget.indicatorColor,
          ),
        ),
      ));
    }
    return items;
  }
}
