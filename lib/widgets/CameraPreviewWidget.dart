import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewWidget extends StatefulWidget {
  const CameraPreviewWidget({super.key});

  @override
  CameraPreviewWidgetState createState() => CameraPreviewWidgetState();
}

class CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture; // Remove nullable Future

  @override
  void initState() {
    super.initState();
    // Initialize the camera controller and the future
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Obtain a list of the available cameras
    final cameras = await availableCameras();
    // Find the front camera among the available cameras
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
    // Initialize the camera controller
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
    );
    // Initialize the controller future
    _initializeControllerFuture = _controller.initialize();
    // Update the state once the controller is initialized

    if (mounted) {
      setState(() {});
    }
  }

  Future<XFile?> takePicture() async {
    try {
      if (!_controller.value.isInitialized) {
        throw 'Camera is not initialized';
      }
      final XFile picture = await _controller.takePicture();
      return picture;
    } catch (e) {
      print('Error taking picture: $e');
      return null;
    }
  }

  @override
  void dispose() {
    // Dispose of the camera controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If the Future is complete, display the camera preview
          return Center(
            child: SizedBox(
              height: 250,
              width: 250,
              child: CameraPreview(_controller),
            ),
          );
        } else {
          // Otherwise, display a loading indicator
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
