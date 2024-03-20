import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraProvider with ChangeNotifier {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  int _selectedCameraIndex = 0;
  bool _isReady = false;
  String? _errorMessage;

  CameraProvider() {
    _initCamera();
  }

  CameraController? get controller => _controller;
  List<CameraDescription>? get cameras => _cameras;
  int get selectedCameraIndex => _selectedCameraIndex;
  bool get isReady => _isReady;
  String? get errorMessage => _errorMessage;

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        await _initController(_cameras![_selectedCameraIndex]);
      } else {
        _errorMessage = 'No cameras available';
        _isReady = false;
        notifyListeners();
      }
    } on CameraException catch (e) {
      _errorMessage = 'Failed to initialize camera: ${e.description}';
      _isReady = false;
      notifyListeners();
    }
  }

  Future<void> _initController(CameraDescription cameraDescription) async {
    _controller?.dispose();
    _controller = CameraController(cameraDescription, ResolutionPreset.high);

    try {
      await _controller!.initialize();
      _isReady = true;
    } catch (e) {
      _errorMessage = 'Error initializing camera: $e';
      _isReady = false;
    } finally {
      notifyListeners();
    }
  }

  void switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) {
      _errorMessage = 'Cannot switch camera. Only one camera available.';
      notifyListeners();
      return;
    }

    int newCameraIndex = (_selectedCameraIndex + 1) % _cameras!.length;
    await _controller?.dispose();

    CameraDescription newCamera = _cameras![newCameraIndex];

    try {
      await _initController(newCamera);
      _selectedCameraIndex = newCameraIndex;
    } on CameraException catch (e) {
      _errorMessage = 'Error switching cameras: $e';
    }

    notifyListeners();
  }

  Future<XFile?> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      _errorMessage = 'Camera is not initialized';
      notifyListeners();
      return null;
    }

    try {
      final XFile file = await _controller!.takePicture();
      return file;
    } catch (e) {
      _errorMessage = 'Error taking picture: $e';
      notifyListeners();
      return null;
    }
  }

  Future<void> reinitializeCamera() async {
    await _initCamera();
  }

  void disposeCameraController() {
    print("DISPOSE CAMERA OK");
    _controller?.dispose();
    _controller = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }
}
