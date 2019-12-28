import 'package:flutter/material.dart';
import 'package:simple_todo/helper/db_helper.dart';
import 'package:simple_todo/model/category.dart';

class AddCategory extends StatelessWidget {
  TextEditingController categoryName = new TextEditingController();
  TextEditingController categoryMemo = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                  autofocus: true, controller: categoryName, decoration: InputDecoration(hintText: 'Category Name..')),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(controller: categoryMemo, decoration: InputDecoration(hintText: 'Category Memo..')),
            ),
            RaisedButton(
                key: null,
                onPressed: () {
                  Category category = Category(
                      id: null, categoryName: categoryName.text, categoryMemo: categoryMemo.text, totalCnt: 0, completeCnt: 0);

                  DBHelper.db.createCategory(category);
                  Navigator.pop(context, true);
                },
                child: Text(
                  "Create!",
                ))
          ]),
    );
  }

}
