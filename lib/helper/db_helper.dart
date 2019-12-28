import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:simple_todo/model/category.dart';
import 'package:simple_todo/model/todo.dart';
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
    String path = join(documentsDirectory.path, 'simpleTodo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $categoryTableName 
        (
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          categoryName TEXT, 
          categoryMemo TEXT,
          totalCnt INTEGER, 
          completeCnt INTEGER
        )''');
    await db.execute('''
        CREATE TABLE $todoTableName
        ( 
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          category INTEGER, 
          todoName TEXT, 
          todoMemo TEXT,
          complete BIT
        )''');
  }

  // CREATE Category
  createCategory(Category category) async {
    final db = await database;
    var res = await db.insert(categoryTableName, category.toJson());
    return res;
  }

  Future<List<Category>> getAllCategory() async {
    final db = await database;
    var res = await db.query(categoryTableName);
    List<Category> list = res.isNotEmpty ? res.map((c) => Category.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Todo>> getCategoryItems(int categoryId) async {
    final db = await database;
    var res = await db.query(todoTableName, where: 'category = ?', whereArgs: [categoryId]);
    List<Todo> list = res.isNotEmpty ? res.map((c) => Todo.fromJson(c)).toList() : [];
    return list;
  }
}
