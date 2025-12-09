import 'package:flutter/material.dart';

class FullImage extends StatelessWidget {
  final String url;

  const FullImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: url,
          child: InteractiveViewer(
            child: Image.network(url),
          ),
        ),
      ),
    );
  }
}
