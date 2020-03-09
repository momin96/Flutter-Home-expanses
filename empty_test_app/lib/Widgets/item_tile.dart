import 'package:empty_test_app/add_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemTile extends StatelessWidget {
  final String itemId;
  final String itemName;
  final String itemPrice;

  String dateString() {
    var date = new DateTime.fromMillisecondsSinceEpoch(int.parse(itemId));
    var formatter = new DateFormat('dd MMM, hh:mm a');
    var str = formatter.format(date);
    return str;
  }

  // ItemTile(this.itemName, this.itemPrice);
  ItemTile(this.itemId, this.itemName, this.itemPrice);

  @override
  Widget build(BuildContext context) {
    var str = "Rs. " + itemPrice.toString();

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItem.item(itemId, itemName, itemPrice),
              fullscreenDialog: true,
            ));
      },
      child: ListTile(
        title: Text(dateString()),
        subtitle: Text(itemName),
        trailing: Text(str),
      ),
    );
  }
}
