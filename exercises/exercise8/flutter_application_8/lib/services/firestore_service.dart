import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  Future<void> addMessage(String text) async {
    await db.collection("exercise8").add({
      "text": text,
      "time": DateTime.now(),
    });
  }

  Stream<QuerySnapshot> getMessages() {
    return db
        .collection("exercise8")
        .orderBy("time", descending: true)
        .snapshots();
  }
}
