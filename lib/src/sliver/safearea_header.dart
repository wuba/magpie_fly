import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _SafeAreaHeader extends StatelessWidget {
  final Widget child;
  final double placeHolderSize;
  final double height;

  const _SafeAreaHeader({
    Key key,
    @required this.child,
    @required this.height,
    this.placeHolderSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top + placeHolderSize ?? 0;
    return Container(
        height: height - top,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: <Widget>[Positioned(top: -top, child: child)],
        ));
  }
}

class _SafeAreaPinnedPlaceholder extends StatelessWidget {
  final double placeHolderSize;
  final Color color;

  _SafeAreaPinnedPlaceholder(this.placeHolderSize, {this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _Delegate(
        color,
        height: MediaQuery.of(context).padding.top,
        placeHolderSize: placeHolderSize,
      ),
    );
  }
}

class _Delegate extends SliverPersistentHeaderDelegate {
  _Delegate(this.color, {@required this.height, this.placeHolderSize = 0});

  final double height;
  final double placeHolderSize;
  final Color color;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height + placeHolderSize;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var alpha = (shrinkOffset / maxExtent * 255).clamp(0, 255).toInt();
    return Column(
      children: <Widget>[
        Container(color: color.withAlpha(alpha), height: height),
        Expanded(
          child: Container(height: placeHolderSize, color: Colors.transparent),
        )
      ],
    );
  }

  @override
  bool shouldRebuild(_Delegate oldDelegate) {
    return false;
  }
}

NestedScrollViewHeaderSliversBuilder pinnedBuilder(
    {double placeHolderSize = 0,
    Color color = Colors.white,
    double height,
    WidgetBuilder headerBuilder,
    NestedScrollViewHeaderSliversBuilder builder}) {
  assert(height > 0);
  return (BuildContext context, bool innerBoxIsScrolled) {
    var header = [
      _SafeAreaPinnedPlaceholder(placeHolderSize, color: color),
      SliverToBoxAdapter(
        child: _SafeAreaHeader(
          height: height,
          placeHolderSize: placeHolderSize,
          child: SizedBox(
            height: height,
            child: headerBuilder(context),
          ),
        ),
      ),
    ];
    return builder(context, innerBoxIsScrolled)..insertAll(0, header);
  };
}
