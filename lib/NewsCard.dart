import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:intl/intl.dart";

class NewsCard extends StatefulWidget {
  final String title;
  final String description;
  final String publishedDate;
  final String url;
  final String image;
  final String source;

  const NewsCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.publishedDate,
      required this.url,
      required this.image,
      required this.source})
      : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Cannot launch URL";
    }
  }

  formatDate(String date) {
    DateTime dateTimeObject = DateTime.parse(date);
    var trueTime = DateFormat('dd-MMM-yyy').format(dateTimeObject);
    return trueTime;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      /** Card Widget **/
      child: GestureDetector(
        onTap: () {
          _launchURL(widget.url);
        },
        child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: Colors.deepPurple[200],
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 500,
              minWidth: 310,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.purple[500],
                    radius: 108,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.image), //NetworkImage
                      radius: 100,
                    ), //CircleAvatar
                  ), //CircleAvatar
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.purple[900],
                      fontWeight: FontWeight.w500,
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.purple[400],
                    ), //Textstyle
                  ),
                  const SizedBox(
                    height: 10,
                  ), //SizedBox
                  Text(
                    "Source: " +
                        widget.source +
                        " on " +
                        formatDate(widget.publishedDate),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.purple[400],
                    ), //Textstyle
                  ), //Text //SizedBox
                  SizedBox(
                    width: 100,
                  ), //SizedBox
                ],
              ), //Column
            ), //Padding
          ), //SizedBox
        ),
      ), //Card
    );
  }
}
