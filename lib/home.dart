import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_news/helper/data.dart';
import 'package:smart_news/helper/news.dart';
import 'package:smart_news/model/Category_model.dart';
import 'package:smart_news/model/article_model.dart';
import 'package:smart_news/views/article_view.dart';
import 'package:smart_news/views/category_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    News newsClass= News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Smart",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold)),
            Text("News",style: TextStyle(color: Colors.amber,fontSize: 24,fontWeight: FontWeight.bold)),
          ],
        )
      ),
      body: _loading?
      Center(
        child: Container(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        ),
      )
      : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context,index){
                      return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  }
                  ),

            ),
            Container(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: articles.length,
                  itemBuilder: (context, index){
                    return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url);
                  }),
            )
          ],
        ),
      ),
    ),

    );
  }
}
 class CategoryTile extends StatelessWidget {
   String imageUrl,categoryName;
   CategoryTile({required this.imageUrl,required this.categoryName});

   @override
   Widget build(BuildContext context) {
     return GestureDetector(
       onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryView(category: categoryName)));
       },
         child: Container(
          margin: EdgeInsets.only(right: 16),
           child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
             ),
           ),
           Container(
             alignment: Alignment.center,
             height: 60,
             width: 120,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(6),
               color: Colors.black26
             ),
             child: Text(
               categoryName,style:
               TextStyle(
                 color: Colors.white,
                 fontSize: 14,
                 fontWeight: FontWeight.w500
               ),
             ),
           ),
         ],
       ),
     )
     );
   }
 }

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile({required this.imageUrl, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleView(BlogUrl: url)));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            imageUrl.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl, errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: Center(child: Icon(Icons.broken_image, size: 50)),
                );
              }),
            )
                : Container(
              height: 150,
              color: Colors.grey[300],
              child: Center(child: Icon(Icons.broken_image, size: 50)),
            ),
            SizedBox(height: 8),
            Text(
              title.isNotEmpty ? title : "No Title Available",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              desc.isNotEmpty ? desc : "No Description Available",
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}


