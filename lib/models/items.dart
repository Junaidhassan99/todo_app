import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoDataBaseUtilities {
  static const dataBaseName = 'todo.db';
  static const tableName = 'items_table';

  static const title = 'title';
  static const dateTime = 'dateTime';
  static const stringId = 'stringId';
  static const description = 'description';
}

class Item {
  //stringId is created using DateTime.now() hence being used for orderBy in the query
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
  Database database;

  var _itemsData = [
   
  ].obs;

  Future<void> loadData() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, TodoDataBaseUtilities.dataBaseName);

    // open the database
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE ${TodoDataBaseUtilities.tableName} (${TodoDataBaseUtilities.stringId} TEXT PRIMARY KEY, ${TodoDataBaseUtilities.title} TEXT, ${TodoDataBaseUtilities.dateTime} TEXT, ${TodoDataBaseUtilities.description} TEXT)',
        );
      },
    );

    final queryData = await database.query(
      TodoDataBaseUtilities.tableName,
      columns: [
        TodoDataBaseUtilities.stringId,
        TodoDataBaseUtilities.title,
        TodoDataBaseUtilities.dateTime,
        TodoDataBaseUtilities.description,
      ],
      orderBy:  TodoDataBaseUtilities.stringId,
    );
    
    _itemsData.value = queryData.map((e) {
    
      return Item(
        stringId: e[TodoDataBaseUtilities.stringId],
        title: e[TodoDataBaseUtilities.title],
        dateTime: DateTime.parse(e[TodoDataBaseUtilities.dateTime]),
        description: e[TodoDataBaseUtilities.description],
      );
    }).toList().reversed.toList();
   
  }

  List<dynamic> get getItems {
    return _itemsData;
  }

  Map<String, dynamic> construstItemMap(Item item) {
    return {
      TodoDataBaseUtilities.stringId: item.stringId,
      TodoDataBaseUtilities.title: item.title,
      TodoDataBaseUtilities.dateTime: item.dateTime.toIso8601String(),
      TodoDataBaseUtilities.description: item.description,
    };
  }

  void addItem(Item item) async{
    _itemsData.insert(0, item);
    await database.insert(
      TodoDataBaseUtilities.tableName,
      construstItemMap(item),
    );
  }

  void removeItem(String itemId) async {
    _itemsData.removeWhere((item) => item.stringId == itemId);

    await database.delete(
      TodoDataBaseUtilities.tableName,
      where: '${TodoDataBaseUtilities.stringId}=?',
      whereArgs: [
        itemId,
      ],
    );
  }

  Item getItemById(String itemId) {
    return _itemsData.firstWhere((item) => item.stringId == itemId);
  }

  void updateItem(Item mItem) async {
    int itemIndex =
        _itemsData.indexWhere((item) => item.stringId == mItem.stringId);
    _itemsData[itemIndex] = mItem;

    await database.update(
      TodoDataBaseUtilities.tableName,
      construstItemMap(mItem),
      where: '${TodoDataBaseUtilities.stringId}=?',
      whereArgs: [
        mItem.stringId,
      ],
    );
  }

  void undoDelete(int index, Item item) async{
    _itemsData.insert(index, item);
    await database.insert(
      TodoDataBaseUtilities.tableName,
      construstItemMap(item),
    );
    
  }
}
