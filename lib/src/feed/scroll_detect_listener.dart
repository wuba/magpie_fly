import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:magpie_fly/magpie_fly.dart';
import 'package:provider/provider.dart';

import 'video_meta.dart';
import 'video_play_model.dart';

/// Detect scroll event through [NotificationListener]; All the child wrapped
/// with [MetaConsumer] will be return in [VisibleCallback] when they appear on screen.
///
/// {@tool sample}
///
/// This next example shows how to use ScrollDetectListener:
///
/// ```dart
/// ScrollDetectListener(
///  offset: 60 /*Appbar height*/,
///  onVisible: (metas, model) {
///    var videoItem = model.videoData;
///    if (metas != null && metas.length > 0) {
///     var meta = metas[0] as VideoMeta;
///     var targetData = dataList[meta.index];
///     if (videoItem == null ||
///         (videoItem != null && videoItem != targetData)) {
///       model.updateVideo(meta.index, targetData);
///     }
///   } else if (videoItem != null) {
///     model.updateVideo(-1, null);
///   }
/// },
/// child: ListView.separated(
///   padding: EdgeInsets.zero,
///   itemBuilder: (context, index) {
///     return index % 5 == 0
///         ? VideoComponent(index, "video $index")
///         : TextComponent(index);
///   },
///   separatorBuilder: (BuildContext context, int index) => Divider(
///     height: 1,
///   ),
///   itemCount: dataList.length,
///  ),
/// )
/// ```
/// {@end-tool}
class ScrollDetectListener extends StatelessWidget {
  final _ScrollNotification _notification;

  ScrollDetectListener({
    Key key,
    @required Widget child,
    @required VisibleCallback onVisible,
    int extentSize = 10,
    double percentIn = 0.8,
    int offset = 0,
    bool detect = true,
    NotificationListenerCallback onNotification,
  })  : assert(child != null),
        assert(onVisible != null),
        assert(percentIn > 0 && percentIn <= 1, 'percent should be (0,1]'),
        assert(offset > 0, 'offset should >0'),
        _notification = _ScrollNotification(
          config: Config(
            predicate: (_) => _ is VideoMeta,
            callback: onVisible,
            detect: detect,
            percentIn: percentIn,
            offset: offset,
            extentSize: extentSize,
          ),
          child: child,
        );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoPlayModel(),
      child: _notification,
    );
  }
}

typedef Predicate = bool Function(dynamic metaData);
typedef VisibleCallback = void Function(List data, VideoPlayModel model);

/// Supported configuration
class Config {
  final Predicate predicate;
  final VisibleCallback callback;
  final int extentSize;
  final bool detect;
  /// when the view is "visible" on screen
  final double percentIn;
  /// take care of AppBar height if exists
  final int offset;
  /// [onNotification] for [NotificationListener]
  final NotificationListenerCallback onNotification;

  Config({
    this.predicate,
    this.callback,
    this.extentSize,
    this.detect,
    this.percentIn,
    this.offset,
    this.onNotification,
  });
}

class _ScrollNotification extends StatelessWidget {
  final Widget _child;
  final Config _config;

  _ScrollNotification({Config config, Widget child})
      : _config = config,
        _child = child;

  @override
  Widget build(BuildContext context) {
    if (_config.detect) {
      Future.delayed(Duration(milliseconds: 200), () {
        _internalHit(context, _config);
      }).catchError((_) => {});
    }
    return NotificationListener(
      child: _child,
      onNotification: (n) {
        if (!(n is ScrollEndNotification)) {
          return _config.onNotification != null
              ? _config.onNotification(n)
              : false;
        }
        Future.microtask(() {
          return _internalHit(context, _config);
        }).then((_) {
          if (!_) {
            Future.delayed(Duration(milliseconds: 300), () {
              var result = _internalHit(context, _config);
              if (!result) {}
            }).catchError((_) => {});
          }
        }).catchError((_) => {});
        return _config.onNotification != null
            ? _config.onNotification(n)
            : false;
      },
    );
  }

  bool _internalHit(BuildContext context, Config config) {
    var height = MediaQuery.of(context).size.height;
    var x = MediaQuery.of(context).size.width / 2;
    var targets = [];
    for (var y = 0; y < height; y += config.extentSize) {
      var index = _getMeta(context, x, y.toDouble(), config.predicate,
          config.percentIn, config.offset);
      if (index != null && !targets.contains(index)) {
        targets.add(index);
      }
    }
    try {
      var model = Provider.of<VideoPlayModel>(context, listen: false);
      config.callback(targets, model);
    } catch (e) {}
    return targets.length > 0;
  }

  T _getMeta<T>(BuildContext context, double x, double y, Predicate predicate,
      double percentIn, int top) {
    var renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset(x, y));
    var result = HitTestResult();
    WidgetsBinding.instance.hitTest(result, offset);

    dynamic invalidOne;
    for (var i in result.path) {
      if (!(i.target is RenderMetaData)) {
        continue;
      }
      var d = i.target as RenderMetaData;
      if (d.child == invalidOne) {
        continue;
      }
      var data = d.metaData;
      if (!predicate(data)) {
        invalidOne = d.child;
        continue;
      }
      if (d.child == invalidOne) {
        continue;
      }
      var p = d.child.localToGlobal(Offset.zero);
      if (p.dy + (1 - percentIn) * d.child.size.height - top < 0) {
        invalidOne = d.child;
        continue;
      }
      return data as T;
    }
    return null;
  }
}
