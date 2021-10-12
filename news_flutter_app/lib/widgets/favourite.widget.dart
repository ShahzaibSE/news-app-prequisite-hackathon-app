import 'dart:convert';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "./newscard.widget.dart";
import "./newsstory.widget.dart";
import "./news.model.dart";

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  getFavourites() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User user = auth.currentUser as User;
      final uid = user.uid;
      var uri = Uri.http(
        "localhost:3000",
        "/favourite/list",
      );
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['data'];
    } catch (e) {
      throw e;
    }
  }

  //
  deleteFavourite() async {}
  //
  Widget buildFavourite(NewsModel headline, int index) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsStory(
                isFavourite: false,
                index: index,
                news: NewsModel(
                  headline.title,
                  image: headline.image,
                  description: headline.description,
                  published_at: headline.published_at,
                ),
              ),
            ),
          );
        },
        child: Container(
          child: Slidable(
            actionPane: const SlidableBehindActionPane(),
            actionExtentRatio: 0.25,
            child: ListTile(
              // minLeadingWidth: 60,
              contentPadding: const EdgeInsets.all(10),
              leading: FittedBox(
                child: headline.image == null
                    ? Image(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          "assets/enlightnment-app-logo.jpeg",
                        ),
                        width: MediaQuery.of(context).size.width / 4,
                        height: 80,
                      )
                    : Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          headline.image.toString(),
                        ),
                        width: MediaQuery.of(context).size.width / 4,
                        height: 80,
                      ),
              ),
              title: Container(
                // padding: const EdgeInsets.only(top: 10),
                child: Text(
                  headline.title.characters.take(30).toString() + "...",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              trailing: const Tooltip(
                message: "drag to left",
                showDuration: Duration(seconds: 3),
                child: Icon(Icons.drag_indicator),
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourites",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getFavourites(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  snapshot.data.length,
                  (index) => buildFavourite(
                    NewsModel(
                      snapshot.data[index]['title'],
                      image: snapshot.data[index]['image'],
                      description: snapshot.data[index]['description'],
                    ),
                    index,
                  ),
                ),
              ),
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
      ),
    );
  }
}
