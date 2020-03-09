import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_test_app/Widgets/item_tile.dart';
import 'package:empty_test_app/add_item.dart';
import 'package:empty_test_app/firestore_provider.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  ItemListState createState() => ItemListState();
}

class ItemListState extends State<ItemList> {
  FirestoreProvider _provider = new FirestoreProvider();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => presentAddSheet(),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, top: 30, right: 20),
        child: _renderItems(),
      ),
    );
  }

  void presentAddSheet() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddItem(),
          fullscreenDialog: true,
        ));
  }

/*
  Widget _itemList() {
    if (item != null) {
      return StreamBuilder(
          stream: item,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data.documents[index].data["item"]
                          .toString()),
                      subtitle: Text(snapshot
                          .data.documents[index].data["price"]
                          .toString()),
                    );
                  });
            } else {
              return null;
            }
          });
    } else {
      return Text("No items");
    }
  }
*/
  // List<Widget> getDocs() async {
  //   List<Widget> tiles = List<Widget>();

  //   var documents = await _provider.docs;

  //   documents.forEach((doc) async* {
  //     var itemList = await doc.items;
  //     itemList.map((itemPrice) {
  //       var tile = ListTile(
  //         title: Text(itemPrice.itemName),
  //         subtitle: Text(itemPrice.itemPrice.toString()),
  //       );
  //       tiles.add(tile);
  //     });

  //     // getItemsList(doc);
  //   });

  //   return tiles;
  // }

  // Future<List<Widget>> getItemsList(Document doc) async {
  //   List<Widget> tiles = List<Widget>();
  //   var itemList = await doc.items;
  //   itemList.map((itemPrice) {
  //     var tile = ListTile(
  //       title: Text(itemPrice.itemName),
  //       subtitle: Text(itemPrice.itemPrice.toString()),
  //     );
  //     tiles.add(tile);
  //   });

  //   return tiles;
  // }

  Widget _renderItems() {
    return StreamBuilder<QuerySnapshot>(
        stream: _provider.items,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("No data ...");
          } else {
            return buildList(snapshot);
          }
        });
  }

  ListView buildList(AsyncSnapshot<QuerySnapshot> snapshot) {
    List<DocumentSnapshot> documents = snapshot.data.documents;

    return ListView.separated(
        separatorBuilder: (_, int index) => Divider(),
        itemCount: documents.length,
        itemBuilder: (context, index) {
          var document = documents[index];
          var iName = document.data["name"].toString();
          var iPrice = document.data["price"].toString();
          var documentId = document.documentID;
          return ItemTile(documentId, iName, iPrice);
        });
  }
}

/*
class HeaderRowListView extends StatelessWidget {
  final List<int> _listData = List<int>.generate(100, (i) => i);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Header Row Example'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: _listData.map((i) {
          return i % 10 == 0
              ? Container(
                  color: Colors.grey.withOpacity(.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("Header",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("Feb 26th, 2019",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black45,
                          )),
                    ],
                  ),
                  padding: EdgeInsets.all(10.0),
                )
              : ListTile(
                  title: Text("Item $i"),
                );
        }).toList(),
      ),
    );
  }
}
*/
