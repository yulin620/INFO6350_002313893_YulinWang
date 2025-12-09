import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getQuestions() async {
    final snapshot = await _db
        .collection("quizzes")
        .doc("quiz1")
        .collection("questions")
        .get();

    return snapshot.docs.map((e) => e.data()).toList();
  }

  Future<void> saveResult(String uid, int score) async {
    await _db.collection("results").add({
      "uid": uid,
      "score": score,
      "timestamp": DateTime.now(),
    });
  }
}
