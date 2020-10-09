import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/screens/edit_item_screen.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key key,
    @required this.index,
    @required this.title,
    @required this.dateTime,
    @required this.itemId,
  }) : super(key: key);

  final String itemId;
  final int index;
  final String title;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => Get.toNamed(
            EditItemScreen.routeName,
            arguments: itemId,
          ),
          subtitle: Text('${DateFormat.yMMMMEEEEd().format(dateTime)}'),
          leading: CircleAvatar(
            backgroundColor: Get.theme.primaryColor,
            child: Text(
              '${index + 1}',
              overflow: TextOverflow.ellipsis,
              style:const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            title,
            style:const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
