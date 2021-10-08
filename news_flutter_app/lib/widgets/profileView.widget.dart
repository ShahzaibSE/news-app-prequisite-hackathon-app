import 'dart:io';
import 'dart:convert';
import 'dart:async';

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import "package:firebase_auth/firebase_auth.dart";
import "package:http/http.dart" as http;
import 'package:awesome_loader/awesome_loader.dart';
import "news.model.dart";
// Editing profile.
import "./editProfile.widget.dart";

class ViewProfile extends StatefulWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
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
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User user = auth.currentUser as User;
      final uid = user.uid;
      var uri = Uri.http(
        "localhost:3000",
        "/profile/yourprofile/$uid",
      );
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      throw e;
    }
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

  //
  Widget profileView() {
    return FutureBuilder(
      future: getProfile(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 70,
                      child: ClipOval(
                          child: Image.network(
                        // 'assets/enlightnment-app-logo.jpeg',
                        snapshot.data['data']['imageUrl'].toString(),
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
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
                          hintText: snapshot.data['data']['name'].isEmpty
                              ? "Name"
                              : snapshot.data['data']['name'],
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
                          hintText: snapshot.data['data']['address'].isEmpty
                              ? "Address"
                              : snapshot.data['data']['address'],
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
                          hintText: snapshot.data['data']['card_number'].isEmpty
                              ? "Card Number"
                              : snapshot.data['data']['card_number'],
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
                  ],
                ),
              ))
            ],
          );
        } else {
          return Container(
            child: Center(
              child: const AwesomeLoader(
                loaderType: AwesomeLoader.AwesomeLoader3,
                color: Colors.white,
              ),
            ),
            color: Colors.red,
          );
        }
      },
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
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfile(),
                  ),
                );
              },
              child: const Icon(
                Icons.edit,
                size: 26.0,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: profileView(),
    );
  }
}
