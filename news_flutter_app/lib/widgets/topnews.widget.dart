import 'dart:convert';
import 'package:awesome_loader/awesome_loader.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "./newscard.widget.dart";
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
  getTopNews({dynamic limit}) async {
    try {
      var uri = Uri.http(
        "api.mediastack.com",
        "/v1/news",
        {'access_key': access_key},
      );
      var response = await http.get(uri);
      List jsonResponse = jsonDecode(response.body)['data'];
      print("Top News - JSON");
      // print(jsonResponse);
      var newsModel = NewsModel(jsonResponse[0]['title']);
      print(newsModel.title);
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
      future: getTopNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                newsSamples.length,
                (index) => NewsCard(
                  news: NewsModel(
                    snapshot.data[index]['title'],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(
            child: AwesomeLoader(
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
