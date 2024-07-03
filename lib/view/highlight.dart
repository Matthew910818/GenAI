// highlight.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../model/video.dart';

class HighlightModal extends StatefulWidget {
  final Video highlight;

  HighlightModal({required this.highlight});

  @override
  _HighlightModalState createState() => _HighlightModalState();
}

class _HighlightModalState extends State<HighlightModal> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.highlight.videoPath)
      ..initialize().then((_) {
        setState(() {});
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Column(
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Center(child: CircularProgressIndicator()),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
