import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_app/models/items.dart';
import 'package:todo_app/screens/edit_item_screen.dart';
import 'package:todo_app/widgets/item_tile.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _itemsController = Get.put(Items());

  Widget _dismissBackground(AlignmentGeometry alignmentGeometry) {
    return Container(
      margin: const EdgeInsets.only(
        //horizontal: 10,vertical: 8,
        right: 10,
      ),
      color: Colors.red,
      alignment: alignmentGeometry,
      child: const Icon(
        Icons.delete,
        size: 40,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: FutureBuilder(
        future: _itemsController.loadData(),
        builder: (_, snapshot) {
          if (!(snapshot.connectionState == ConnectionState.done)) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Obx(
              () {
                if (_itemsController.getItems.isEmpty) {
                  return Center(
                    child: Text('Nothing to show. Add something!'),
                  );
                }
                return ListView.builder(
                  itemCount: _itemsController.getItems.length,
                  itemBuilder: (_, index) {
                    final itemsIndexData = _itemsController.getItems[index];
                    return Dismissible(
                      secondaryBackground:
                          _dismissBackground(Alignment.centerRight),
                      background: _dismissBackground(Alignment.centerLeft),
                      onDismissed: (_) {
                        final Item undoItem = _itemsController
                            .getItemById(itemsIndexData.stringId);

                        _itemsController.removeItem(itemsIndexData.stringId);

                        _scaffoldKey.currentState.hideCurrentSnackBar();
                        final snackBar = SnackBar(
                          backgroundColor: Colors.black,
                          content: const Text(
                            'Undo Delete',
                            style: const TextStyle(color: Colors.white),
                          ),
                          action: SnackBarAction(
                            textColor: Colors.blue,
                            label: 'Undo',
                            onPressed: () => _itemsController.undoDelete(
                              index,
                              undoItem,
                            ),
                          ),
                        );
                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      },
                      key: Key(itemsIndexData.stringId),
                      child: ItemTile(
                        itemId: itemsIndexData.stringId,
                        index: index,
                        title: itemsIndexData.title,
                        dateTime: itemsIndexData.dateTime,
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Get.toNamed(EditItemScreen.routeName),
      ),
    );
  }
}
