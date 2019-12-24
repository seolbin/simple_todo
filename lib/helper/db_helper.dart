import 'dart:io';
import 'package:path_provider/path_provider.dart';
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
    String path = join(documentsDirectory.path, 'superAwesomeDb.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE $categoryTableName 
          id INTEGER PRIMARY KEY, 
          category TEXT, 
          categoryName TEXT,
          totalCnt INTEGER, 
          completeCnt INTEGER
        ''');
        await db.execute('''
        CREATE TABLE $todoTableName 
          id INTEGER PRIMARY KEY, 
          category INTEGER, 
          todoName TEXT, 
          todoMemo TEXT,
          complete_cnt BIT
        ''');
      },
    );
  }

  // CREATE
  createData(Todo todo) async {
    final db = await database;
    var res = await db.insert(todoTableName, todo.toJson()); return res;
  }

  // READ
 getTodo(int id) async {
    final db = await database;
    var res = await db.query(todoTableName, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Todo.fromJson(res.first) : Null;
  }

  // READ ALL DATA
 getAllTodos() async {
    final db = await database;
    var res = await db.query(todoTableName);
    List<Todo> list = res.isNotEmpty ? res.map((c) => Todo.fromJson(c)).toList() : [];
    return list;
  }

  // Update Todo
  updateTodo(Todo todo) async {
    final db = await database;
    var res = await db.update(todoTableName, todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
    return res;
  }
  // Delete Todo
  deleteTodo(int id) async {
    final db = await database;
    db.delete(todoTableName, where: 'id = ?', whereArgs: [id]);
  }
  // Delete All
 deleteAllTodos() async {
    final db = await database;
    db.rawDelete('Delete * from $todoTableName');
  }

}
