import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({super.key, required this.btnText, required this.icon});

  final String btnText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.orangeAccent,
        child: Icon(icon),
      ),
      title: Text(btnText, style: TextStyle(fontSize: 16, color: Colors.black)),
    );
  }
}
