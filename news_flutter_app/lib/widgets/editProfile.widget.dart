import 'dart:io';
import 'dart:convert';

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import "package:firebase_auth/firebase_auth.dart";
import "package:http/http.dart" as http;
import 'package:awesome_loader/awesome_loader.dart';
import "news.model.dart";

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController paymentDetailsController =
      TextEditingController();
  // Image Picker configs.
  String? imagePath;
  String? downloadLink;
  bool isEditable = false;
  //
  getProfile() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser as User;
    final uid = user.uid;
    var uri = Uri.http(
      "localhost:3000",
      "/profile/yourprofile/$uid",
    );
    var response = await http.get(uri);
    var jsonResponse = jsonDecode(response.body);
    print("Your profile");
    print(jsonResponse);
    return jsonResponse['data'];
  }

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
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User user = auth.currentUser as User;
      final uid = user.uid;
      String name = nameController.text;
      String address = addressController.text;
      String payment = paymentDetailsController.text;
      String seconds = DateTime.now().second.toString();
      String default_profile_pic = "/profilepic$seconds.jpg";
      String namedProfilePic = '/$name.jpg';
      // print("Firebase user id: $uid");
      // Firestorage Instance.
      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      firebase_storage.Reference ref =
          firebase_storage.FirebaseStorage.instance.ref("/$uid.png");
      final profile_pic_download_link = await ref.getDownloadURL();
      print("Path of the selected image");
      print(imagePath);
      print("Download link");
      print(profile_pic_download_link.toString());
      setState(() {
        downloadLink = profile_pic_download_link.toString();
      });
      // print(DateTime.now().second);
      File file = File(imagePath!);
      await ref.putFile(file);
      var createdProfileURI = Uri.http(
        "localhost:3000",
        "/profile/create",
      );
      var response = await http.post(
        createdProfileURI,
        body: {
          'uid': uid,
          'name': name,
          'address': address,
          'card_number': payment,
          "imageUrl": downloadLink.toString()
        },
      );
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
    return FutureBuilder(
        future: getProfile(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 70,
                      child: ClipOval(
                        child: imagePath == null
                            ? Image.asset(
                                'assets/enlightnment-app-logo.jpeg',
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              )
                            : downloadLink == null
                                ? Image.asset(
                                    imagePath.toString(),
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    downloadLink!,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
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
                        enabled: isEditable,
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
                        enabled: isEditable,
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
                        enabled: isEditable,
                        controller: paymentDetailsController,
                        key: const Key("payment-card-number"),
                        keyboardType: TextInputType.emailAddress,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Debit/Credit Card Number",
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
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 20),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.edit,
                  size: 26.0,
                  color: Colors.white,
                ),
              ),
            )
          ]),
      body: profileView(),
    );
  }
}
