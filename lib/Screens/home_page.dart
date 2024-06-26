import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:mawjood_app/Screens/CheckIn.dart';
import 'package:mawjood_app/Screens/WrongLocation.dart';
import 'package:mawjood_app/screens/Unrecognized.dart';
import 'package:mawjood_app/screens/RegisterPage.dart';
import 'package:mawjood_app/Screens/login.dart';
import 'package:mawjood_app/widgets/CameraPreviewWidget.dart';
import 'package:mawjood_app/widgets/checkLocation.dart';
import 'package:mawjood_app/widgets/imageWidget.dart';
import 'package:mawjood_app/widgets/iconButton.dart';
import 'package:mawjood_app/widgets/btnTypes.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final bool hasAccount; // Flag to check if the user has an account

  const HomePage({super.key, required this.hasAccount});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? location;

  Future<String?> faceRecognition(String imagePath) async {
    try {
      final api = Uri.parse('http://mawjoodapi.pythonanywhere.com/recognize');
      var request = http.MultipartRequest('POST', api);
      request.files.add(await http.MultipartFile.fromPath('image', imagePath));
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseData);
        if (jsonResponse['recognized_faces'].isNotEmpty) {
          var firstFace = jsonResponse['recognized_faces'][0];
          if (firstFace.containsKey('accuracy')) {
            return firstFace['doc_ID'];
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        return "No face recognized";
      }
    } catch (e) {
      return e.toString();
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    location = await CheckLocation().checkLocation();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<CameraPreviewWidgetState> _cameraPreviewKey = GlobalKey();
    return Scaffold(
      backgroundColor: const Color.fromARGB(148, 92, 94, 233),
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -160,
            child: Container(
              width: 470,
              height: 470,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(96, 27, 25, 68),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 30),
              const ImageWidget(
                avatarURL:
                    'https://i.ibb.co/0sM3NKG/logo-2-removebg-preview.png',
                width: 70,
                height: 70,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()),
                        );
                      },
                      icon: Icons.login,
                      text: 'Register',
                      type: btnType.Secondary,
                    ),
                    CustomIconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      icon: Icons.settings,
                      text: 'Manage Account',
                      type: btnType.Secondary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50.0),
                          child: CustomIconButton(
                            onPressed: () async {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Please wait"),
                                duration: Duration(seconds: 1),
                              ));
                              // Take a picture
                              final image = await _cameraPreviewKey
                                  .currentState!
                                  .takePicture();
                              final inputImage =
                                  InputImage.fromFilePath(image!.path);
                              // Deteced faces
                              final faces = await FaceDetector(
                                      options: FaceDetectorOptions())
                                  .processImage(inputImage);
                              // If there is faces then behave normally
                              if (location == true) {
                                if (faces.isNotEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Face detected"),
                                    duration: Duration(seconds: 1),
                                  ));
                                  // Face recognition
                                  final recognizedId =
                                      await faceRecognition(image!.path);
                                  if (recognizedId != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CheckIn(
                                                id: recognizedId,
                                              )),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Unrecognized()),
                                    );
                                  }
                                } else {
                                  // If there is no faces show a snackbar
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("No face detected"),
                                    duration: Duration(seconds: 2),
                                  ));
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WrongLocation()),
                                );
                              }
                            },
                            text: 'Check-in',
                            icon: Icons.check,
                            type: btnType.Primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 230,
            left: 0,
            right: 0,
            bottom: 0,
            child: CameraPreviewWidget(
              key: _cameraPreviewKey,
            ), // Add the CameraPreviewWidget here
          ),
        ],
      ),
    );
  }
}
