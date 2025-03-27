import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_news/helper/news.dart';
import 'package:smart_news/model/article_model.dart';
import 'package:smart_news/home.dart';

class CategoryView extends StatefulWidget {
  final String category;
  const CategoryView({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {

    print("Fetching news for category: ${widget.category}");  // ✅ Debugging Step

    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    setState(() {
      articles = newsClass.news;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category} News"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator(color: Colors.amber))
          : ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return BlogTile(
            imageUrl: articles[index].urlToImage,
            title: articles[index].title,
            desc: articles[index].description,
            url: articles[index].url,
          );
        },
      ),
    );
  }
}


