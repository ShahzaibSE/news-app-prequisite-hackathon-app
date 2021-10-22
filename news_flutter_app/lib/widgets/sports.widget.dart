import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:awesome_loader/awesome_loader.dart';
import 'dart:convert';
import "news.model.dart";
import "newsstory.widget.dart";

class SportsWidget extends StatefulWidget {
  const SportsWidget({Key? key}) : super(key: key);

  @override
  _SportsWidgetState createState() => _SportsWidgetState();
}

class _SportsWidgetState extends State<SportsWidget> {
  final List<bool> _selections = List.generate(categories.length, (_) => false);

  getSportsNews({dynamic limit}) async {
    try {
      var uri = Uri.http(
        "api.mediastack.com",
        "/v1/news",
        {
          'access_key': access_key,
          'languages': 'en',
          'limit': '50',
          'categories': "sports"
        },
      );
      var response = await http.get(uri);
      List jsonResponse = jsonDecode(response.body)['data'];
      return jsonResponse;
    } catch (e) {
      throw e;
    }
  }

  Widget buildSportsNews(NewsModel headline, int index) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsStory(
                  isFavourite: true,
                  news: NewsModel(
                    headline.title,
                    image: headline.image,
                    description: headline.description,
                    published_at: headline.published_at,
                  ),
                  index: index),
            ),
          );
        },
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
              headline.title.characters.take(50).toString() + "...",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          subtitle: Container(
            // padding: const EdgeInsets.only(top: 10),
            child: Text(
              DateTime.parse(headline.published_at.toString()).hour.toString() +
                  "h",
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSportsNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: Colors.redAccent,
                    splashColor: Colors.greenAccent,
                    highlightColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20),
                    children: <Widget>[
                      Tooltip(
                        key: Key('general'),
                        message: "general",
                        child: Icon(Icons.all_out),
                      ),
                      Tooltip(
                        key: Key('sports'),
                        message: "sports",
                        child: Icon(Icons.sports),
                      ),
                      Tooltip(
                        key: Key('entertainment'),
                        message: "entertainment",
                        child: Icon(Icons.movie),
                      ),
                      Tooltip(
                        key: Key('science'),
                        message: "science",
                        child: Icon(Icons.science),
                      ),
                      Tooltip(
                        key: Key('business'),
                        message: "business",
                        child: Icon(Icons.business),
                      ),
                      Tooltip(
                        key: Key('technology'),
                        message: "technology",
                        child: Icon(Icons.computer),
                      ),
                      Tooltip(
                        key: Key('health'),
                        message: "health",
                        child: Icon(Icons.health_and_safety),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (var i = 0; i < _selections.length; i++) {
                          if (i == index) {
                            _selections[index] = !_selections[i];
                          } else {
                            _selections[i] = false;
                          }
                        }
                        // _selections[index] = !_selections[index];
                      });
                    },
                    isSelected: _selections,
                  ),
                ),
                LimitedBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        snapshot.data.length,
                        (index) => buildSportsNews(
                          NewsModel(
                            snapshot.data[index]['title'],
                            image: snapshot.data[index]['image'],
                            description: snapshot.data[index]['description'],
                            published_at: snapshot.data[index]['published_at'],
                          ),
                          index,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            child: const AwesomeLoader(
              loaderType: AwesomeLoader.AwesomeLoader3,
              color: Colors.white,
            ),
            color: Colors.red,
          );
        }
      },
    );
  }
}
