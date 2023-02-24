import 'package:flutter/material.dart';
import 'package:news_app/APIFunctions.dart';
import 'package:news_app/NewsCard.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late Future futureResponse;
  @override
  void initState() {
    super.initState();

    futureResponse = getTopNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureResponse,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10.0),
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
                            publishedDate: data["articles"][index]
                                ["publishedAt"],
                            url: data["articles"][index]["url"],
                            image: data["articles"][index]["image"],
                            source: data["articles"][index]["source"]["name"],
                          );
                        }),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
