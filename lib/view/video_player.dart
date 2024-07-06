import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  final bool isActive; // Flag to indicate if the video should play

  VideoPlayerWidget({required this.videoPath, this.isActive = false});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          // Automatically play if the video is active
          if (widget.isActive) {
            _controller.play();
          } else {
            // Seek to frame 50 assuming 30 fps
            _controller.seekTo(Duration(seconds: (50 / 30).floor()));
          }
        });
      }).catchError((error) {
        print("Error initializing video: $error");
      });
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller.play();
      } else {
        _controller.pause();
        _controller.seekTo(Duration(seconds: (50 / 30).floor()));
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: _isInitialized
          ? VideoPlayer(_controller)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
