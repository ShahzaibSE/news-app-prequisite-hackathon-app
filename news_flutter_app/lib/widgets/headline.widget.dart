import "package:flutter/material.dart";
import "news.model.dart";
import "newscard.widget.dart";

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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsSamples.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            // minLeadingWidth: 60,
            contentPadding: const EdgeInsets.all(10),
            leading: const FittedBox(
              child: Image(
                  image: AssetImage("./assets/forest-placeholder-pic.jpeg"),
                  fit: BoxFit.fill),
            ),
            title: Container(
              // padding: const EdgeInsets.only(top: 10),
              child: Text(
                newsSamples[index].name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            subtitle: Container(
              // padding: const EdgeInsets.only(top: 10),
              child: Text(
                newsSamples[index].time.toString(),
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
