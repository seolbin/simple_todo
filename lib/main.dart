import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo/helper/db_helper.dart';
import 'package:simple_todo/model/category.dart';
import 'package:simple_todo/pageAddCategory.dart';
import 'package:simple_todo/pageTodos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
          title: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
          body1: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Hind',
          ),
        ),
      ),
//      home: MultiProvider(
//          providers: [],
//          child: TodoMain()),
      home: TodoMain(),
    );

    return app;
  }
}

class TodoMain extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TodoMain> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple TODO'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Category>>(
        future: DBHelper.db.getAllCategory(),
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data
                .map((category) =>
                ListTile(
                  title: Text('${category.categoryName} (${category.categoryMemo})'),
                  subtitle: Text('${category.completeCnt} / ${category.totalCnt}'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TodoPage(category)));
                  },
                  onLongPress: (){
                    // do something else
                    print('long press! : ${category.id}');
                  },
                )
            ).toList(),
          );
        },
      ),
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
        label: Text('Add a category'),
        onPressed: () {
//          floatingText.change();
          print('add click');
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategory()));
        },
      ),
    );
  }
}
