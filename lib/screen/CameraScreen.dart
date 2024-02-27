import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();

    // Start with the first camera (usually the back camera).
    _selectedCameraIndex = 0;

    _initController(_cameras![_selectedCameraIndex]);
  }

  Future<void> _initController(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller!.dispose();
    }

    setState(() => _isReady = false); // Set to not ready before initializing the new controller

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
    // Ensure that we do not try to switch cameras if there is only one camera available
    if (_cameras!.length < 2) return;

    // Get the index of the current camera.
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;

    // Initialize the controller with the new camera index.
    _initController(_cameras![_selectedCameraIndex]);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onCapturePressed(context) async {
    try {
      // Attempt to take a picture and log where it's been saved.
      final file = await _controller!.takePicture();

      // If the picture was taken, display it on a new screen.
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
      appBar: AppBar(title: const Text('Camera Example')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _controller == null || !_controller!.value.isInitialized
                ? const Center(child: Text('Loading Camera...'))
                : CameraPreview(_controller!),
          ),
          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () => _onCapturePressed(context),
              ),
              if (_cameras != null && _cameras!.length > 1)
                IconButton(
                  onPressed: _onSwitchCamera,
                  icon: const Icon(Icons.switch_camera),
                ),
            ],
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
