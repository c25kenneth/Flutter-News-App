import 'package:flutter/material.dart';
import 'package:news_app/APIFunctions.dart';
import 'package:news_app/NewsCard.dart';

class FindNews extends StatefulWidget {
  const FindNews({Key? key}) : super(key: key);

  @override
  State<FindNews> createState() => _FindNewsState();
}

class _FindNewsState extends State<FindNews> {
  late Future<dynamic> futureSearch;
  late Future exampleArticles;

  String query = "";
  @override
  void initState() {
    super.initState();

    exampleArticles = newsSearchExample();
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: (query == "") ? exampleArticles : futureSearch,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Container(
                  width: 350,
                  child: TextField(
                      controller: myController,
                      obscureText: false,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              futureSearch = newsSearch(myController.text);
                              setState(() {
                                query = myController.text;
                              });
                            },
                          ),
                          hintText: "Search for specific news here",
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)))),
                ),
                SizedBox(height: 10),
                Flexible(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        var data = snapshot.data as Map;
                        return NewsCard(
                          description: data["articles"][index]["description"],
                          title: data["articles"][index]["title"],
                          publishedDate: data["articles"][index]["publishedAt"],
                          url: data["articles"][index]["url"],
                          image: data["articles"][index]["image"],
                          source: data["articles"][index]["source"]["name"],
                        );
                      }),
                ),
              ],
            ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
