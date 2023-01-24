import 'dart:io';
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
      CREATE TABLE list (
      id INTAGER PRIMARY KEY,
      name TEXT NOT NULL
      )
''');
    // Table 2
    await database.execute('''
    CREATE TABLE article (
      id INTEGER PRIMARY KEY,
      name TEXT NOTE NULL,
      price REAL,
      shop TEXT,
      image TEXT,
      list INTEGER
    )
''');
  }
}
