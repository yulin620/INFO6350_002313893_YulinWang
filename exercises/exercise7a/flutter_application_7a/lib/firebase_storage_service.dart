import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static Future<String> uploadFile(File file) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref()
        .child("uploads")
        .child("$fileName.jpg");

    await ref.putFile(file);

    return await ref.getDownloadURL();
  }
}
