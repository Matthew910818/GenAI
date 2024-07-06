import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:async';

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  VideoPlayerWidget({required this.videoPath});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _areControlsVisible = false; // To control visibility of the player controls
  Offset? _tapPosition;
  String? _playerInfoText;
  double frameRate = 30.0;
  bool _isMuted = false;
  late Map<String, dynamic> _tracks;
  Timer? _timer;
  String? _playerId;
  int _remainingFrames = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
            _controller.play();
          });
        }
      }).catchError((error) {
        print("Error initializing video: $error");
      });

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (_isInitialized) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final position = renderBox.globalToLocal(details.globalPosition);
      final videoPosition = _controller.value.position;
      final frameNumber = (videoPosition.inMilliseconds / (1000 / frameRate)).round();

      setState(() {
        _tapPosition = position;
      });

      _findPlayerInfo(frameNumber, position);
    }
  }

  void _findPlayerInfo(int frameNumber, Offset position) {
    if (frameNumber < 0 || frameNumber >= _tracks['players'].length) {
      setState(() {
        _playerInfoText = 'Player not found';
      });
      return;
    }

    final x = position.dx;
    final y = position.dy;

    for (var playerId in _tracks['players'][frameNumber].keys) {
      final player = _tracks['players'][frameNumber][playerId];
      final bbox = player['bbox'];
      final x1 = bbox[0];
      final y1 = bbox[1];
      final x2 = bbox[2];
      final y2 = bbox[3];

      if (x1 <= x && x <= x2 && y1 <= y && y <= y2) {
        setState(() {
          _playerInfoText = 'Player Info: ${player.toString()}';
          _playerId = playerId;
          _remainingFrames = 20;
        });
        _startTracking();
        return;
      }
    }

    setState(() {
      _playerInfoText = 'Player not found';
      _playerId = null;
    });
  }

  void _startTracking() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: (1000 / frameRate).round()), (timer) {
      if (_controller.value.isPlaying && _playerId != null && _remainingFrames > 0) {
        final videoPosition = _controller.value.position;
        final frameNumber = (videoPosition.inMilliseconds / (1000 / frameRate)).round();
        _updatePlayerPosition(frameNumber);
        _remainingFrames--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void _updatePlayerPosition(int frameNumber) {
    if (frameNumber < 0 || frameNumber >= _tracks['players'].length || _playerId == null) {
      return;
    }

    final player = _tracks['players'][frameNumber][_playerId];
    if (player != null) {
      final bbox = player['bbox'];
      final x1 = bbox[0];
      final y1 = bbox[1];
      final x2 = bbox[2];
      final y2 = bbox[3];
      final centerX = (x1 + x2) / 2;
      final centerY = (y1 + y2) / 2;

      setState(() {
        _tapPosition = Offset(centerX, centerY);
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
    return VisibilityDetector(
      key: Key('video-player-visibility-${widget.videoPath}'),
      onVisibilityChanged: (visibilityInfo) {
        setState(() {
          _areControlsVisible = visibilityInfo.visibleFraction > 0.5;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GestureDetector(
          onTapDown: _onTapDown,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : Center(child: CircularProgressIndicator()),
              if (_tapPosition != null && _playerInfoText != null)
                Positioned(
                  left: _tapPosition!.dx - 100,
                  top: _tapPosition!.dy - 25,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.black54,
                    child: Text(
                      _playerInfoText!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              if (_areControlsVisible) _buildVideoControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoControls() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black54, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Slider(
              value: _controller.value.position.inSeconds.toDouble(),
              min: 0,
              max: _controller.value.duration.inSeconds.toDouble(),
              onChanged: (value) {
                _controller.seekTo(Duration(seconds: value.toInt()));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          ],
        ),
      ),
    );
  }
}
