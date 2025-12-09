import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final score = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(title: const Text("Result")),
      body: Center(
        child: Text(
          "Your score: $score",
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
