import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditItemScreen extends StatelessWidget {
  static const routeName = '/edit-item-screen';
  @override
  Widget build(BuildContext context) {
    final defaultPadding = Get.width * 0.03;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
        actions: [
          FlatButton(
            onPressed: null,
            child: Text('Save'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(defaultPadding),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
