import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:awesome_loader/awesome_loader.dart';
import 'dart:convert';
import "news.model.dart";
import "newsstory.widget.dart";

final List<NewsModel> newsSamples = [
  NewsModel("News time is the best thing to relax yourself", time: "5h"),
  NewsModel("News", time: "5h"),
  NewsModel("News", time: "5h"),
  NewsModel("News", time: "5h"),
  NewsModel("News", time: "5h"),
];

class HeadlineWidget extends StatefulWidget {
  const HeadlineWidget({Key? key}) : super(key: key);

  @override
  _HeadlineWidgetState createState() => _HeadlineWidgetState();
}

class _HeadlineWidgetState extends State<HeadlineWidget> {
  final List<bool> _selections = List.generate(categories.length, (_) => false);
  String? category = "general";

  getHeadlines({dynamic limit, String? categoryParam}) async {
    try {
      var uri = Uri.http(
        "api.mediastack.com",
        "/v1/news",
        {
          'access_key': access_key,
          'languages': 'en',
          // 'limit': '50',
          'categories': categoryParam.toString()
        },
      );
      var response = await http.get(uri);
      List jsonResponse = jsonDecode(response.body)['data'];
      // print(jsonResponse);
      // var newsModel = NewsModel(jsonResponse[0]['title']);
      // print(newsModel.title);
      return jsonResponse;
    } catch (e) {
      throw e;
    }
  }

  Widget buildHeadline(NewsModel headline, int index) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsStory(
                isFavourite: true,
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
      future: getHeadlines(categoryParam: category),
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
                    borderColor: Colors.red,
                    children: <Widget>[
                      Tooltip(
                        key: Key('general'),
                        message: "general",
                        child: Icon(Icons.all_out),
                      ),
                      Tooltip(
                        key: Key('business'),
                        message: "business",
                        child: Icon(Icons.business),
                      ),
                      Tooltip(
                        key: Key('entertainment'),
                        message: "entertainment",
                        child: Icon(Icons.movie),
                      ),
                      Tooltip(
                        key: Key('health'),
                        message: "health",
                        child: Icon(Icons.health_and_safety),
                      ),
                      Tooltip(
                        key: Key('sports'),
                        message: "sports",
                        child: Icon(Icons.sports),
                      ),
                      Tooltip(
                        key: Key('technology'),
                        message: "technology",
                        child: Icon(Icons.computer),
                      ),
                      Tooltip(
                        key: Key('science'),
                        message: "science",
                        child: Icon(Icons.science),
                      ),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (var i = 0; i < _selections.length; i++) {
                          if (i == index) {
                            _selections[index] = true;
                          } else {
                            _selections[i] = false;
                          }
                        }
                        category = categories[index];
                        getHeadlines(categoryParam: category);
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
                        (index) => buildHeadline(
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
    // return ListView.builder(
    //   itemCount: newsSamples.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Card(
    //       child: ListTile(
    //         // minLeadingWidth: 60,
    //         contentPadding: const EdgeInsets.all(10),
    //         leading: const FittedBox(
    //           child: Image(
    //               image: AssetImage("./assets/forest-placeholder-pic.jpeg"),
    //               fit: BoxFit.fill),
    //         ),
    //         title: Container(
    //           // padding: const EdgeInsets.only(top: 10),
    //           child: Text(
    //             newsSamples[index].title,
    //             style:
    //                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    //           ),
    //         ),
    //         subtitle: Container(
    //           // padding: const EdgeInsets.only(top: 10),
    //           child: Text(
    //             newsSamples[index].time.toString(),
    //             style: const TextStyle(
    //               fontSize: 15,
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
