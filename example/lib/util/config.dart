
import '../demo/banner_widget/banner_widget_demo.dart';
import '../demo/draggable_btn/drag_btn_demo.dart';
import '../demo/search_input/search_input_demo.dart';
import '../demo/video/video_feed_demo.dart';
import '../demo/pinned_sliver/pinned_sliver_demo.dart';
import '../demo/popup_window/popup_window_demo.dart';
import 'package:flutter/material.dart';
import '../demo/horizonal_scroll/HorizontalScrollCustom.dart';
import '../demo/horizonal_scroll/HorizontalScrollDefault.dart';
import '../demo/horizonal_scroll/HorizontalScrollText.dart';

//rm中对应的demo
typedef fuc = Widget Function();
Map<String, fuc> markdownPathToWidget = {
  'lib/demo/horizonal_scroll/HorizontalScrollDefault.dart': () => HorizontalScrollDefault(),
  'lib/demo/horizonal_scroll/HorizontalScrollCustom.dart': () => HorizontalScrollCustom(),
  'lib/demo/horizonal_scroll/HorizontalScrollText.dart': () => HorizontalScrollText(),
  'lib/demo/pinned_sliver/pinned_sliver_demo.dart': () => PinnedSliverDemo(),
  'lib/demo/popup_window/popup_window_demo.dart': () => PopupWindowTest(),
  'lib/demo/search_input/search_input_demo.dart': () => SearchInputDemo(),
  'lib/demo/video/video_feed_demo.dart': () => VideoFeedDemo(),
  'lib/demo/draggable_btn/drag_btn_demo.dart': () => DragBtnDemo(),
  'lib/demo/banner_widget/banner_widget_demo.dart': () => BannerWidgetDemo(),
};











