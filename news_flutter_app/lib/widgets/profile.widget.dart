import 'dart:io';

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController paymentDetailsController =
      TextEditingController();
  // Image Picker configs.
  String? imagePath;
  //
  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagePath = image!.path;
      print(imagePath);
    });
  }

  saveProfile() async {
    try {
      String name = nameController.text;
      String address = addressController.text;
      String payment = paymentDetailsController.text;
      // Firestorage Instance.
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref('/profile-pic.jpg');
      print("Path of the selected engineer");
      print(imagePath);

      // print(DateTime.now().second);
      // File file = File(imagePath!);
      // await ref.putFile(file);
    } catch (e) {
      throw e;
    } finally {
      nameController.clear();
      addressController.clear();
      paymentDetailsController.clear();
    }
  }

  //
  Widget profileView() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                child: ClipOval(
                  child: Image.asset(
                    'assets/enlightnment-app-logo.jpeg',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    height: 40,
                    width: 40,
                    child: GestureDetector(
                      onTap: () {
                        print("Upload your picture");
                        pickImage();
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ))
            ],
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.black54,
                Color.fromRGBO(0, 41, 102, 1),
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                child: TextFormField(
                  controller: nameController,
                  key: const Key("name"),
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                child: TextFormField(
                  controller: addressController,
                  key: const Key("address"),
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Address",
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                child: TextFormField(
                  controller: paymentDetailsController,
                  key: const Key("payment-card-number"),
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Payment Card Number",
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    focusColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: saveProfile,
                    child: Container(
                      height: 70,
                      width: 200,
                      child: Align(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white70, fontSize: 20),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: profileView(),
    );
  }
}
