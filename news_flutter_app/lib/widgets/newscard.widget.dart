import "package:flutter/material.dart";
//
import "./news.model.dart";
import "./newsstory.widget.dart";

class NewsCard extends StatelessWidget {
  const NewsCard({Key? key, required this.news, required this.index})
      : super(key: key);
  final NewsModel news;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsStory(
                index: index,
                news: NewsModel(
                  news.title,
                  image: news.image,
                  description: news.description,
                  published_at: news.published_at,
                ),
              ),
            ),
          );
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: news.image == null
                    ? Image(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "assets/enlightnment-app-logo.jpeg",
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                      )
                    : Image(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                          news.image.toString(),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                      ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Text(
                  DateTime.parse(news.published_at.toString()).hour.toString() +
                      "h",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
