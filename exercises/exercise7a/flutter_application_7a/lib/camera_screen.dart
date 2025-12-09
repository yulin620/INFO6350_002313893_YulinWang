import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'firebase_storage_service.dart';
import 'face_detector.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  XFile? capturedImage;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller!.initialize();
    setState(() {});
  }

  Future<void> takePicture() async {
    if (!controller!.value.isInitialized) return;

    final image = await controller!.takePicture();
    setState(() {
      capturedImage = image;
    });

    // 上传到 Firebase Storage
    final downloadUrl = await StorageService.uploadFile(File(image.path));

    // 使用 Firebase ML 做人脸检测
    final hasFace = await FaceDetectorService.detectFace(File(image.path));

    // Snackbar 显示结果
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(hasFace ? "Face detected!" : "No face found!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: Text("7A Camera + Storage + ML")),
      body: Column(
        children: [
          Expanded(flex: 3, child: CameraPreview(controller!)),
          Expanded(
            flex: 2,
            child: capturedImage == null
                ? Center(child: Text("No picture taken"))
                : Image.file(File(capturedImage!.path)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: takePicture,
      ),
    );
  }
}
