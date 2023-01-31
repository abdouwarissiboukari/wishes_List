import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mes_envies/models/ItemList.dart';
import 'package:mes_envies/services/DatabaseClient.dart';
import 'package:mes_envies/views/Widgets/AddDialog.dart';
import 'package:mes_envies/views/Widgets/CustomAppBar.dart';
import 'package:mes_envies/views/pages/ArticleListView.dart';
import 'package:mes_envies/views/tiles/ItemListTile.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<ItemList> items = [];

  @override
  void initState() {
    super.initState();
    getItemList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleString: "Ma liste de souhait",
        buttonTitle: "Ajouter",
        callback: addItemList,
      ),
      body: ListView.separated(
          itemBuilder: ((context, index) => ItemListTile(
              itemList: items[index],
              onPressed: onListPressed,
              onDelete: onDeleteItem)),
          separatorBuilder: ((context, index) => const Divider()),
          itemCount: items.length),
    );
  }

  getItemList() async {
    final fromDb = await DatabaseClient().allItems();
    setState(() {
      items = fromDb;
    });
  }

  addItemList() async {
    await showDialog(
        context: context,
        builder: ((context) {
          TextEditingController controller = TextEditingController();
          return AddDialog(
              controller: controller,
              onAdded: (() {
                handleClosedDialog();
                if (controller.text.isEmpty) return;
                DatabaseClient()
                    .addItemList(controller.text)
                    .then((success) => getItemList());
              }),
              onCancel: handleClosedDialog);
        }));
  }

  handleClosedDialog() {
    Navigator.pop(context);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  onListPressed(ItemList itemList) {
    final next = ArticleListView(itemList: itemList);
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: ((context) {
      return next;
    }));

    Navigator.of(context).push(materialPageRoute);
  }

  onDeleteItem(ItemList itemList) {
    DatabaseClient().removeItem(itemList).then((sucess) => getItemList());
  }
}
