import 'package:flutter/material.dart';
import 'package:myapp/Model/profile_model.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.profile});
  final ProfileModel profile;

  final Color bgColor = const Color.fromARGB(255, 233, 189, 123);
  final Color textColor = Colors.black;

  final Color circleBgColor = Colors.green;
  final Color circleTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: bgColor,
          leading: Container(
            width: 52,
            height: 42,
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: circleBgColor,
                  child: Text(
                    "${profile.id}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: circleTextColor,
                    ),
                  ),
                ),
                profile.select
                    ? Positioned(
                      bottom: 2,
                      right: 6,
                      child: CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 10,
                        child: Icon(Icons.check, color: Colors.white, size: 18),
                      ),
                    )
                    : Container(),
              ],
            ),
          ),
          title: Text(
            profile.name,
            style: TextStyle(fontSize: 14, color: textColor),
          ),
          trailing: CircleAvatar(
            backgroundColor: circleBgColor,
            child: Icon(Icons.arrow_forward_ios, color: circleTextColor),
          ),
        ),
        Divider(color: Colors.grey, height: 1, thickness: 1, indent: 60),
      ],
    );
  }
}
