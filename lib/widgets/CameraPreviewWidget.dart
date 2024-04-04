import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPreviewWidget extends StatefulWidget {
  @override
  _CameraPreviewWidgetState createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Obtain a list of the available cameras
    availableCameras().then((cameras) {
      // Get the first camera from the list
      final firstCamera = cameras.first;
      // Initialize the camera controller
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );
      // Initialize the controller future
      _initializeControllerFuture = _controller.initialize();
      // Update the state once the controller is initialized
      if (mounted) {
        setState(() {});
      }
    });
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
            child: Container(
              height: 250,
              width: 250,
              child: CameraPreview(_controller),
            ),
          );
        } else {
          // Otherwise, display a loading indicator
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
