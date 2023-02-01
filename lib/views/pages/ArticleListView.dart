import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mes_envies/models/Article.dart';
import 'package:mes_envies/models/ItemList.dart';
import 'package:mes_envies/services/DatabaseClient.dart';
import 'package:mes_envies/views/Widgets/CustomAppBar.dart';
import 'package:mes_envies/views/pages/AddArticleView.dart';
import 'package:mes_envies/views/tiles/ArticleTile.dart';

class ArticleListView extends StatefulWidget {
  ItemList itemList;

  ArticleListView({super.key, required this.itemList});
  @override
  ArticleListViewState createState() => ArticleListViewState();
}

class ArticleListViewState extends State<ArticleListView> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleString: widget.itemList.name,
          buttonTitle: "+",
          callback: addNewItem),
      body: Center(
        child: ListView.builder(
          itemBuilder: ((context, index) =>
              ArticleTile(article: articles[index])),
          itemCount: articles.length,
        ),
      ),
    );
  }

  getArticles() async {
    DatabaseClient().articlesFromId(widget.itemList.id).then((value) {
      setState(() {
        articles = value;
      });
    });
  }

  addNewItem() {
    final next = AddArticleView(listId: widget.itemList.id);
    final materialPageRoute = MaterialPageRoute(builder: ((context) => next));
    Navigator.of(context)
        .push(materialPageRoute)
        .then((value) => getArticles());
  }
}
