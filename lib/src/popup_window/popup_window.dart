import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PopupWindow extends StatefulWidget {
  static void showPopWindow(context, GlobalKey popKey,
      [PopDirection popDirection = PopDirection.bottom,
      Widget popWidget,
      double offset = 0]) {
    Navigator.push(
        context,
        PopRoute(
            child: PopupWindow(
          popKey: popKey,
          popDirection: popDirection,
          popWidget: popWidget,
          offset: offset,
        )));
  }

  Widget window;
  GlobalKey popKey;
  PopDirection popDirection;
  Widget popWidget; //自定义widget
  double offset; //popupWindow偏移量

  PopupWindow(
      {this.popWidget,
      this.popKey,
      this.popDirection = PopDirection.bottom,
      this.offset});

  @override
  State<StatefulWidget> createState() {
    return _PopupWindowState();
  }
}

class _PopupWindowState extends State<PopupWindow> {
  GlobalKey buttonKey;
  double left = -100;
  double top = -100;

  @override
  void initState() {
    super.initState();
    buttonKey = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = widget.popKey.currentContext.findRenderObject();
      Offset localToGlobal =
          renderBox.localToGlobal(Offset.zero); //targetWidget的坐标位置
      Size size = renderBox.size; //targetWidget的size

      RenderBox buttonBox = buttonKey.currentContext.findRenderObject();
      var buttonSize = buttonBox.size; //button的size
      switch (widget.popDirection) {
        case PopDirection.left:
          left = localToGlobal.dx - buttonSize.width - widget.offset;
          top = localToGlobal.dy + size.height / 2 - buttonSize.height / 2;
          break;
        case PopDirection.top:
          left = localToGlobal.dx + size.width / 2 - buttonSize.width / 2;
          top = localToGlobal.dy - buttonSize.height - widget.offset;
          fixPosition(buttonSize);
          break;
        case PopDirection.right:
          left = localToGlobal.dx + size.width + widget.offset;
          top = localToGlobal.dy + size.height / 2 - buttonSize.height / 2;
          break;
        case PopDirection.bottom:
          left = localToGlobal.dx + size.width / 2 - buttonSize.width / 2;
          top = localToGlobal.dy + size.height + widget.offset;
          fixPosition(buttonSize);
          break;
      }
      setState(() {});
    });
  }

  void fixPosition(Size buttonSize) {
    if (left < 0) {
      left = 0;
    }
    if (left + buttonSize.width >= MediaQuery.of(context).size.width) {
      left = MediaQuery.of(context).size.width - buttonSize.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            Positioned(
              child: GestureDetector(
                child: _buildCustomWidget(widget.popWidget),
              ),
              left: left,
              top: top,
            )
          ],
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildCustomWidget(Widget child) => Container(
        key: buttonKey,
        child: child,
      );
}

class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 200);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      )),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => _duration;
}

enum PopDirection { left, top, right, bottom }
