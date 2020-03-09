import 'package:empty_test_app/Widgets/extended_item_list.dart';
import 'package:empty_test_app/add_item.dart';
import 'package:flutter/material.dart';
import 'package:empty_test_app/item_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manage Expanses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(), // AddItem(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ItemList();
  }
}
