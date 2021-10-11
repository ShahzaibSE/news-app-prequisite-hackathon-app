import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:http/http.dart" as http;
import 'dart:convert';
//
import "./news.model.dart";

class NewsStory extends StatefulWidget {
  const NewsStory({Key? key, required this.news, required this.index})
      : super(key: key);

  final NewsModel news;
  final int index;

  @override
  _NewsStoryState createState() => _NewsStoryState();
}

class _NewsStoryState extends State<NewsStory> {
  bool? isFavourite;
  //
  addToFavourite(NewsModel news) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final User user = auth.currentUser as User;
      final uid = user.uid;
      Uri uri = Uri.http('localhost:3000', '/favourite/add');
      http.Response response = await http.post(uri, body: {
        'uid': uid,
        'title': news.title,
        'description': news.description,
        'author': news.author,
        'category': news.category,
        'source': news.source,
        'imageUrl': news.image,
        'video': news.video,
        'country': news.country,
        'url': news.url
      });
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } catch (e) {
      throw e;
    }
  }

  deleteFavourite() async {}

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news.title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              key: Key(
                widget.index.toString(),
              ),
              onTap: () {
                print('Added to favourites');
              },
              child: Icon(
                Icons.favorite_rounded,
                size: 26.0,
                key: Key(
                  widget.index.toString(),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: widget.news.image == null
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
                          widget.news.image.toString(),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                      ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  widget.news.title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  // vertical: 10.0,
                ),
                child: Text(
                  // "1h",
                  DateTime.parse(widget.news.published_at.toString())
                          .hour
                          .toString() +
                      "h",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  // child: const Text(
                  //   "Imran Ahmed Khan Niazi HI PP is the 22nd and current prime minister of Pakistan. He is also the chairman of the Pakistan Tehreek-e-Insaf. Before entering politics, Khan was an international cricketer and captain of the Pakistan national cricket team, which he led to victory in the 1992 Cricket World Cup.",
                  //   style: const TextStyle(
                  //     fontSize: 15,
                  //   ),
                  child: Text(
                    widget.news.description.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
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

// class NewsStory extends StatelessWidget {
//   const NewsStory({Key? key, required this.news, required this.index})
//       : super(key: key);

//   final NewsModel news;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           news.title,
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: GestureDetector(
//               key: Key(
//                 index.toString(),
//               ),
//               onTap: () {
//                 print('Added to favourites');
//               },
//               child: Icon(
//                 Icons.favorite_rounded,
//                 size: 26.0,
//                 key: Key(
//                   index.toString(),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Card(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: news.image == null
//                     ? Image(
//                         fit: BoxFit.fitWidth,
//                         image: AssetImage(
//                           "assets/enlightnment-app-logo.jpeg",
//                         ),
//                         width: MediaQuery.of(context).size.width,
//                         height: 80,
//                       )
//                     : Image(
//                         fit: BoxFit.fitWidth,
//                         image: NetworkImage(
//                           news.image.toString(),
//                         ),
//                         width: MediaQuery.of(context).size.width,
//                         height: 80,
//                       ),
//               ),
//               Container(
//                 padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                 child: Text(
//                   news.title,
//                   style: const TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10.0,
//                   // vertical: 10.0,
//                 ),
//                 child: Text(
//                   // "1h",
//                   DateTime.parse(news.published_at.toString()).hour.toString() +
//                       "h",
//                   style: const TextStyle(
//                     fontSize: 15,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10.0,
//                     vertical: 10.0,
//                   ),
//                   // child: const Text(
//                   //   "Imran Ahmed Khan Niazi HI PP is the 22nd and current prime minister of Pakistan. He is also the chairman of the Pakistan Tehreek-e-Insaf. Before entering politics, Khan was an international cricketer and captain of the Pakistan national cricket team, which he led to victory in the 1992 Cricket World Cup.",
//                   //   style: const TextStyle(
//                   //     fontSize: 15,
//                   //   ),
//                   child: Text(
//                     news.description.toString(),
//                     style: const TextStyle(
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
