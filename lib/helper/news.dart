import 'dart:convert';

import 'package:smart_news/model/article_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];

  Future<void> getNews() async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=19ea0ff207194df1ae6c39da606553ab";

    final uri = Uri.parse(url);

    
    var response = await http.get(uri);
    var jsonData = jsonDecode(response.body);


    print("API Response: ${jsonData}");  // ✅ Debugging Step

    if(jsonData['status'] == 'ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage']
          );
          
          news.add(articleModel);

        }
      });

      print("Fetched ${news.length} articles."); // ✅ Debugging Step
    }

  }
}

class CategoryNewsClass{
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=19ea0ff207194df1ae6c39da606553ab";


    final uri = Uri.parse(url);

    var response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    print(jsonData);

    if(jsonData['status'] == 'ok'){

      jsonData["articles"].forEach((element){
        if(element["urlToImage"] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage']
          );

          news.add(articleModel);

        }
      });
    }



  }
}