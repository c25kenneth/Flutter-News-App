import 'dart:convert';

import 'APIKEY.dart';
import "package:http/http.dart" as http;

Future getTopNews() async {
  String endpoint =
      "https://gnews.io/api/v4/top-headlines?category=general&lang=en&nullable=None&max=5&apikey=" +
          key;
  var url = Uri.parse(endpoint);

  final response = await http.get(url);
  // print(jsonDecode(response.body));
  return jsonDecode(response.body);
}

Future newsSearchExample() async {
  String endpoint =
      "https://gnews.io/api/v4/search?q=example&lang=en&apikey=" + key;
  var url = Uri.parse(endpoint);

  final response = await http.get(url);
  return jsonDecode(response.body);
}

Future newsSearch(String query) async {
  String endpoint =
      "https://gnews.io/api/v4/search?q=" + query + "&lang=en&apikey=" + key;
  var url = Uri.parse(endpoint);

  final response = await http.get(url);
  return jsonDecode(response.body);
}
