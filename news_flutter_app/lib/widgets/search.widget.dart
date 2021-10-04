import 'dart:convert';
import 'package:awesome_loader/awesome_loader.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "./newscard.widget.dart";

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController searchTextController = TextEditingController();

  setFilters() {
    print("Selected category: $dropdownValue");
  }

  clearFilters() {
    setState() {
      dropdownValue = "general";
    }

    print("Cleared category filter");
    print(dropdownValue);
  }

  String dropdownValue = "general";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
            child: const TextField(
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              decoration: InputDecoration(
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
                                  setFilters();
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
                      Container(
                        child: ElevatedButton(
                          child: Text('Ok'),
                          onPressed: () {
                            setFilters();
                            Navigator.pop(context);
                          },
                        ),
                      ),
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
          ]),
    );
  }
}
