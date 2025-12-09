import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FaceDetectorService {
  static Future<bool> detectFace(File imageFile) async {
    final visionImage = FirebaseVisionImage.fromFile(imageFile);
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
        enableLandmarks: true,
        enableContours: true,
      ),
    );

    final faces = await faceDetector.processImage(visionImage);
    return faces.isNotEmpty;
  }
}
