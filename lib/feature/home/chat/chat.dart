// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_firebase/product/models/chat/Chat.dart';
import 'package:flutter_application_firebase/product/models/chat/Message.dart';
import 'package:flutter_application_firebase/product/models/chat/User.dart';
import 'package:flutter_application_firebase/product/models/chat/UserChat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_application_firebase/product/models/news.dart';
import 'package:flutter_application_firebase/product/models/recommended.dart';
import 'package:flutter_application_firebase/product/models/tag.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_utility.dart';

class ChatNotifier extends StateNotifier<ChatsState> with FirebaseUtility {
  ChatNotifier() : super(const ChatsState());

  List<Tag>? _fullTagList = [];
  List<Tag>? get fullTagList => _fullTagList;

  Future<void> fetchRecommended() async {
    final values = await fetchList<Recommended, Recommended>(
        Recommended(), FirebaseCollections.recomended);
    state = state.copyWith(recommended: values);
  }

  Future<void> saveUser() async {
    // WriteBatch batch = FirebaseFirestore.instance.batch();

    //   CollectionReference userChatsCollection =
    //     FirebaseCollections.userChats.referance;

/**
 *  final response = await fetchList<Category, Category>(
      Category(),
      FirebaseCollections.category,
    );
 */
    //  userChatsCollection.doc("mcaner.kocadag@gmail.com");
    final response =
        await fetchList<User, User>(User(), FirebaseCollections.users);
    print(response);

    final chats =
        await fetchList<Chat, Chat>(Chat(), FirebaseCollections.chats);
    print(chats[0].subscribers?[0]);

    final messages =
        await fetchList<Message, Message>(Message(), FirebaseCollections.chats);
    print(messages[0].id);

    // CollectionReference chatsCollectionRef =
    //   firstCollectionRef.doc("2").collection("chats");

    // batch.set(firstCollectionRef.doc(), );
    // batch.set(chatsCollectionRef.doc(), );
    // batch.commit();
  }

  Future<void> sendMessage(
      String sender, String receiver, String message) async {
    final userChatId =
        await FirebaseCollections.userChats.referance.doc(sender).get();
    UserChat userChat =
        UserChat().fromJson(userChatId.data() as Map<String, dynamic>);

    var a = await FirebaseCollections.chats.referance
        .doc(userChat.chats?.first)
        .set(
          Chat(
            title: "ssss",
            lastMessage: message,
          ).toJson(),
          SetOptions(mergeFields: ["title", "lastMessage"]),
        )
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));

    await FirebaseCollections.messages.referance.add(Message(
      chatId: userChat.chats?.first,
      message: message,
      senderId: sender,
      receiverId: receiver,
      date: DateTime.now().toString(),
    ).toJson());

    // .where("subscribers", whereIn: [sender, receiver]).get();
    //  Chat().fromFirebase(a.docs);

    /**
     *  var response = await FirebaseCollections.chats.referance.add(Chat(
        title: "Örnek Chat",
        lastMessage: "message",
        subscribers: [sender, receiver]));

    final chatId = response.id;

    var messageResponse =
        await FirebaseCollections.messages.referance.add(Message(
      chatId: chatId,
      message: message,
      senderId: sender,
      receiverId: receiver,
      date: DateTime.now().millisecondsSinceEpoch.toString(),
    ));

    var userChatResponse =
        await FirebaseCollections.userChats.referance.add(UserChat(
      userId: "mcaner.kocadag@gmail.com",
      chats: [chatId],
    ));

    print("mesaj kaydedildi");
     */
  }
}

class ChatsState extends Equatable {
  const ChatsState(
      {this.tags,
      this.news,
      this.recommended,
      this.isLoading,
      this.selectedTag});

  final List<News>? news;
  final List<Tag>? tags;
  final List<Recommended>? recommended;
  final bool? isLoading;
  final Tag? selectedTag;
  @override
  // TODO: implement props
  List<Object?> get props => [tags, news, isLoading, selectedTag];

  ChatsState copyWith({
    List<News>? news,
    List<Tag>? tags,
    List<Recommended>? recommended,
    bool? isLoading,
    Tag? selectedTag,
  }) {
    return ChatsState(
      news: news ?? this.news,
      tags: tags ?? this.tags,
      recommended: recommended ?? this.recommended,
      isLoading: isLoading ?? this.isLoading,
      selectedTag: selectedTag ?? this.selectedTag,
    );
  }
}
