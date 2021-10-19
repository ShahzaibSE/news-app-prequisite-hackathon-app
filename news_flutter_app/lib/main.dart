import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splashscreen/splashscreen.dart';
// Widget
import './widgets/homenews.widget.dart';
import "./widgets/user-auth-container.widget.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class Splash extends StatelessWidget {
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      // image: Image.asset(
      //   'assets/welcome-app.png',
      //   colorBlendMode: BlendMode.clear,
      // ),
      navigateAfterSeconds: const MyHomePage(title: 'Enlightenment'),
      loaderColor: Colors.white,
      photoSize: 100.0,
      title: const Text(
        'Welcome to Enlightenment',
        style: TextStyle(
          fontFamily: "Royale",
          fontSize: 50,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        // if (snapshot.hasError) {
        //   return SomethingWentWrong();
        // }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.red,
                fontFamily: 'Nunito'),
            home: Splash(),
            routes: {
              UserAuth.tag: (BuildContext context) => const UserAuth(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Text("Loading...");
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return HomeNews();
  }
}
