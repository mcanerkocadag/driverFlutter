import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  news,
  version;

  CollectionReference get referance =>
      FirebaseFirestore.instance.collection(name);
}
