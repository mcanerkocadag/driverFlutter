import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollections {
  news,
  version,
  tag,
  recomended,
  category,
  users,
  userChats,
  chats,
  messages;

  CollectionReference get referance =>
      FirebaseFirestore.instance.collection(name);
}
