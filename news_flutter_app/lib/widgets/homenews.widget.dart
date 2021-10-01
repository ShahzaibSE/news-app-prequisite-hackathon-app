import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Widgets.
import "./topnews.widget.dart";
import "./headline.widget.dart";
import "./popular.widget.dart";
import "./sports.widget.dart";
import "./user-auth-container.widget.dart";

const tabs = <Widget>[
  Tab(
    // height: 60,
    child: Text(
      'Top News',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  Tab(
    child: Text(
      'Headlines',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  Tab(
    child: Text(
      'Popular',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  Tab(
    child: Text(
      'Sports',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
];

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  _HomeNewsState createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  FirebaseAuth auth = FirebaseAuth.instance;
  logout() async {
    print("Logout button tapped.");
    await FirebaseAuth.instance.signOut();
    //
    // Navigator.popUntil(
    //     context, (Route<dynamic> route) => route.settings.name == UserAuth.tag);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const UserAuth(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {/* Write listener code here */},
              child: const Icon(
                Icons.menu, // add custom icons also
              ),
            ),
            title: const Text(
              "Enlightenment",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            bottom: const TabBar(
              isScrollable: true,
              tabs: tabs,
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      print('Search button tapped');
                    },
                    child: const Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: logout,
                    child: const Icon(Icons.settings_power),
                  )),
            ],
          ),
          body: const TabBarView(
            children: [
              TopNews(),
              HeadlineWidget(),
              PopularWidget(),
              SportsWidget(),
            ],
          ),
        );
      }),
    );
  }
}
