import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Widgets.
import "./topnews.widget.dart";
import "./headline.widget.dart";
import "./popular.widget.dart";
import "./sports.widget.dart";
import "./user-auth-container.widget.dart";
import "./profile.widget.dart";
import "./search.widget.dart";
import "./searchnews.widget.dart";
import "./favourite.widget.dart";

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

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Enlightenment',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('./assets/drawer-cover.jpeg'),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Welcome'),
            onTap: () => {
              Navigator.pop(context),
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Profile'),
            // onTap: () => {Navigator.of(context).pop()},
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_rounded),
            title: const Text('Favourite'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Favourite(),
                ),
              ),
            },
          ),
          const Divider(
            key: Key('divider-profile'),
            thickness: 1.0,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: logout,
          ),
          // ListTile(
          //   leading: const Icon(Icons.category),
          //   title: const Text('Category'),
          //   onTap: () => {},
          // ),
        ],
      ),
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
          drawer: buildDrawer(),
          appBar: AppBar(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchNews(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                ),
              ),
              // Padding(
              //     padding: const EdgeInsets.only(right: 20.0),
              //     child: GestureDetector(
              //       onTap: logout,
              //       child: const Icon(Icons.settings_power),
              //     )),
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
