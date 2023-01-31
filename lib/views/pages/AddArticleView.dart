import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mes_envies/views/Widgets/AddTextField.dart';
import 'package:mes_envies/views/Widgets/CustomAppBar.dart';

class AddArticleView extends StatefulWidget {
  int listId;

  AddArticleView({super.key, required this.listId});
  @override
  AddArticleViewState createState() => AddArticleViewState();
}

class AddArticleViewState extends State<AddArticleView> {
  late TextEditingController nameController;
  late TextEditingController shopController;
  late TextEditingController priceController;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    shopController = TextEditingController();
    priceController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    shopController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleString: "Ajouter un article",
        buttonTitle: "Ajouter",
        callback: addPressed,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Nouvel Article",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (imagePath == null)
                      ? const Icon(
                          Icons.camera,
                          size: 128,
                        )
                      : Image.file(File(imagePath!)),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: (() => takePicture(ImageSource.camera)),
                        icon: const Icon(Icons.camera_alt),
                      ),
                      IconButton(
                        onPressed: (() => takePicture(ImageSource.gallery)),
                        icon: const Icon(Icons.photo_library),
                      ),
                    ],
                  ),
                  AddTextField(
                    hint: "Nom",
                    controller: nameController,
                  ),
                  AddTextField(
                    hint: "Price",
                    controller: priceController,
                    type: TextInputType.number,
                  ),
                  AddTextField(
                    hint: "Magasin",
                    controller: shopController,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  addPressed() {}
  takePicture(ImageSource source) async {
    XFile? xFile = await ImagePicker().pickImage(source: source);
    if (xFile == null) return;
    setState(() {
      imagePath = xFile.path!;
    });
  }
}
