import 'package:flutter/material.dart';
import 'textfield_calculator.dart';

class ButtonCalculatorScreen extends StatefulWidget {
  const ButtonCalculatorScreen({super.key});

  @override
  State<ButtonCalculatorScreen> createState() => _ButtonCalculatorScreenState();
}

class _ButtonCalculatorScreenState extends State<ButtonCalculatorScreen> {
  String display = "0";
  double? firstNum;
  String? operator;

  void onNumberPressed(String value) {
    setState(() {
      if (display == "0") {
        display = value;
      } else {
        display += value;
      }
    });
  }

  void onOperatorPressed(String op) {
    firstNum = double.tryParse(display);
    operator = op;
    setState(() {
      display = "0";
    });
  }

  void onCalculate() {
    double? secondNum = double.tryParse(display);
    if (firstNum == null || secondNum == null || operator == null) return;

    double result = 0;
    switch (operator) {
      case "+":
        result = firstNum! + secondNum;
        break;
      case "-":
        result = firstNum! - secondNum;
        break;
      case "×":
        result = firstNum! * secondNum;
        break;
      case "÷":
        result = firstNum! / secondNum;
        break;
    }

    setState(() {
      display = result.toString();
      operator = null;
      firstNum = null;
    });
  }

  void onClear() {
    setState(() {
      display = "0";
      firstNum = null;
      operator = null;
    });
  }

  Widget buildButton(String text, {Color? color, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(text, style: const TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator - Buttons Only"),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TextFieldCalculatorScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(display, style: const TextStyle(fontSize: 48)),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("7", onTap: () => onNumberPressed("7")),
                  buildButton("8", onTap: () => onNumberPressed("8")),
                  buildButton("9", onTap: () => onNumberPressed("9")),
                  buildButton(
                    "×",
                    color: Colors.grey[300],
                    onTap: () => onOperatorPressed("×"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("4", onTap: () => onNumberPressed("4")),
                  buildButton("5", onTap: () => onNumberPressed("5")),
                  buildButton("6", onTap: () => onNumberPressed("6")),
                  buildButton(
                    "÷",
                    color: Colors.grey[300],
                    onTap: () => onOperatorPressed("÷"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("1", onTap: () => onNumberPressed("1")),
                  buildButton("2", onTap: () => onNumberPressed("2")),
                  buildButton("3", onTap: () => onNumberPressed("3")),
                  buildButton(
                    "+",
                    color: Colors.grey[300],
                    onTap: () => onOperatorPressed("+"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildButton("=", color: Colors.orange, onTap: onCalculate),
                  buildButton("0", onTap: () => onNumberPressed("0")),
                  buildButton("C", color: Colors.grey[300], onTap: onClear),
                  buildButton(
                    "-",
                    color: Colors.grey[300],
                    onTap: () => onOperatorPressed("-"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
