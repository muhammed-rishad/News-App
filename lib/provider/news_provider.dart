import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:news_app/models/news.dart';
import 'package:http/http.dart' as http;
class NewsProvider extends ChangeNotifier{

  News news;
  int status=Status.IDLE;
  Articles articles;

   setArticles(Articles art){
     articles=art;
   }
   getNews() async {
     status=Status.LOADING;
     notifyListeners();
    final response = await http
        .get(Uri.parse('https://saurav.tech/NewsAPI/top-headlines/category/health/in.json'));

    if (response.statusCode == 200) {
      print('success');
      // If the server did return a 200 OK response,
      // then parse the JSON.
      news= News.fromJson(jsonDecode(response.body));
      status=Status.LOADED;
      notifyListeners();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      status=Status.ERROR;
      notifyListeners();
      throw Exception('Failed to load album');
    }
  }
}
class Status {
  static const int IDLE = 0;
  static const int LOADING = 1;
  static const int LOADED = 2;
  static const int ERROR=3;
}