import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//
import "./homenews.widget.dart";

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  //
  Widget buildTextFormField(Key keyName, String textcontrollerName,
      TextEditingController textController) {
    if (textcontrollerName == "Password") {
      return TextFormField(
        controller: textController,
        key: keyName,
        keyboardType: TextInputType.visiblePassword,
        autofocus: true,
        decoration: InputDecoration(
          hintText: textcontrollerName[0].toUpperCase() +
              textcontrollerName.substring(1),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      );
    } else if (textcontrollerName == "Date") {
      return TextFormField(
        controller: textController,
        key: keyName,
        keyboardType: TextInputType.datetime,
        autofocus: true,
        decoration: InputDecoration(
          hintText: textcontrollerName[0].toUpperCase() +
              textcontrollerName.substring(1),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      );
    } else if (textcontrollerName == "Email") {
      return TextFormField(
        controller: textController,
        key: keyName,
        keyboardType: TextInputType.emailAddress,
        autofocus: true,
        decoration: InputDecoration(
          hintText: textcontrollerName[0].toUpperCase() +
              textcontrollerName.substring(1),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      );
    } else {
      return TextFormField(
          controller: textController,
          key: keyName,
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          decoration: InputDecoration(
            hintText: textcontrollerName[0].toUpperCase() +
                textcontrollerName.substring(1),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ));
    }
  }

  // --- Register user config --- //
  register() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      const successDialog = AlertDialog(
        title: Text("Successfully signed up!"),
      );
      showDialog(
        context: context,
        builder: (context) => successDialog,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeNews(),
        ),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        const weakPasswordDialog = AlertDialog(
          title: Text("The password provided is too weak."),
        );
        showDialog(context: context, builder: (context) => weakPasswordDialog);
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        const userExistDialog = AlertDialog(
          title: Text("The account already exists for that email."),
        );
        showDialog(
          context: context,
          builder: (context) => userExistDialog,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      firstname.clear();
      lastname.clear();
      email.clear();
      password.clear();
    }
  }

  Widget buildRegister(Key keyName, String buttonText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 16,
        child: ElevatedButton(
          key: keyName,
          onPressed: register,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.redAccent),
          ),
        ),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Container(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 10),
                  // logo,
                  // const SizedBox(height: 20),
                  buildTextFormField(
                    const Key('firstname'),
                    'first Name',
                    firstname,
                  ),
                  const SizedBox(height: 20),
                  buildTextFormField(
                    const Key('lastname'),
                    'last Name',
                    lastname,
                  ),
                  const SizedBox(height: 20),
                  buildTextFormField(
                    const Key('email'),
                    'email',
                    email,
                  ),
                  const SizedBox(height: 20),
                  buildTextFormField(
                    const Key('password'),
                    'password',
                    password,
                  ),
                  // const SizedBox(height: 20),
                  buildRegister(
                    const Key('Sign Up'),
                    'Sign Up',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
