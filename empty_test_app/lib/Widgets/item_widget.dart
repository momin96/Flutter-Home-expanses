import 'package:empty_test_app/item_price.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  final ItemPrice item;
  ItemWidget(this.item);
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  // ItemPrice item;
  // _ItemWidgetState(this.item);
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: <Widget>[
          Flexible(child: Text(widget.item.itemName)),
          Flexible(child: Text(widget.item.itemPrice.toString()))
        ],
      ),
    );
  }
}
