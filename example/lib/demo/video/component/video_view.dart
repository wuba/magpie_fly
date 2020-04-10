import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  final url;
  final play;

  VideoView(this.url, this.play);

  @override
  State<StatefulWidget> createState() {
    return _VideoState();
  }
}

class _VideoState extends State<VideoView> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (_controller != null) {
      _controller.dispose();
    }
    _controller = VideoPlayerController.network(widget.url)
      ..setVolume(0)
      ..setLooping(true)
      ..initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    widget.play ? _play() : _pause();
    var initialized = _controller.value.initialized;
    var ratio = initialized ? _controller.value.aspectRatio : 16 / 9;

    var children = <Widget>[
      AspectRatio(aspectRatio: ratio, child: VideoPlayer(_controller)),
    ];
    if (!widget.play) {
      children.add(AspectRatio(
        aspectRatio: ratio,
        child: Container(
          color: initialized ? Colors.transparent : Colors.grey[400],
          child: Icon(
            Icons.play_circle_outline,
            color: Colors.white,
            size: 60,
          ),
        ),
      ));
    } else if (!initialized) {
      children.add(AspectRatio(
        aspectRatio: ratio,
        child: Center(child: const CircularProgressIndicator()),
      ));
    } else {
      children.add(Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 8,
          child: VideoProgressIndicator(
            _controller,
            allowScrubbing: true,
            colors: VideoProgressColors(
              playedColor: Colors.green[600],
              bufferedColor: Colors.green[100],
              backgroundColor: Colors.grey,
            ),
          ),
        ),
      ));
    }
    return Stack(
      children: children,
      alignment: Alignment.bottomCenter,
    );
  }

  void _play() {
    if (!_controller.value.initialized) {
      return;
    }
    if (!_controller.value.isPlaying) {
      _controller.play();
    }
  }

  void _pause() {
    if (!_controller.value.initialized) {
      return;
    }
    if (_controller.value.isPlaying) {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    debugPrint('dispose ${widget.url}');
  }
}
