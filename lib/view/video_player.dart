import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  VideoPlayerWidget({required this.videoPath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  Offset? _tapPosition;
  String? _frameNumberText;
  double frameRate = 30.0; // Assuming the video frame rate is 30 FPS
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _controller.play(); // Automatically play the video when initialized
        });
      }).catchError((error) {
        print("Error initializing video: $error");
      });

    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        setState(() {
          _controller.seekTo(Duration.zero);
          _controller.pause();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (_isInitialized) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.globalToLocal(details.globalPosition);
      final videoPosition = _controller.value.position;

      // Calculate the frame number
      final frameNumber = (videoPosition.inMilliseconds / (1000 / frameRate)).round();

      setState(() {
        _tapPosition = position;
        _frameNumberText = 'Frame: $frameNumber';
      });

      print('Tapped position: $position');
      print('Frame number: $frameNumber');
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _seekToPosition(Duration position) {
    _controller.seekTo(position);
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GestureDetector(
        onTapDown: _onTapDown,
        child: Stack(
          children: [
            _isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            if (_tapPosition != null && _frameNumberText != null)
              Positioned(
                left: _tapPosition!.dx - 50,
                top: _tapPosition!.dy - 25, // Adjusted to center the box vertically
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.black54,
                  child: Center(
                    child: Text(
                      _frameNumberText!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            if (_isInitialized)
              Positioned(
                bottom: 50,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: _controller.value.position.inSeconds.toDouble(),
                        min: 0.0,
                        max: _controller.value.duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _controller.seekTo(Duration(seconds: value.toInt()));
                          });
                        },
                      ),
                    ),
                    Text(
                      "${_controller.value.position.inMinutes}:${(_controller.value.position.inSeconds % 60).toString().padLeft(2, '0')} / ${_controller.value.duration.inMinutes}:${(_controller.value.duration.inSeconds % 60).toString().padLeft(2, '0')}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            _isInitialized
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                            ),
                            onPressed: _togglePlayPause,
                          ),
                          IconButton(
                            icon: Icon(Icons.replay_10, color: Colors.white),
                            onPressed: () => _seekToPosition(_controller.value.position - Duration(seconds: 10)),
                          ),
                          IconButton(
                            icon: Icon(Icons.forward_10, color: Colors.white),
                            onPressed: () => _seekToPosition(_controller.value.position + Duration(seconds: 10)),
                          ),
                          IconButton(
                            icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up, color: Colors.white),
                            onPressed: _toggleMute,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
