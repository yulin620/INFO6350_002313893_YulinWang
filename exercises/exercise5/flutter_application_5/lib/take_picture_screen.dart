import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'display_picture_screen.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({super.key, required this.camera});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),

      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            // 保存照片到临时目录
            final imagePath = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            final picture = await _controller.takePicture();

            await picture.saveTo(imagePath);

            if (!mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DisplayPictureScreen(imagePath: imagePath),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
