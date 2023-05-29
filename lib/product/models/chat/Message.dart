// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../utility/base/base_firebase_model.dart';

class Message with EquatableMixin, IdModel, BaseFirebaseModel<Message> {
  String? chatId;
  String? message;
  String? senderId;
  String? receiverId;
  String? date;
  @override
  final String? id;

  Message({
    this.chatId,
    this.message,
    this.senderId,
    this.receiverId,
    this.date,
    this.id,
  });

  @override
  List<Object?> get props {
    return [id];
  }

  Message copyWith({
    String? chatId,
    String? message,
    String? senderId,
    String? receiverId,
    String? date,
    String? id,
  }) {
    return Message(
      chatId: chatId ?? this.chatId,
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      date: date ?? this.date,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chatId': chatId,
      'message': message,
      'senderId': senderId,
      'receiverId': receiverId,
      'date': date,
    };
  }

  @override
  Message fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String?,
      chatId: json['chatId'] != null ? json['chatId'] as String : null,
      message: json['message'] != null ? json['message'] as String : null,
      senderId: json['senderId'] != null ? json['senderId'] as String : null,
      receiverId:
          json['receiverId'] != null ? json['receiverId'] as String : null,
      date: json['date'] != null ? json['date'] as String : null,
    );
  }
}
