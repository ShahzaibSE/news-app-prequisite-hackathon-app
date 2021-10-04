import 'dart:convert';
import 'package:awesome_loader/awesome_loader.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "./newscard.widget.dart";
import "news.model.dart"; // Here is access key as well.
import "newsstory.widget.dart";

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchTextController = TextEditingController();
  String dropdownValue = "general";
  List<dynamic> searchList = [];

  searchNews() async {
    print('Selected category: $dropdownValue');
    try {
      var uri = Uri.http(
        "api.mediastack.com",
        "/v1/news",
        {
          'access_key': access_key,
          'languages': 'en',
          'categories': dropdownValue,
          'search': searchTextController.text
        },
      );
      var response = await http.get(uri);
      print(response.body);
      // List jsonResponse = jsonDecode(response.body)['data'];

      // setState() {
      searchList = jsonDecode(response.body)['data'];
      // }

      print("Search List");
      print(searchList);

      // return searchList;

      // return jsonResponse;
    } catch (e) {
      throw e;
    }
  }

  clearFilters() {
    // setState() {
    dropdownValue = "general";
    // print('Cleared filters');
    // print(dropdownValue);
    // }
  }

  Widget buildSearchResults(NewsModel searchResult) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsStory(
                news: NewsModel(
                  searchResult.title,
                  image: searchResult.image,
                  description: searchResult.description,
                  published_at: searchResult.published_at,
                ),
              ),
            ),
          );
        },
        child: ListTile(
          // minLeadingWidth: 60,
          contentPadding: const EdgeInsets.all(10),
          leading: FittedBox(
            child: searchResult.image == null
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
                      searchResult.image.toString(),
                    ),
                    width: MediaQuery.of(context).size.width / 4,
                    height: 80,
                  ),
          ),
          title: Container(
            // padding: const EdgeInsets.only(top: 10),
            child: Text(
              searchResult.title.characters.take(50).toString() + "...",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          subtitle: Container(
            // padding: const EdgeInsets.only(top: 10),
            child: Text(
              DateTime.parse(searchResult.published_at.toString())
                      .hour
                      .toString() +
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

  Future<void> _getData() async {
    // setState(
    //   () {
    //     searchNews();
    //   },
    // );
    return searchNews();
  }

  @override
  void initState() {
    super.initState();
    searchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            onEditingComplete: () {
              _getData();
              initState();
            },
            controller: searchTextController,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              hintText: "Search here",
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
                size: 20,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                var filtersAlert = AlertDialog(
                  key: const Key('filters'),
                  title: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: dropdownValue,
                            icon: const Icon(
                              Icons.arrow_downward,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                                Navigator.pop(context);
                              });
                            },
                            items: <String>[
                              'general',
                              'business',
                              'technology',
                              'science',
                              "entertainment",
                              "health",
                              "sports"
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  actions: [
                    // Container(
                    //   child: ElevatedButton(
                    //     child: Text('Ok'),
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // ),
                    Container(
                      child: ElevatedButton(
                        child: Text('Clear'),
                        onPressed: () {
                          clearFilters();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                );
                showDialog(
                    context: context, builder: (context) => filtersAlert);
              },
              child: const Icon(
                Icons.filter_list,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: searchList.length != 0
          ? Container(
              child: RefreshIndicator(
              child: ListView.builder(
                itemCount: searchList.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildSearchResults(
                    NewsModel(
                      searchList[index]['title'],
                      image: searchList[index]['image'],
                      description: searchList[index]['description'],
                      published_at: searchList[index]['published_at'],
                    ),
                  );
                },
              ),
              onRefresh: _getData,
            ))
          : Center(
              child: const AwesomeLoader(
                loaderType: AwesomeLoader.AwesomeLoader3,
                color: Colors.black,
              ),
            ),
    );
  }
}
