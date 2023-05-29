// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_firebase/product/models/chat/Chat.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_utility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageNotifier extends StateNotifier<MessageState> with FirebaseUtility {
  MessageNotifier() : super(MessageState());

  Future<void> fetchChats(String userName) async {
    var a = await FirebaseCollections.chats.referance
        .where("subscribers", arrayContains: userName)
        .get();
    List<Chat> chats = [];
    a.docs.forEach((element) {
      var chat = Chat()
          .fromFirebase(element as DocumentSnapshot<Map<String, dynamic>>);
      chats.add(chat);
    });
    state = MessageState().copyWith(chats: chats);
  }
}

class MessageState extends Equatable {
  MessageState({this.chats});

  final List<Chat>? chats;

  @override
  // TODO: implement props
  List<Object> get props => [chats ?? []];

  MessageState copyWith({
    List<Chat>? chats,
  }) {
    return MessageState(
      chats: chats ?? this.chats,
    );
  }
}
