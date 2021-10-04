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

  Widget buildSportsNews(NewsModel headline) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsStory(
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
                    width: MediaQuery.of(context).size.width / 2,
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
                ),
              ),
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
