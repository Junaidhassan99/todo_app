import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_app/models/items.dart';
import 'package:todo_app/screens/edit_item_screen.dart';
import 'package:todo_app/widgets/item_tile.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  final _itemsController = Get.put(Items());

  @override
  Widget build(BuildContext context) {
    //final itemsData = itemsController.getItems;
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _itemsController.getItems.length,
          itemBuilder: (_, index) {
            final itemsIndexData = _itemsController.getItems[index];
            return Dismissible(
              onDismissed: (_) =>
                  _itemsController.removeItem(itemsIndexData.stringId),
              key: Key(itemsIndexData.stringId),
              child: ItemTile(
                itemId:itemsIndexData.stringId,
                index: index,
                title: itemsIndexData.title,
                dateTime: itemsIndexData.dateTime,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Get.toNamed(EditItemScreen.routeName),
      ),
    );
  }
}
