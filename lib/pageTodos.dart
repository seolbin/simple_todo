import 'package:flutter/material.dart';
import 'package:simple_todo/helper/db_helper.dart';
import 'package:simple_todo/model/category.dart';

class TodoPage extends StatefulWidget {
  final Category category;

  TodoPage(this.category);

  @override
  _TodoPageState createState() => _TodoPageState(this.category);
}

class _TodoPageState extends State<TodoPage> {
  Category _category;

  _TodoPageState(this._category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_category.categoryName}'),
        centerTitle: true,
      ),
      body: Container(),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: Text('Add a task'),
        onPressed: () {
//          floatingText.change();
          print('add click');
//          Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategory()));
        },
      ),
    );
  }
}
