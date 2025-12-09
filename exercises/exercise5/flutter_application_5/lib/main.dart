import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'take_picture_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 获取设备摄像头列表
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TakePictureScreen(camera: camera),
    );
  }
}
