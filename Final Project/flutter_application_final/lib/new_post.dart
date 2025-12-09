import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NewPost extends StatefulWidget {
  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final titleCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final ImagePicker picker = ImagePicker();

  List<XFile> pickedImages = [];

  Future pickImage() async {
    if (pickedImages.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You can upload up to 4 images.")),
      );
      return;
    }

    final img = await picker.pickImage(source: ImageSource.camera);

    if (img != null) {
      setState(() {
        pickedImages.add(img);
      });
    }
  }

  Future<List<String>> uploadImages() async {
    List<String> urls = [];

    for (var img in pickedImages) {
      final file = File(img.path);

      final ref = FirebaseStorage.instance
          .ref()
          .child("postImages/${DateTime.now().millisecondsSinceEpoch}.jpg");

      await ref.putFile(file);
      urls.add(await ref.getDownloadURL());
    }

    return urls;
  }

  Future submitPost() async {
    if (titleCtrl.text.isEmpty || priceCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Title and Price cannot be empty!")),
      );
      return;
    }

    List<String> urls = await uploadImages();

    await FirebaseFirestore.instance.collection("posts").add({
      "title": titleCtrl.text.trim(),
      "price": priceCtrl.text.trim(),
      "desc": descCtrl.text.trim(),
      "images": urls,
      "time": DateTime.now().millisecondsSinceEpoch,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Post")),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(
                labelText: "Enter title",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: priceCtrl,
              decoration: InputDecoration(
                labelText: "Enter price",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 15),

            TextField(
              controller: descCtrl,
              decoration: InputDecoration(
                labelText: "Enter description",
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: pickImage,
              icon: Icon(Icons.camera_alt),
              label: Text("Take Photo"),
            ),

            SizedBox(height: 10),

            Wrap(
              spacing: 10,
              children: pickedImages
                  .map((img) => Image.file(
                        File(img.path),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
            ),

            SizedBox(height: 25),

            ElevatedButton(
              onPressed: () async {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Posting...")));

                await submitPost();

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Post Added!")));

                Navigator.pop(context);
              },
              child: Text("POST"),
            )
          ],
        ),
      ),
    );
  }
}
