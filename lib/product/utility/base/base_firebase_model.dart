import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IdModel {
  String? id;
}

abstract class BaseFirebaseModel<T> {
  T fromJson(Map<String, dynamic> json);

  T fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final value = snapshot.data();
    // fixme
    value?.addEntries([MapEntry('id', snapshot.id)]);
    return fromJson(value ?? Map());
  }
}
