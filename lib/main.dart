import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tensorflow_audio/features/image_camera/presentation/pages/splash_screen.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InputScreen(
        // cameras,
        ),
  ));
}
