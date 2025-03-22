import 'package:flutter/material.dart';
import 'package:myapp/Model/profile_model.dart';
import 'package:myapp/chat-ui/CreateGroup.dart';
import 'package:myapp/custom-ui/ButtonCard.dart';
import 'package:myapp/custom-ui/profile_card.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  List<ProfileModel> profiles = [
    ProfileModel(id: 1, name: "Student M. Name", status: "P"),
    ProfileModel(id: 2, name: "Devaa 2", status: "P"),
    ProfileModel(id: 3, name: "Rama 3", status: "P"),
    ProfileModel(id: 4, name: "Sham 4", status: "P"),
    ProfileModel(id: 5, name: "John 5", status: "P"),
    ProfileModel(id: 6, name: "Avdr 3", status: "P"),
    ProfileModel(id: 7, name: "ERddc 34", status: "P"),
    ProfileModel(id: 8, name: "Devcd 11", status: "P"),
    ProfileModel(
      id: 9,
      name: "StudentlongName MiddleName  LastNamedow",
      status: "P",
    ),
    ProfileModel(id: 10, name: "John 2", status: "P"),
    ProfileModel(id: 11, name: "John 3", status: "P"),
    ProfileModel(id: 12, name: "John 4", status: "P"),
    ProfileModel(id: 13, name: "John 5", status: "P"),
    ProfileModel(id: 14, name: "Avdr 3", status: "P"),
    ProfileModel(id: 15, name: "ERddc 34", status: "P"),
    ProfileModel(id: 16, name: "Devcd 11", status: "P"),
  ];
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
            CircleAvatar(child: Text('2 B')),
          ],
        ),

        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PT Connect",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Total 60 items", style: TextStyle(fontSize: 15)),
          ],
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 120,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: profiles.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateGroup()),
                      );
                    },
                    child: ButtonCard(
                      btnText: "Add New Group",
                      icon: Icons.group,
                    ),
                  );
                }
                if (index == 1) {
                  return ButtonCard(
                    btnText: "Add new contact",
                    icon: Icons.person_add,
                  );
                }
                return ProfileCard(profile: profiles[index - 2]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
