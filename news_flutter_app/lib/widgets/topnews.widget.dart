import 'dart:convert';
import 'package:awesome_loader/awesome_loader.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "./newscard.widget.dart";
import 'package:icofont_flutter/icofont_flutter.dart';
//
import "news.model.dart";

final List<NewsModel> newsSamples = [
  NewsModel("News"),
  NewsModel("News"),
  NewsModel("News"),
  NewsModel("News"),
  NewsModel("News"),
];

class TopNews extends StatefulWidget {
  const TopNews({Key? key}) : super(key: key);

  @override
  _TopNewsState createState() => _TopNewsState();
}

class _TopNewsState extends State<TopNews> {
  List<bool> _selections = List.generate(categories.length, (_) => false);
  String? category;
  getTopNews({dynamic limit, String? categoryParam}) async {
    try {
      var uri = categoryParam == null
          ? Uri.http(
              "api.mediastack.com",
              "/v1/news",
              {
                'access_key': access_key,
                'languages': 'en',
              },
            )
          : Uri.http(
              "api.mediastack.com",
              "/v1/news",
              {
                'access_key': access_key,
                'languages': 'en',
                'categories': category.toString()
              },
            );
      var response = await http.get(uri);
      List jsonResponse = jsonDecode(response.body)['data'];
      return jsonResponse;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    // getTopNews();
    // return SingleChildScrollView(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: List.generate(
    //       newsSamples.length,
    //       (index) => NewsCard(
    //         news: newsSamples[index],
    //       ),
    //     ),
    //   ),
    // );
    return FutureBuilder(
      future: getTopNews(categoryParam: category),
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
                        getTopNews(categoryParam: category);
                        if (category == '') {
                          print('Category unselected');
                        }
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
                        (index) => NewsCard(
                          index: index,
                          news: NewsModel(
                            snapshot.data[index]['title'],
                            image: snapshot.data[index]['image'],
                            description: snapshot.data[index]['description'],
                            published_at: snapshot.data[index]['published_at'],
                          ),
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
