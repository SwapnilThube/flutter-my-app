import 'package:flutter/material.dart';
import 'package:myapp/Model/profile_model.dart';
import 'package:myapp/custom-ui/avatar-card.dart';
import 'package:myapp/custom-ui/profile_card.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ProfileModel> profiles = [
    ProfileModel(id: 1, name: "Student M. Name", status: "P"),
    ProfileModel(id: 2, name: "LongStudentName M SurName", status: "P"),
    ProfileModel(id: 3, name: "John 3", status: "P"),
    ProfileModel(id: 4, name: "Student M. Name", status: "P"),
    ProfileModel(id: 5, name: "LongStudentName M SurName", status: "P"),
    ProfileModel(id: 6, name: "Gopal 3", status: "P"),
    ProfileModel(id: 7, name: "Ram 3", status: "P"),
    ProfileModel(id: 88, name: "Ram 88", status: "P"),
    ProfileModel(id: 100, name: "Sham 100", status: "P"),
  ];

  List<ProfileModel> selectedProfiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, size: 20),
            ),
            CircleAvatar(child: Icon(Icons.person_add)),
          ],
        ),

        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Group",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("Add students to group", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),

      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: profiles.length - 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: selectedProfiles.isNotEmpty ? 65 : 10,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      if (profiles[index - 1].select == false) {
                        setState(() {
                          profiles[index - 1].select = true;
                          selectedProfiles.add(profiles[index - 1]);
                        });
                      } else {
                        setState(() {
                          profiles[index - 1].select = false;
                          selectedProfiles.remove(profiles[index - 1]);
                        });
                      }
                    },
                    child: ProfileCard(profile: profiles[index - 1]),
                  );
                },
              ),

              selectedProfiles.isNotEmpty
                  ? Container(
                    height: 65,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: selectedProfiles.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              int profileId = selectedProfiles[index].id;

                              selectedProfiles.remove(selectedProfiles[index]);

                              int removeIndex = profiles.indexWhere(
                                (x) => x.id == profileId,
                              );

                              profiles[removeIndex].select = false;
                            });
                          },
                          child: AvatarCard(profile: selectedProfiles[index]),
                        );
                      },
                    ),
                  )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
