import 'dart:io';
import 'package:mes_envies/models/Article.dart';
import 'package:mes_envies/models/ItemList.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseClient {
  // 2 Tables
  // Table 1 => Liste de mes envies. Ex: Liste informatique, Liste de noel (Nom et Iditifiant)
  // Table 2 => Liste des objects, U ps5, un nouveau clavier. (Nom, prix, magasin, l'id de la liste, leur propre id)
  //  INTEGER, TEXT, REAL
  // INTEGER PRIMARY KEY pour id unique
  // TEXT NOT NULL

  // Acceder à la database
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await createDatabase();
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  onCreate(Database database, int version) async {
    // Table 1
    await database.execute('''
      CREATE TABLE IF NOT EXISTS list (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL
      )
''');
    // Table 2
    await database.execute('''
    CREATE TABLE IF NOT EXISTS article (
      id INTEGER PRIMARY KEY,
      name TEXT NOTE NULL,
      price REAL,
      shop TEXT,
      image TEXT,
      list INTEGER
    )
''');
  }

  // Obtenir des donnée
  Future<List<ItemList>> allItems() async {
    Database db = await database;
    const query = "SELECT * FROM list";
    List<Map<String, dynamic>> mapList = await db.rawQuery(query);

    return mapList.map((map) => ItemList.fromMap(map)).toList();
  }

  // Ajouter des données
  Future<bool> addItemList(String text) async {
    Database db = await database;
    await db.insert('list', {"name": text});
    return true;
  }

  Future<bool> upset(Article article) async {
    return true;
  }

  // Supprimer liste
  Future<bool> removeItem(ItemList itemList) async {
    Database db = await database;
    await db.delete('list', where: 'id=?', whereArgs: [itemList.id]);
    // Supprimer

    return true;
  }

//   // Suppression des données
//   Future<bool> deleteAllItemList() async {
//     Database db = await database;
//     const query = "DELETE FROM list";
//     await db.rawDelete(query);
//     return true;
//   }
//   //Suppression de table
//   onTableChanged() async {
//     Database db = await database;
//     const deleteQuery = "DROP TABLE IF EXISTS list";
//     db.execute(deleteQuery);
//     db.execute('''
//       CREATE TABLE IF NOT EXISTS list (
//       id INTEGER PRIMARY KEY,
//       name TEXT NOT NULL
//       );
//       ''');
//   }
}
