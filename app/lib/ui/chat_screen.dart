import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:helping_nexus/api/messages_service.dart';
import 'package:helping_nexus/models/message.dart';
import 'package:helping_nexus/ui/matches_screen.dart';
import 'package:intl/intl.dart';


class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final MessagesService _messagesService = MessagesService();

  List listMessages = [];

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      _messagesService.createMessage(
        message: content,
        fromUserId: '65ed8fd2fed34ccf99555e40',
        toUserId: '65ed9009fed34ccf99555e41',
        wishId: '65ed9027fed34ccf99555e42',
      );
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }


  @override
  Widget build(BuildContext context) {
    final chatName = ref.watch(currentChatNameProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('$chatName'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed('matches');
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/screens_background_grey.png'),
            fit: BoxFit.cover,
          ),
        ),
        child:SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Expanded(child: buildListMessage()),
                buildMessageInput(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMessageInput() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Flexible(
              child: TextField(
                focusNode: focusNode,
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                controller: textEditingController,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, 0);
                },
              )),
          Container(
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: () {
                onSendMessage(textEditingController.text, 0);
              },
              icon: const Icon(Icons.send_rounded),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(int index, Message message) {
    if (message.fromUserId == ref.read(currentChatIdProvider.notifier).state) {
      // right side (my message)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              messageBubble(
                chatContent: message.message,
                color: Colors.blue,
                textColor: Colors.white,
                margin: const EdgeInsets.only(right: 10),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
                right: 50,
                top: 6,
                bottom: 8),
            child: Text(
              DateFormat.yMd().add_jm().format(message.createdAt),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      );
    }
    else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              messageBubble(
                color: Colors.blueGrey,
                textColor: Colors.white,
                chatContent: message.message,
                margin: const EdgeInsets.only(left: 10),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
                left: 50,
                top: 6,
                bottom: 8),
            child: Text(
              DateFormat.yMd().add_jm().format(message.createdAt),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontStyle: FontStyle.italic),
            ),
          )
        ],
      );
    }
  }

  Widget buildListMessage() {
    return FutureBuilder(
        future: _messagesService.getMessages(userId: '65ed8fd2fed34ccf99555e40', wishId: '65ed9027fed34ccf99555e42'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            listMessages = snapshot.data!;
            if (listMessages.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data?.length,
                  reverse: true,
                  controller: scrollController,
                  itemBuilder: (context, index) =>
                      buildItem(index, snapshot.data?[index]));
            } else {
              return const Center(
                child: Text('No messages...'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          }
        });
  }

  Widget messageBubble(
      {required String chatContent,
        required EdgeInsetsGeometry? margin,
        Color? color,
        Color? textColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: margin,
      width: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        chatContent,
        style: TextStyle(fontSize: 16, color: textColor),
      ),
    );
  }

}
