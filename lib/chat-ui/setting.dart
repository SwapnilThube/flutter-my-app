import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          showDialogUI();
        },
        child: Text("Send"),
      ),
    );
  }

  Future<void> showDialogUI() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Are you sure to continue"),
                Text("Click on no to cancle"),
                Text("Yes to cin"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {}, child: Text("Ok")),
                  TextButton(onPressed: () {}, child: Text("Cancel")),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
