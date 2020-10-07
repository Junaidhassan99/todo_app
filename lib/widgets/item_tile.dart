import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key key,
    @required this.index,
    @required this.title,
    @required this.dateTime,
  }) : super(key: key);

  final int index;
  final String title;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          subtitle: Text('${DateFormat.yMMMMEEEEd().format(dateTime)}'),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              '${index + 1}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
