class Article {
  int id;
  String name;
  int list;
  double? price;
  String? shop;
  String? image;

  Article(
    this.id,
    this.name,
    this.list,
    this.price,
    this.shop,
    this.image,
  );

  Article.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        list = map["list"],
        price = map["price"],
        shop = map["shop"],
        image = map["image"];
}
