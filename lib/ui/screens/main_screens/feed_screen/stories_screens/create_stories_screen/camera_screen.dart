import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spott/resources/app_data.dart';
import 'package:spott/translations/codegen_loader.g.dart';
import 'package:spott/ui/screens/main_screens/feed_screen/stories_screens/create_stories_screen/create_stories_screen.dart';
import 'package:spott/utils/show_snack_bar.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class __VideoRecordingButtonState extends State<_VideoRecordingButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(
            backgroundColor: Colors.red,
            strokeWidth: 5,
            value: animation.value,
          ),
        ),
        const Center(
          child: _CircularContainer(
            isRecording: true,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller =
        AnimationController(duration: widget._videoDuration, vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
        if (animation.isCompleted) {
          widget._onCompleted();
        }
      });
    controller.forward();
    super.initState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isFrontCamera = true;
  double transform = 0;
  final Duration _storyMaxDuration = const Duration(seconds: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
                future: cameraValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      _cameraController != null) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: CameraPreview(_cameraController!));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                IconButton(
                    icon: Icon(
                      flash ? Icons.flash_on : Icons.flash_off,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: _onFlashlightButtonPressed),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
            Positioned(
              bottom: 0.0,
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: _startVideoRecording,
                    onLongPressUp: _stopVideoRecording,
                    onTap: () {
                      if (!isRecording) takePhoto(context);
                    },
                    child: isRecording
                        ? _VideoRecordingButton(
                            _stopVideoRecording, _storyMaxDuration)
                        : const _CircularContainer(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.black,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Transform.rotate(
                          angle: transform,
                          child: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            isFrontCamera = !isFrontCamera;
                            transform = transform + pi;
                          });
                          final int cameraPos = isFrontCamera ? 0 : 1;
                          if (AppData.cameras?.elementAt(cameraPos) != null) {
                            _cameraController = CameraController(
                                AppData.cameras!.elementAt(cameraPos),
                                ResolutionPreset.high);
                            cameraValue = _cameraController?.initialize();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController?.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (AppData.cameras != null && AppData.cameras!.isNotEmpty) {
      _cameraController =
          CameraController(AppData.cameras![0], ResolutionPreset.high);
      cameraValue = _cameraController?.initialize();
    } else {
      showSnackBar(
          context: context, message: LocaleKeys.cameraNotFoundError.tr());
    }
  }

  Future<void> takePhoto(BuildContext context) async {
    final XFile? _imageFile = await _cameraController?.takePicture();
    if (_imageFile != null) {
      final Uint8List _image = await _imageFile.readAsBytes();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CreateStoriesScreen(
            image: _image,
          ),
        ),
      );
    }
  }

  void _onFlashlightButtonPressed() {
    setState(() {
      flash = !flash;
    });
    flash
        ? _cameraController?.setFlashMode(FlashMode.torch)
        : _cameraController?.setFlashMode(FlashMode.off);
  }

  Future<void> _startVideoRecording() async {
    await _cameraController?.startVideoRecording();
    setState(() {
      isRecording = true;
    });
  }

  Future<void> _stopVideoRecording() async {
    final XFile _videoFile = await _cameraController!.stopVideoRecording();

    print ( "\n\n\n\nn\n\n\n\n");
    print ( await _videoFile.length());
    print ( "\n\n\n\nn\n\n\n\n");
    setState(() {
      isRecording = false;
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => CreateStoriesScreen(videoPath: _videoFile.path),
      ),
    );
  }
}

class _CircularContainer extends StatelessWidget {
  final bool isRecording;
  const _CircularContainer({Key? key, this.isRecording = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isRecording ? 60 : 75,
      width: isRecording ? 60 : 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(75),
        border: Border.all(
            color: isRecording ? Colors.transparent : Colors.white, width: 4),
      ),
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75),
          color: isRecording ? Colors.red : Colors.white,
        ),
      ),
    );
  }
}

class _VideoRecordingButton extends StatefulWidget {
  final Function _onCompleted;
  final Duration _videoDuration;
  const _VideoRecordingButton(this._onCompleted, this._videoDuration,
      {Key? key})
      : super(key: key);

  @override
  __VideoRecordingButtonState createState() => __VideoRecordingButtonState();
}
