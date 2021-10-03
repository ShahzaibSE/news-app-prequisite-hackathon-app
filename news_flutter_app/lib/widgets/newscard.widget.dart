import "package:flutter/material.dart";
//
import "./news.model.dart";
import "./newsstory.widget.dart";

class NewsCard extends StatelessWidget {
  const NewsCard({Key? key, required this.news}) : super(key: key);
  final NewsModel news;

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
                news: NewsModel(
                  news.title,
                  image: news.image,
                  description: news.description,
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
              // Stack(
              //   children: [
              //     Align(
              //       alignment: Alignment.centerLeft,
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 10.0,
              //           vertical: 10.0,
              //         ),
              //         child: const Text(
              //           "1 hour",
              //           style: const TextStyle(
              //             fontSize: 15,
              //             color: Colors.grey,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Align(
              //       alignment: Alignment.centerRight,
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(
              //           horizontal: 10.0,
              //           vertical: 10.0,
              //         ),
              //         child: IconButton(
              //           onPressed: () {},
              //           icon: const Icon(Icons.favorite_rounded),
              //         ),
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
