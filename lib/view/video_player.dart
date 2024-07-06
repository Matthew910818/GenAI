import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String? _playerInfoText;
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
      });

      _sendFrameAndPosition(frameNumber, position);
    }
  }

  Future<void> _sendFrameAndPosition(int frameNumber, Offset position) async {
    final url = Uri.parse('https://us-central1-hackathon-428516.cloudfunctions.net/get_player');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'frame_num': frameNumber,
        'point': [position.dx, position.dy],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _playerInfoText = 'Player Info: ${data.toString()}';
      });
    } else {
      setState(() {
        _playerInfoText = 'Player not found';
      });
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
            if (_tapPosition != null && _playerInfoText != null)
              Positioned(
                left: _tapPosition!.dx - 50,
                top: _tapPosition!.dy - 25, // Adjusted to center the box vertically
                child: Container(
                  width: 200,
                  height: 50,
                  color: Colors.black54,
                  child: Center(
                    child: Text(
                      _playerInfoText!,
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
