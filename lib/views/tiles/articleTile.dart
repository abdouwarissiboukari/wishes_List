import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mes_envies/models/Article.dart';

class ArticleTile extends StatelessWidget {
  Article article;

  ArticleTile({super.key, required this.article});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 7.5,
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.name,
            style: const TextStyle(fontSize: 25),
          ),
          (article.image != null)
              ? Container(
                  padding: const EdgeInsets.all(5),
                  child: Image.file(
                    File(article.image!),
                    height: size.height / 3,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
          Text("Prix : ${article.price} €"),
          Text("Magasin : ${article.shop}"),
        ],
      ),
    );
  }
}
