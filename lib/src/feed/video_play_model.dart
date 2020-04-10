import 'package:flutter/cupertino.dart';

class VideoPlayModel extends ChangeNotifier {
  dynamic videoData;
  int playIndex;

  void updateVideo(int index, dynamic data) {
    playIndex = index;
    videoData = data;
    notifyListeners();
  }
}
