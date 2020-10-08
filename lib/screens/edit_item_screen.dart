import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/widgets/date_picker.dart';

class EditItemScreen extends StatefulWidget {
  static const routeName = '/edit-item-screen';

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  final defaultPadding = Get.width * 0.03;

  DateTime _dateResponse = DateTime.now();

  void setDateResponseCallBack(DateTime data) {
    _dateResponse = data;
    print('call back: $_dateResponse');
  }

  @override
  void initState() {
    titleFocusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                focusNode: titleFocusNode,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Title'),
                onFieldSubmitted: (value) =>
                    descriptionFocusNode.requestFocus(),
                textInputAction: TextInputAction.next,
              ),
              DatePicker(
                setDateResponse: setDateResponseCallBack,
              ),
              TextFormField(
                focusNode: descriptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
