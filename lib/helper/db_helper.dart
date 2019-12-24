import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String categoryTableName = 'sbcategory';
final String todoTableName = 'sbtodo';

class DBHelper {
  DBHelper._();

  static final DBHelper db = DBHelper._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'superAwesomeDb.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE $categoryTableName 
          id INTEGER PRIMARY KEY, 
          category TEXT, 
          category_name TEXT,
          total_cnt INTEGER, 
          complete_cnt INTEGER
        ''');
        await db.execute('''
        CREATE TABLE $todoTableName 
          id INTEGER PRIMARY KEY, 
          category INTEGER, 
          todo_name TEXT, 
          todo_memo TEXT,
          complete_cnt BIT
        ''');

      },
    );
  }
}
