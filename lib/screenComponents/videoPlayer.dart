import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_video_player/cached_video_player.dart';

class VideoPlayerComponent extends StatefulWidget {
  VideoPlayerComponent({Key key}) : super(key: key);

  @override
  _VideoPlayerComponentState createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {
  CachedVideoPlayerController controller;
  @override
  void initState() {
    super.initState();
    controller = CachedVideoPlayerController.network(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    controller.initialize().then((_) {
      setState(() {});
      controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: controller.value != null && controller.value.initialized
          ? AspectRatio(
              child: CachedVideoPlayer(controller),
              aspectRatio: controller.value.aspectRatio,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
