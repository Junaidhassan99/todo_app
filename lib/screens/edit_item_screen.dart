import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/models/items.dart';

import 'package:todo_app/widgets/date_picker.dart';

enum EditItemScreenMode {
  Edit,
  Add,
}

class EditItemScreen extends StatefulWidget {
  static const routeName = '/edit-item-screen';

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  final _defaultPadding = Get.width * 0.03;
  DateTime _dateResponse;
  Item _item;
  EditItemScreenMode editItemScreenMode;

  final _itemsController = Get.find<Items>();

  void setDateResponseCallBack(DateTime data) {
    _dateResponse = data;
    print('call back: $_dateResponse');
  }

  void _saveForm() {
    if (_formKey.currentState.validate() && _dateResponse != null) {
      _formKey.currentState.save();
      _item = Item(
        dateTime: _dateResponse,
        stringId: _item.stringId,
        title: _item.title,
        description: _item.description,
      );
      if (editItemScreenMode == EditItemScreenMode.Add) {
        _itemsController.addItem(_item);
      } else {
        _itemsController.updateItem(_item);
      }

      Get.back();
    }
    print(
      'check: ${_item.title},${_item.description},${_item.stringId},${_item.dateTime}',
    );
  }

  void _determineEditModeAndInitializeItem() {
    _dateResponse = DateTime.now();
    final String itemId = Get.arguments as String;
    print(itemId);
    if (itemId == null) {
      editItemScreenMode = EditItemScreenMode.Add;

      _item = Item(
        dateTime: _dateResponse,
        stringId: _dateResponse.toString(),
        title: '',
        description: '',
      );
    } else {
      editItemScreenMode = EditItemScreenMode.Edit;

      _item = _itemsController.getItemById(itemId);

      print('Work: ${_item.dateTime}');
    }
  }

  @override
  void initState() {
    super.initState();
    _determineEditModeAndInitializeItem();
    _titleFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editItemScreenMode == EditItemScreenMode.Add
              ? 'Add Item'
              : 'Edit Item',
        ),
        actions: [
          FlatButton(
            onPressed: _saveForm,
            child: Text('Save'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(_defaultPadding),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _item.title,
                focusNode: _titleFocusNode,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(labelText: 'Title'),
                onFieldSubmitted: (value) =>
                    _descriptionFocusNode.requestFocus(),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title cannot be empty';
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  _item = Item(
                    dateTime: _item.dateTime,
                    stringId: _item.stringId,
                    title: newValue,
                    description: _item.description,
                  );
                },
              ),
              DatePicker(
                setDateResponse: setDateResponseCallBack,
                setDateData: _item.dateTime,
              ),
              TextFormField(
                initialValue: _item.description,
                focusNode: _descriptionFocusNode,
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
                onSaved: (newValue) {
                  _item = Item(
                    dateTime: _item.dateTime,
                    stringId: _item.stringId,
                    title: _item.title,
                    description: newValue,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
