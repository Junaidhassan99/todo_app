import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo'),
        ),
        body: Center(
          child: Text('INITIATE TODO APP'),
        ),
      ),
    );
  }
}
