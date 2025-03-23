import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    super.key,
    required this.imagePath,
    this.mediaType = "image",
  });
  final String imagePath;
  final String mediaType;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.imagePath));

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 180,
            child: widget.mediaType == "image" ? previewUI() : previewVideoUI(),
          ),
        ],
      ),
    );
  }

  Widget messageArea() {
    return Positioned(
      bottom: 1,
      right: 1,
      child: Container(
        color: Colors.green,
        width: 180,
        child: Row(
          children: [
            TextFormField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              onTapOutside: (PointerEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Type a message",
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.emoji_emotions),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget previewUI() {
    return Container(
      child: Image.file(File(widget.imagePath), fit: BoxFit.cover),
    );
  }

  Widget previewVideoUI() {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              children: [
                VideoPlayer(_controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black38,
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
