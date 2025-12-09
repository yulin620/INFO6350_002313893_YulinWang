import 'package:flutter/material.dart';
import 'button_calculator.dart';
import 'textfield_calculator.dart';

void main() {
  runApp(const MyCalculatorApp());
}

class MyCalculatorApp extends StatelessWidget {
  const MyCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ButtonCalculatorScreen(),
    );
  }
}
