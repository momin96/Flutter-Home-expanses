import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_test_app/Widgets/item_tile.dart';
import 'package:empty_test_app/firestore_provider.dart';
import 'package:flutter/material.dart';

class ExtendedItemList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExtendedItemListState();
  }
}

class _ExtendedItemListState extends State<ExtendedItemList> {
  FirestoreProvider _provider = new FirestoreProvider();

  List<Widget> childrenList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Extended Item list"),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.all(20),
      child: StreamBuilder<QuerySnapshot>(
        stream: _provider.items,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("No Data...");
          } else {
            initChildren(snapshot);
            return ListView(children: childrenList);
          }
        },
      ),
    );
  }

  // Widget createChildren(AsyncSnapshot<QuerySnapshot> snapshot) {
  //   List<DocumentSnapshot> documents = snapshot.data.documents;

  //   var children = <HeaderItemList>[];
  //   var list = documents.map((document) {
  //     HeaderItemList(document);
  //   }).toList();

  //   return ListView(children: children);
  // }

  void initChildren(AsyncSnapshot<QuerySnapshot> snapshot) async {
    List<DocumentSnapshot> documents = snapshot.data.documents;

    final list = documents.map((document) {
      HeaderItemList(document);
    }).toList();

    setState(() {
      print("object in setstate");
      print(list);
      childrenList = list;
    });
  }
}

class HeaderItemList extends StatefulWidget {
  final DocumentSnapshot _documentSnapshot;
  HeaderItemList(this._documentSnapshot);

  @override
  State<StatefulWidget> createState() {
    return _HeaderItemListState();
  }
}

class _HeaderItemListState extends State<HeaderItemList> {
  FirestoreProvider _provider = new FirestoreProvider();

  @override
  Widget build(BuildContext context) {
    if (widget._documentSnapshot == null) {
      return null;
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _provider.getDocuments(widget._documentSnapshot),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return null;
        }

        var documents = snapshot.data.documents;

        return ListView.separated(
            itemBuilder: (context, index) {
              var document = documents[index];
              var iName = document.data["item"].toString();
              var iPrice = document.data["price"].toString();
              return ItemTile(document.documentID, iName, iPrice);
            },
            separatorBuilder: (_, index) => Divider(),
            itemCount: documents.length);
      },
    );
  }
}
