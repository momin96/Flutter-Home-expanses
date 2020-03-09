import 'package:empty_test_app/item_price.dart';
import 'package:flutter/material.dart';

class DocumentWidget extends StatefulWidget {
  final Document _document;
  DocumentWidget(this._document);
  _DocumentWidgetState createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentWidget> {
  // Document _document;
  // _DocumentWidgetState(this._document);
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[Text(widget._document.documentId)],
      ),
    );
  }
}
