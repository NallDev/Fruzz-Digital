import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_story_app/theme/color_schemes.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;
  bool _isReady = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();

    _selectedCameraIndex = 0;

    _initController(_cameras![_selectedCameraIndex]);
  }

  Future<void> _initController(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller!.dispose();
    }

    setState(() => _isReady = false);

    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );

    try {
      await _controller!.initialize();
      setState(() => _isReady = true);
    } on CameraException catch (e) {
      if (e.code == 'CameraAccessDenied') {
        print('User denied camera access.');
      } else {
        print('Handle other errors: $e');
      }
    }
  }

  void _onSwitchCamera() {
    if (_cameras!.length < 2) return;

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;

    _initController(_cameras![_selectedCameraIndex]);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onCapturePressed(context) async {
    try {
      final file = await _controller!.takePicture();

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(imagePath: File(file.path)),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              _controller == null || !_controller!.value.isInitialized
                  ? const Center(child: Text('Loading Camera...'))
                  : CameraPreview(_controller!),

              SafeArea(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, top: 16.0),
                  decoration: BoxDecoration(
                      border:
                      Border.all(color: const Color(borderColor), width: 1),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Color(borderColor),),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border:
                      Border.all(color: const Color(borderColor), width: 1),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: IconButton(
                    icon: const Icon(Icons.image_outlined, color: Color(primaryColor),),
                    onPressed: () async {
                      var file = await _picker.pickImage(source: ImageSource.gallery);

                      if (file == null) return;
                      if (!mounted) return;

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(imagePath: File(file.path)),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      border:
                      Border.all(color: const Color(borderColor), width: 1),
                      borderRadius: BorderRadius.circular(100.0)),
                  child: IconButton(
                    icon: const Icon(Icons.circle, color: Color(primaryColor),),
                    onPressed: () => _onCapturePressed(context),
                  ),
                ),
                if (_cameras != null && _cameras!.length > 1)
                  Container(
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: const Color(borderColor), width: 1),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: IconButton(
                      icon: const Icon(Icons.switch_camera_outlined, color: Color(primaryColor),),
                      onPressed: _onSwitchCamera,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final File imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(imagePath),
    );
  }
}
