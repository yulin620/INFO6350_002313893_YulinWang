import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/firebase_service.dart';
import 'question_widget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final FirebaseService _service = FirebaseService();
  List<Map<String, dynamic>> _questions = [];
  int _index = 0;
  int _score = 0;
  int _timer = 60;
  Timer? _t;

  List<dynamic> _selected = [];

  @override
  void initState() {
    super.initState();
    _load();
    _startTimer();
  }

  void _startTimer() {
    _t = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timer--;
      });

      if (_timer == 0) {
        _finishQuiz(timeout: true);
      }
    });
  }

  Future<void> _load() async {
    final data = await _service.getQuestions();
    data.shuffle(Random()); // random order

    setState(() {
      _questions = data.take(10).toList();
    });
  }

  void _next() {
    final q = _questions[_index];

    // scoring logic
    if (q["type"] == "single") {
      if (_selected.contains(q["answer"])) _score++;
    } else if (q["type"] == "tf") {
      if (_selected.contains(q["answer"])) _score++;
    } else if (q["type"] == "multi") {
      if (Set.from(_selected).containsAll(q["answers"])) _score++;
    }

    _selected = [];

    if (_index < _questions.length - 1) {
      setState(() {
        _index++;
      });
    } else {
      _finishQuiz();
    }
  }

  void _finishQuiz({bool timeout = false}) async {
    _t?.cancel();

    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _service.saveResult(uid, timeout ? 0 : _score);

    Navigator.pushReplacementNamed(context, "/result",
        arguments: timeout ? 0 : _score);
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final q = _questions[_index];

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz   ⏱ $_timer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(q["question"], style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            QuestionWidget(
              question: q,
              selected: _selected,
              onSelect: (v) {
                setState(() {
                  _selected = v;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _selected.isEmpty ? null : _next,
              child: const Text("Next"),
            )
          ],
        ),
      ),
    );
  }
}
