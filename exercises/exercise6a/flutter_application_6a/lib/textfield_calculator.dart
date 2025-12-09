import 'package:flutter/material.dart';

class TextFieldCalculatorScreen extends StatefulWidget {
  const TextFieldCalculatorScreen({super.key});

  @override
  State<TextFieldCalculatorScreen> createState() =>
      _TextFieldCalculatorScreenState();
}

class _TextFieldCalculatorScreenState extends State<TextFieldCalculatorScreen> {
  final TextEditingController num1 = TextEditingController();
  final TextEditingController num2 = TextEditingController();

  String operator = "+";
  String result = "";

  final _formKey = GlobalKey<FormState>();

  void calculate() {
    if (_formKey.currentState!.validate()) {
      double a = double.parse(num1.text);
      double b = double.parse(num2.text);

      double r = 0;
      switch (operator) {
        case "+":
          r = a + b;
          break;
        case "-":
          r = a - b;
          break;
        case "×":
          r = a * b;
          break;
        case "÷":
          r = a / b;
          break;
      }

      setState(() {
        result = "Result: $r";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator - TextFormFields")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: num1,
                decoration: const InputDecoration(
                  labelText: "Number 1",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || double.tryParse(v) == null
                    ? "Enter a valid number"
                    : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: num2,
                decoration: const InputDecoration(
                  labelText: "Number 2",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || double.tryParse(v) == null
                    ? "Enter a valid number"
                    : null,
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: operator,
                items: ["+", "-", "×", "÷"]
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => operator = v!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculate,
                child: const Text("Calculate"),
              ),
              const SizedBox(height: 20),
              Text(result, style: const TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
