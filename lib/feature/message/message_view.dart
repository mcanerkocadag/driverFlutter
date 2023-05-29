import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/message/message_provider.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:flutter_application_firebase/product/models/chat/UserChat.dart';
import 'package:flutter_application_firebase/product/utility/base/generic_search_delegate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../product/models/chat/Chat.dart';

final messageProvider =
    StateNotifierProvider<MessageNotifier, MessageState>((ref) {
  return MessageNotifier();
});

class MessageView extends ConsumerStatefulWidget {
  const MessageView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageViewState();
}

class _MessageViewState extends ConsumerState<MessageView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(messageProvider.notifier).fetchChats("mcaner.kocadag@gmail.com");
  }

  final dummyImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterdenem.appspot.com/o/istockphoto-1344327532-170667a.jpg?alt=media&token=e31d4ea4-ce18-4a35-8659-3c919dc35404";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
          child: ListView(
            children: [
              const TitleWidget(
                title: "Messages",
                size: 34,
              ),
              const SizedBox(height: 21),
              _SearchWidget(
                chats: ref.watch(messageProvider).chats,
              ),
              const SizedBox(height: 14),
              const TitleWidget(title: "Messages", size: 18),
              _messageListView(
                dummyImageUrl: dummyImageUrl,
                chats: ref.watch(messageProvider).chats,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({super.key, required this.chats});

  final List<Chat>? chats;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        final result = await showSearch(
          context: context,
          delegate: GenericSearchDelegate(
            items: chats ?? [],
            searchLabel: (item) => item.lastMessage.toString(),
            buildResult: (item) => ListTile(title: Text('')),
            buildSuggestion: (context, item) => ListTile(title: Text('')),
          ),
        );
        //ref.read(homeProvider.notifier).updateSelectedTag(result);
      },
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search_outlined),
        hintText: "Search",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE8E6EA)),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({required this.title, required this.size, super.key});

  final String title;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _messageListView extends StatelessWidget {
  const _messageListView({
    super.key,
    required this.dummyImageUrl,
    required this.chats,
  });

  final String dummyImageUrl;
  final List<Chat>? chats;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: chats?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 64,
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: ClipOval(
                child: Image.network(
              height: 48,
              width: 48,
              dummyImageUrl,
              fit: BoxFit.cover,
            )),
            title: Text(
              chats?[index].subscribers?.last ?? '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              chats?[index].lastMessage ?? '',
              style: TextStyle(
                color: ColorConstants.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "23 Min",
                  style: TextStyle(
                    color: Color(0xffADAFBB),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Badge(
                  label: Text("2"),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 58.0),
          child: Divider(
            height: 2,
            color: Color(0xffE8E6EA),
          ),
        );
      },
    );
  }
}
