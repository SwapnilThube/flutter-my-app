import 'package:flutter/material.dart';
import 'package:myapp/chat-ui/chaat.dart';
import 'package:myapp/chat-ui/setting.dart';
import 'package:myapp/features_screens/camera_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat app'),
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
          PopupMenuButton(
            onSelected: (value) {
              print('selected ' + value);
            },
            color: Colors.green,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(value: "New Group", child: Text("New Group")),
                PopupMenuItem(value: "Setting", child: Text("Setting")),
                PopupMenuItem(value: "Web", child: Text("Web")),
              ];
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(text: ("Chat")),
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: ("Status")),
            Tab(text: ("Setting")),
          ],
        ),
      ),

      body: TabBarView(
        controller: _controller,
        children: [ChatPage(), CameraPage(), Text("1"), Setting()],
      ),
    );
  }
}
