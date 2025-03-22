import 'package:flutter/material.dart';
import 'package:myapp/Model/chat_model.dart';
import 'package:myapp/chat-ui/contact.dart';
import 'package:myapp/custom-ui/chat_card.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chats = [
    ChatModel(
      name: 'User1',
      icon: "assets/person.svg",
      isGroup: false,
      currentMessage: "hi from test",
      time: "08:00",
    ),
    ChatModel(
      name: 'Grpup 2 test',
      icon: "assets/groups.svg",
      isGroup: true,
      currentMessage: "group chats",
      time: "10:00",
    ),
    ChatModel(
      name: 'My name',
      icon: "assets/person.svg",
      isGroup: false,
      currentMessage: "hi from test",
      time: "08:00",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) => ChatCard(chat: chats[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("fab clicked");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactPage()),
          );
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
