import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OwnMessage extends StatelessWidget {
  const OwnMessage({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 20,
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Text(message, style: TextStyle(fontSize: 16), softWrap: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showImages() {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.grey.shade400),
          child: Image.network(
            "https://schoolbyte.co.in/assets/images/dashboard.png",
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
