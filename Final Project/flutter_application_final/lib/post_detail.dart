import 'package:flutter/material.dart';

import 'full_image.dart';

class PostDetail extends StatelessWidget {
  final String postId;
  final Map<String, dynamic> data;

  const PostDetail({
    super.key,
    required this.postId,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final title = (data['title'] ?? '').toString();
    final price = (data['price'] ?? '').toString();
    final desc = (data['desc'] ?? '').toString();
    final images =
        (data['images'] as List?)?.cast<String>() ?? const <String>[];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '\$ $price',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(desc),
            const SizedBox(height: 24),
            if (images.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: images.map((url) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FullImage(url: url),
                        ),
                      );
                    },
                    child: Hero(
                      tag: url,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          url,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              const Text('No images'),
          ],
        ),
      ),
    );
  }
}
