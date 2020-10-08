import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_app/widgets/date_picker.dart';

class EditItemScreen extends StatefulWidget {
  static const routeName = '/edit-item-screen';

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final defaultPadding = Get.width * 0.03;
  DateTime _dateResponse = DateTime.now();

  void setDateResponseCallBack(DateTime data) {
    _dateResponse = data;
    print('call back: $_dateResponse');
  }

  void _saveForm() {
    if (_formKey.currentState.validate() && _dateResponse != null) {
      _formKey.currentState.save();
    }
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
            onPressed: _saveForm,
            child: Text('Save'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(defaultPadding),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                focusNode: titleFocusNode,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Title'),
                onFieldSubmitted: (value) =>
                    descriptionFocusNode.requestFocus(),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title cannot be empty';
                  } else {
                    return null;
                  }
                },
              ),
              DatePicker(
                setDateResponse: setDateResponseCallBack,
              ),
              TextFormField(
                focusNode: descriptionFocusNode,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Description cannot be empty';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
