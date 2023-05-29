// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_application_firebase/product/utility/base/base_firebase_model.dart';

class UserChat with EquatableMixin, IdModel, BaseFirebaseModel<UserChat> {
  String? userId;
  List<String>? chats;
  @override
  final String? id;

  UserChat({
    this.userId,
    this.chats,
    this.id,
  });

  @override
  List<Object?> get props => [id];

  UserChat copyWith({
    String? userId,
    List<String>? chats,
    String? id,
  }) {
    return UserChat(
      userId: userId ?? this.userId,
      chats: chats ?? this.chats,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'chats': chats,
    };
  }

  @override
  UserChat fromJson(Map<String, dynamic> json) {
    return UserChat(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      chats:
          (json['chats'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }
}
