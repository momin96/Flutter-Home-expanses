import 'package:empty_test_app/item_price.dart';
import 'package:flutter/material.dart';
import 'package:empty_test_app/firestore_provider.dart';

class AddItem extends StatefulWidget {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();

  String itemName;
  String itemPrice;
  String documentId;

  AddItem() {
    this.itemPrice = null;
    this.itemName = null;
    this.documentId = null;
  }

  AddItem.item(String documentId, String itemName, String itemPrice) {
    this.itemName = itemName;
    this.itemPrice = itemPrice;
    this.documentId = documentId;
    itemNameController.text = itemName;
    itemPriceController.text = itemPrice;
  }

  AddItemState createState() => AddItemState();
}

class AddItemState extends State<AddItem> {
  FirestoreProvider _provider = new FirestoreProvider();

  var _categories = [
    "Home",
    "Kitchen",
    "Bike",
    "Food",
    "Train/Bus",
    "Cab/Auto",
    "Vegitable",
    "Fruits"
  ];

  String _selectedCategory;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => add(),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: widget.itemNameController,
              decoration: InputDecoration(hintText: "Enter items name"),
            ),
            TextField(
              controller: widget.itemPriceController,
              decoration: InputDecoration(
                hintText: "Enter items price",
              ),
            ),
            DropdownButton(
              hint: Text("Select Item Category"),
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem(
                  child: Text(category),
                  value: category,
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void add() {
    String name = widget.itemNameController.text;
    int price = int.parse(widget.itemPriceController.text);
    var itemPrice =
        ItemPrice(widget.documentId, name, price, _selectedCategory);
    _provider.addItemInDB(itemPrice);
    widget.itemNameController.text = "";
    widget.itemPriceController.text = "";

    setState(() {
      _selectedCategory = null;
    });
    Navigator.pop(context);
  }
}
