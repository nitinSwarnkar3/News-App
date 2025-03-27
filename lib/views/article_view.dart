
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String BlogUrl;
  ArticleView({required this.BlogUrl});


  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            title:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Smart",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold)),
                Text("News",style: TextStyle(color: Colors.amber,fontSize: 24,fontWeight: FontWeight.bold)),
              ],
            ),
          actions: [
            Opacity(
                opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),),
          ],
        ),
      body: Container(
        child: WebView(
          initialUrl: widget.BlogUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
