import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:http/http.dart" as http;
import 'dart:convert';
//
import "./news.model.dart";

class NewsStory extends StatefulWidget {
  const NewsStory(
      {Key? key,
      required this.news,
      required this.index,
      required this.isFavourite})
      : super(key: key);

  final NewsModel news;
  final int index;
  final bool isFavourite;

  @override
  _NewsStoryState createState() => _NewsStoryState();
}

class _NewsStoryState extends State<NewsStory> {
  //
  addToFavourite(NewsModel news) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      final User user = auth.currentUser as User;
      final uid = user.uid;
      var uri = Uri.http('localhost:3000', '/favourite/add');
      var newFavourite = {'uid': uid, 'title': news.title};
      // Null checking on new favourite keys.
      if (news.image != null) {
        newFavourite['imageUrl'] = news.image.toString();
      }
      if (news.description != null) {
        newFavourite['description'] = news.description.toString();
      }
      if (news.category != null) {
        newFavourite['category'] = news.category.toString();
      }
      if (news.author != null) {
        newFavourite['author'] = news.author.toString();
      }
      if (news.video != null) {
        newFavourite['video'] = news.video.toString();
      }
      if (news.country != null) {
        newFavourite['country'] = news.country.toString();
      }
      if (news.url != null) {
        newFavourite['url'] = news.url.toString();
      }
      if (news.source != null) {
        newFavourite['source'] = news.source.toString();
      }
      if (news.time != null) {
        newFavourite['time'] = news.time.toString();
      }

      if (news.published_at != null) {
        newFavourite['published_at'] = news.published_at.toString();
      }

      var response = await http.post(uri, body: newFavourite);
      var jsonResponse = jsonDecode(response.body);
      //
      if (jsonResponse['status'] == false) {
        const ifAlreadyFavourite = AlertDialog(
            title: Text(
              "Favourite already exists.",
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ));
        showDialog(context: context, builder: (context) => ifAlreadyFavourite);
      } else {
        const newFavouriteAdded = AlertDialog(
            title: Text(
              "Favourite added!",
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ));
        showDialog(context: context, builder: (context) => newFavouriteAdded);
      }
      //
      return jsonResponse;
    } catch (e) {
      throw e;
    }
  }

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
        actions: widget.isFavourite == true
            ? <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    key: Key(
                      widget.index.toString(),
                    ),
                    onTap: () {
                      // setState(() {
                      addToFavourite(widget.news);
                      // });
                    },
                    child: GestureDetector(
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 26.0,
                        key: Key(
                          widget.index.toString(),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            : [],
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
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 10.0,
              //     // vertical: 10.0,
              //   ),
              //   child: Text(
              //     // "1h",
              //     DateTime.parse(widget.news.published_at.toString())
              //             .hour
              //             .toString() +
              //         "h",
              //     style: const TextStyle(
              //       fontSize: 15,
              //       color: Colors.grey,
              //     ),
              //   ),
              // ),
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
