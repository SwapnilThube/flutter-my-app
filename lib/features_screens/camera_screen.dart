import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myapp/features_screens/camera_view.dart' show CameraView;
import 'package:path_provider/path_provider.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraaScreenState();
}

class _CameraaScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? camerValue;
  bool _isRecording = false;
  bool _isFlash = false;
  bool _isCamerafront = true;
  double turns = 0.0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      cameras!.first,
      ResolutionPreset.medium,
    );
    camerValue = _cameraController?.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 150,
            child: FutureBuilder(
              future: camerValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController!);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(bottom: 5),
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isFlash = !_isFlash;
                          });

                          _isFlash
                              ? _cameraController!.setFlashMode(FlashMode.torch)
                              : _cameraController!.setFlashMode(FlashMode.off);
                        },
                        icon: Icon(
                          _isFlash ? Icons.flash_off : Icons.flash_on,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),

                      GestureDetector(
                        onLongPress: () async {
                          setState(() {
                            _isRecording = true;
                          });
                          await _cameraController!.startVideoRecording();
                        },
                        onLongPressUp: () async {
                          XFile videoPath =
                              await _cameraController!.stopVideoRecording();

                          setState(() {
                            _isRecording = false;
                            playVideo(videoPath);
                          });
                        },
                        onTap: () {
                          print("click photo");
                          if (!_isRecording) {
                            takePhoto(context);
                          }
                        },
                        child:
                            _isRecording
                                ? Icon(
                                  Icons.radio_button_on,
                                  size: 70,
                                  color: Colors.red,
                                )
                                : Icon(
                                  Icons.panorama_fish_eye,
                                  size: 70,
                                  color: Colors.white,
                                ),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            _isCamerafront = !_isCamerafront;
                          });
                          _cameraController = CameraController(
                            _isCamerafront ? cameras!.first : cameras!.last,
                            ResolutionPreset.medium,
                          );
                          camerValue = _cameraController?.initialize();
                        },
                        icon: RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.flip_camera_ios,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Hold for video, tap for photo",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    try {
      final image = await _cameraController!.takePicture();
      String path = image.path;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (buillder) => CameraView(imagePath: path, mediaType: "image"),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  void playVideo(XFile videoFile) {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (buillder) =>
                  CameraView(imagePath: videoFile.path, mediaType: "video"),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}

//for android and iOS setting for project URL
//https://docs.flutter.dev/cookbook/plugins/picture-using-camera
