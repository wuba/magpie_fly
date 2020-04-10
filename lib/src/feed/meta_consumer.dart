import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'video_meta.dart';
import 'video_play_model.dart';

/// Wrap child with [MetaConsumer], so it can be rebuild when video index changed
class MetaConsumer<T> extends StatelessWidget {
  /// view index in the [ListView]
  final int index;

  /// relative data bing to the view item
  final T data;

  /// Widget builder
  final Widget Function(
      BuildContext context, VideoPlayModel model, Widget child) builder;

  MetaConsumer({
    @required this.index,
    @required this.data,
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoPlayModel>(
      builder: (context, model, child) {
        return MetaData(
          metaData: VideoMeta("$data", index),
          child: builder(context, model, child),
        );
      },
    );
  }
}
