import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//
import "./homenews.widget.dart";

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //
  Widget buildTextFormField(Key keyName, String textcontrollerName,
      TextEditingController textController) {
    if (textcontrollerName == "email") {
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
    } else {
      return TextFormField(
          controller: textController,
          key: keyName,
          keyboardType: TextInputType.visiblePassword,
          autofocus: true,
          obscureText: true,
          decoration: InputDecoration(
            hintText: textcontrollerName[0].toUpperCase() +
                textcontrollerName.substring(1),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          ));
    }
  }

  // --- Login Configuration --- //
  login() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeNews(),
        ),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        const noUserDialog = AlertDialog(
          title: Text("No user found for that email."),
        );
        showDialog(
          context: context,
          builder: (context) => noUserDialog,
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        const wrongPasswordDialog = AlertDialog(
          title: Text("Wrong password provided for that user."),
        );
        showDialog(
          context: context,
          builder: (context) => wrongPasswordDialog,
        );
      }
    } finally {
      emailController.clear();
      passwordController.clear();
    }
  }

  Widget buildLogin(Key keyName, String buttonText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 16,
        child: ElevatedButton(
          key: keyName,
          onPressed: login,
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
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
          ),
        ),
      ),
    );
  }

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
          'Log In',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        toolbarHeight: 100,
      ),
      body: Container(
        child: Center(
          child: Card(
            child: Form(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  // logo,
                  // const SizedBox(height: 20),
                  buildTextFormField(Key("emailKey"), "email", emailController),
                  const SizedBox(height: 20),
                  buildTextFormField(
                      Key("passwordKey"), "password", passwordController),
                  const SizedBox(height: 20),
                  buildLogin(Key('login'), 'Log In'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
