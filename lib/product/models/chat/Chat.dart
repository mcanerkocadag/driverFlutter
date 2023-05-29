// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../utility/base/base_firebase_model.dart';

class Chat with EquatableMixin, IdModel, BaseFirebaseModel<Chat> {
  String? title;
  String? lastMessage;
  List<String>? subscribers;
  @override
  final String? id;

  Chat({
    this.title,
    this.lastMessage,
    this.subscribers,
    this.id,
  });

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lastMessage': lastMessage,
      'subscribers': subscribers,
    };
  }

  @override
  Chat fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'] as String?,
      title: json['title'] as String?,
      lastMessage: json['lastMessage'] as String?,
      subscribers: (json['subscribers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  Chat copyWith({
    String? title,
    String? lastMessage,
    List<String>? subscribers,
    String? id,
  }) {
    return Chat(
      title: title ?? this.title,
      lastMessage: lastMessage ?? this.lastMessage,
      subscribers: subscribers ?? this.subscribers,
      id: id ?? this.id,
    );
  }
}
