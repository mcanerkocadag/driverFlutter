import 'package:flutter_application_firebase/product/utility/base/base_firebase_model.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_collections.dart';

mixin FirebaseUtility {
  Future<List<I>> fetchList<I extends IdModel, T extends BaseFirebaseModel<I>>(
      T data, FirebaseCollections collections) async {
    final newsCollectionReference = collections.referance;
    final response = await newsCollectionReference.withConverter<I>(
      fromFirestore: (snapshot, options) {
        return data.fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        return {};
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      return values;
    }
    return List.empty();
  }
}
