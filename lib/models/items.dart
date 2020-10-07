import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Item {
  final String title;
  final DateTime dateTime;
  final String stringId;
  final String description;
  Item({
    @required this.dateTime,
    @required this.stringId,
    @required this.title,
    this.description,
  });
}

class Items extends GetxController {
  var _itemsData = [
    Item(
      dateTime: DateTime.now(),
      stringId: '1',
      title: 'Eat',
    ),
    Item(
      dateTime: DateTime.now(),
      stringId: '2',
      title: 'Movie',
    ),
    Item(
      dateTime: DateTime.now(),
      stringId: '3',
      title: 'Sleep',
    ),
    Item(
      dateTime: DateTime.now(),
      stringId: '4',
      title: 'Work',
    ),
    Item(
      dateTime: DateTime.now(),
      stringId: '4',
      title: 'Work',
    ),
    Item(
      dateTime: DateTime.now(),
      stringId: '4',
      title: 'Work',
    ),
  ].obs;

  List<Item> get getItems {
    return _itemsData;
  }
}
