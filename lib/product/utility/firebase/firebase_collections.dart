import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  news,
  version,
  tag,
  recomended,
  category;

  CollectionReference get referance =>
      FirebaseFirestore.instance.collection(name);
}
