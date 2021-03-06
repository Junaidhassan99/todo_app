import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/edit_item_screen.dart';
import 'package:todo_app/screens/home_screen.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ToDo List',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        accentColor: Colors.red,
      ),
      home: HomeScreen(),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        EditItemScreen.routeName: (_) => EditItemScreen(),
      },
    );
  }
}
