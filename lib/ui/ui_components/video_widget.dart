import 'dart:io';
import 'package:flutter/material.dart';
import 'package:spott/ui/ui_components/loading_animation.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String? videoUrl;
  final String? videoPath;

  const VideoWidget({
    Key? key,
    this.videoUrl,
    this.videoPath,
  })  : assert(videoUrl != null || videoPath != null),
        super(key: key);
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoWidget> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl != null) {
      _controller = VideoPlayerController.network(widget.videoUrl!)
        ..initialize().then((_) {
          setState(() {});
        });
    } else if (widget.videoPath != null) {
      _controller = VideoPlayerController.file(File(widget.videoPath!))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller?.value.isInitialized == true
        ? AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(_controller!),
                Center(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _controller?.value.isPlaying == true
                            ? _controller?.pause()
                            : _controller?.play();
                      });
                    },
                    iconSize: 45,
                    icon: Icon(
                      (_controller?.value.isPlaying == true)
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                )
              ],
            ),
          )
        : const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: LoadingAnimation(),
            ),
          );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
