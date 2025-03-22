import 'package:flutter/material.dart';
import 'package:myapp/Model/profile_model.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key, required this.profile});
  final ProfileModel profile;

  final Color bgColor = const Color.fromARGB(255, 233, 189, 123);
  final Color textColor = Colors.black;

  final Color circleBgColor = Colors.green;
  final Color circleTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5, top: 2),
      child: Column(
        children: [
          Stack(
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
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 10,
                      child: Icon(Icons.cancel, color: Colors.white, size: 18),
                    ),
                  )
                  : Container(),
            ],
          ),
          SizedBox(height: 2),
          Text(profile.name, style: TextStyle(fontSize: 12), softWrap: true),
        ],
      ),
    );
  }
}
