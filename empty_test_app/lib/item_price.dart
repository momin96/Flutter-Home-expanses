class ItemPrice {
  final String itemName;
  final int itemPrice;
  final String itemId;
  ItemPrice(this.itemId, this.itemName, this.itemPrice);

  Map<String, dynamic> convertItemPrice() {
    return {"name": itemName, "price": itemPrice};
  }

  // ItemPrice create(DocumentSnapshot document) {
  //   var iId = document.documentID;
  //   var iName = document.data["name"].toString();
  //   var iPrice = document.data["price"].toString();
  //   var price = int.parse(iPrice);
  //   return ItemPrice(iId, iName, price);
  // }
}

class Document {
  final String documentId;
  final Future<List<ItemPrice>> items;
  Document(this.documentId, this.items);
}
