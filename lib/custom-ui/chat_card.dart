import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/Model/chat_model.dart';
import 'package:myapp/chat-ui/individual_chat.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.chat});

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => IndividualChat()),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: SvgPicture.asset(
                (chat.icon),
                color: Colors.black,
                height: 38,
                width: 38,
              ),
            ),
            title: Text(chat.name, style: TextStyle(fontSize: 20)),
            subtitle: const Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(width: 10),
                Text("first word from..."),
              ],
            ),
            trailing: Text("18:05"),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(thickness: 1),
          ),
        ],
      ),
    );
  }
}
