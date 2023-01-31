import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mes_envies/models/ItemList.dart';
import 'package:mes_envies/views/Widgets/CustomAppBar.dart';
import 'package:mes_envies/views/pages/AddArticleView.dart';

class ArticleListView extends StatefulWidget {
  ItemList itemList;

  ArticleListView({super.key, required this.itemList});
  @override
  ArticleListViewState createState() => ArticleListViewState();
}

class ArticleListViewState extends State<ArticleListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          titleString: widget.itemList.name,
          buttonTitle: "+",
          callback: addNewItem),
      body: Center(
        child: Text("Item ${widget.itemList.id}"),
      ),
    );
  }

  addNewItem() {
    final next = AddArticleView(listId: widget.itemList.id);
    final materialPageRoute = MaterialPageRoute(builder: ((context) => next));
    Navigator.of(context).push(materialPageRoute).then((value) => null);
  }
}
