import 'package:flutter/material.dart';
import 'browse_posts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("🔥 MAIN STARTED");
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("🔥 FIREBASE INIT DONE");
  } catch (e) {
    print("🔥 FIREBASE INIT ERROR: $e");
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HyperGarageSale",
      home: BrowsePosts(),
    ),
  );
}
