import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'new_post.dart';
import 'post_detail.dart';

class BrowsePosts extends StatelessWidget {
  const BrowsePosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HyperGarageSale'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NewPost()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                'No posts yet!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;

              final title = (data['title'] ?? '').toString();
              final price = (data['price'] ?? '').toString();
              final List images =
                  (data['images'] as List?) ?? const [];

              String? thumbUrl;
              if (images.isNotEmpty && images.first is String) {
                thumbUrl = images.first as String;
              }

              return ListTile(
                leading: thumbUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          thumbUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.image_not_supported),
                title: Text(title),
                subtitle: Text('\$ $price'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PostDetail(
                        postId: doc.id,
                        data: data,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),

      // 浮动按钮：在底部中间
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NewPost()),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
