import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/home_screen.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        accentColor: Colors.red,
      ),
      home: HomeScreen(),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
      },
    );
  }
}
