import "package:flutter/material.dart";
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
  @override
  Widget build(BuildContext context) {
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
  }
}
