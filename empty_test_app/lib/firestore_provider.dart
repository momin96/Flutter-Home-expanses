import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_test_app/Utils/utilities.dart';
import 'package:empty_test_app/item_price.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

  // Future<List<Document>> get docs => getDocuments();

  // Future<QuerySnapshot> getExapnsesList() {
  //   return _firestore.collection("Expanses").getDocuments();
  // }

  Stream<QuerySnapshot> get items => _getAllItems();

  Stream<QuerySnapshot> _getAllItems() {
    var snapshot = _firestore.collection("Expanses").snapshots();
    return snapshot;
  }

  Stream<QuerySnapshot> getDocuments(DocumentSnapshot documentSnapshot) {
    String documentId = documentSnapshot.documentID;
    var snapshot = _firestore
        .collection("Expanses")
        .document(documentId)
        .collection("Today")
        .snapshots();
    return snapshot;
  }

  Future<void> addItemInDB(ItemPrice itemPrice) {
    Map<String, dynamic> data = itemPrice.convertItemPrice();

    var documentId = itemPrice.itemId;
    if (documentId == null) {
      documentId = Utilities.getCurrentEpochMilliSecond().toString();
    }
    print(documentId);
    //var epochDate = Utilities.getCurrentEpochDate().toString();

    return _firestore.collection("Expanses").document(documentId).setData(data);
    // .document(epochDate)
    // .collection("Today")
  }

  // Future<List<DocumentSnapshot>> getAllDocument() {
  //   return getExapnsesList().then((querySnap) {
  //     return querySnap.documents;
  //   }).catchError((onError) {
  //     print(Error);
  //   });
  // }

  // Future<List<Document>> getDocuments() async {
  //   var querySnapshot = await getExapnsesList();

  //   List<Document> docs = List<Document>();
  //   querySnapshot.documents.forEach((documentSnapshot) {
  //     var docId = documentSnapshot.documentID;
  //     var items = getItems(docId);
  //     var doc = Document(docId, items);
  //     print("$docId $items");
  //     docs.add(doc);
  //   });

  //   print("in getDocuments");
  //   print(docs.length);

  //   return docs;
  // }

  // Future<List<ItemPrice>> getItems(String docId) async {
  //   var querySnapshot = await _firestore
  //       .collection("Expanses")
  //       .document(docId)
  //       .collection("Today")
  //       .getDocuments();

  //   List<ItemPrice> docsSnapshot = List<ItemPrice>();
  //   querySnapshot.documents.forEach((snapshot) {
  //     var docId = snapshot.documentID;
  //     var data = snapshot.data;
  //     var itemName = data["item"];
  //     var itemPrice = data["price"];
  //     var item = ItemPrice(docId, itemName, itemPrice);
  //     docsSnapshot.add(item);
  //   });

  //   return docsSnapshot;
  // }

  // Stream<DocumentSnapshot> getItem(String parentId, String childId) {
  //   return _firestore
  //       .collection("Expanses")
  //       .document(parentId)
  //       .collection("Today")
  //       .document(childId)
  //       .snapshots();
  // }
}
