import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final fs = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise 8 Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              fs.addMessage("Hello Firebase!");
            },
            child: const Text("Add Firestore Message"),
          ),
          Expanded(
            child: StreamBuilder(
              stream: fs.getMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final docs = snapshot.data!.docs;

                return ListView(
                  children: docs
                      .map((d) => ListTile(title: Text(d["text"])))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
