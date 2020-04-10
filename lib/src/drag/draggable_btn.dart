import 'package:flutter/material.dart';

class DraggableBtn extends StatefulWidget {
  final Widget child;
  final Offset initOffset;
  final Offset fullScreenOffset;

  const DraggableBtn(
      {Key key,
      @required this.child,
      this.initOffset,
      this.fullScreenOffset = Offset.zero})
      : super(key: key);

  @override
  _DraggableBtnState createState() => _DraggableBtnState();
}

class _DraggableBtnState extends State<DraggableBtn>
    with SingleTickerProviderStateMixin {
  var _animController;
  var _scaleAnim;
  var _left = 50.0;
  var _top = 50.0;
  var globalKey = GlobalKey();
  var childWidth;
  var childHeight;

  @override
  void initState() {
    _left = widget.initOffset.dx;
    _top = widget.initOffset.dy;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox renderBox = globalKey.currentContext.findRenderObject();
      childWidth = renderBox.size.width;
      childHeight = renderBox.size.height;
    });
    _animController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.5).animate(_animController);
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: _left,
          top: _top,
          child: Draggable(
            childWhenDragging: Container(),
            feedback: ScaleTransition(scale: _scaleAnim, child: widget.child),
            child: Container(
              key: globalKey,
              child: widget.child,
            ),
            onDragStarted: () {
              _animController.forward();
            },
            onDragCompleted: () {},
            onDraggableCanceled: (v, offset) {
              debugPrint("offset y ${offset.dy}");
              var size = MediaQuery.of(context).size;
              setState(() {
                _left = offset.dx - widget.fullScreenOffset.dx;
                _top = offset.dy - widget.fullScreenOffset.dy;
                if (_left < 0) _left = 0;
                if (_left > size.width - childWidth) {
                  _left = size.width - childWidth;
                }
                if (_top < 0) _top = 0;
                if (_top > size.height - childHeight) {
                  _top = size.height - childHeight;
                }
              });
            },
          ),
        )
      ],
    );
  }
}
