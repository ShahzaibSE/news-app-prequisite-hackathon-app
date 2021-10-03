import 'dart:convert';

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
      var topNewsList = jsonResponse.map(
        (item) => NewsModel(
          item['title'],
          description: item['description'],
          image: item['image'],
          category: item['category'],
          published_at: item['published_at'],
        ),
      );
      return topNewsList;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    getTopNews();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          newsSamples.length,
          (index) => NewsCard(
            news: newsSamples[index],
          ),
        ),
      ),
    );
    // return FutureBuilder(
    //   future: getTopNews(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     return SingleChildScrollView(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: List.generate(
    //           newsSamples.length,
    //           (index) => NewsCard(
    //             news: snapshot.data[index],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
