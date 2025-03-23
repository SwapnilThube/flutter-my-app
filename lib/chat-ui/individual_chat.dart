import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/custom-ui/own_message.dart';
import 'package:myapp/features_screens/camera_screen.dart';
import 'package:myapp/features_screens/camera_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class IndividualChat extends StatefulWidget {
  const IndividualChat({super.key});

  @override
  State<IndividualChat> createState() => _IndividualChartState();
}

class _IndividualChartState extends State<IndividualChat> {
  bool show = false;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _txtController = TextEditingController();
  ScrollController _scrolController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();

  io.Socket socket = io.io(
    'http://192.168.1.9:5000',
    io.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .disableAutoConnect() // disable auto-connection
        .build(),
  );

  List<String> messges = [
    "By following these steps, you can incorporate image downloading and saving functionality into your Flutter applications, opening up",
    "In this article, we have learnr applications, opening up",
    "opening up",
    "you can incorporate image downloading and saving functionality into your Flutter applications",
    "By following these steps, you can incorporate image downloading and saving functionality into your Flutter applications, opening up",
    "In this article, we have learnr applications, opening up",
    "opening up",
    "you can incorporate image downloading and saving functionality into your Flutter applications",
    "By following these steps, you can incorporate image downloading and saving functionality into your Flutter applications, opening up",
    "In this article, we have learnr applications, opening up",
    "opening up",
    "you can incorporate image downloading and saving functionality into your Flutter applications",
  ];

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });

    connect();
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      _scrolController.animateTo(
        _scrolController.position.maxScrollExtent + 170,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  connect() {
    socket.connect();
    socket.onConnect(
      (data) => {print("Connected"), socket.emit('test', 'message from app')},
    );

    socket.on("fromServer", (data) {
      setState(() {
        print("Data from server" + data);
        messges.add(data);
        _scrolController.animateTo(
          _scrolController.position.maxScrollExtent + 170,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leadingWidth: 80,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, size: 20),
            ),
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey,
              child: SvgPicture.asset("assets/person.svg"),
            ),
          ],
        ),
        title: InkWell(
          onTap: () {
            print("Title clicked");
          },
          child: titleWidget(),
        ),

        actions: [
          iconButton(Icons.video_call_outlined, () {}),
          iconButton(Icons.call_outlined, () {}),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: "View contact",
                  child: Text("View contact"),
                ),
                PopupMenuItem(
                  value: "Media, links & docs",
                  child: Text("Media, links & docs"),
                ),
                PopupMenuItem(value: "Search", child: Text("Search")),
              ];
            },
          ),
        ],
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Column(
            children: [
              Expanded(
                // height: MediaQuery.of(context).size.height - 170,
                child: ListView.builder(
                  controller: _scrolController,
                  itemCount: messges.length,
                  itemBuilder: (context, index) {
                    return OwnMessage(message: messges[index]);
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 55,
                            child: Card(
                              margin: EdgeInsets.only(
                                right: 2,
                                left: 2,
                                bottom: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: TextFormField(
                                controller: _txtController,
                                focusNode: _focusNode,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.multiline,
                                maxLines: 5,
                                minLines: 1,
                                onTapOutside: (PointerEvent event) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type a message",
                                  prefixIcon: IconButton(
                                    onPressed: () {
                                      _focusNode.unfocus();
                                      _focusNode.canRequestFocus = false;
                                      setState(() {
                                        show = !show;
                                      });
                                    },
                                    icon: Icon(Icons.emoji_emotions),
                                  ),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors.transparent,
                                            builder: (builder) => bottomSheet(),
                                          );
                                        },
                                        icon: Icon(Icons.attachment),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (builder) => CameraScreen(),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.camera_alt),
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.all(5),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: IconButton(
                                onPressed: () {
                                  _txtController.text;
                                  socket.emit('test', _txtController.text);

                                  setState(() {
                                    messges.add(_txtController.text);
                                  });
                                  _txtController.text = '';

                                  _scrolController.animateTo(
                                    _scrolController.position.maxScrollExtent,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeOut,
                                  );
                                },
                                icon: Icon(Icons.send, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      handleEmojiPicker(show),
                    ],
                  ),
                ),
              ),
            ],
          ),

          onWillPop: () {
            if (show) {
              setState(() {
                show = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconWithName(
                    Icons.insert_drive_file,
                    "Dcoument",
                    Colors.orangeAccent,
                    Colors.white,
                  ),
                  SizedBox(width: 20),
                  iconWithName(
                    Icons.camera_alt,
                    "Camera",
                    Colors.orangeAccent,
                    Colors.white,
                  ),
                  SizedBox(width: 20),
                  iconWithName(
                    Icons.insert_photo,
                    "Gallery",
                    Colors.orangeAccent,
                    Colors.white,
                    callback: () async {
                      // List<XFile>? file = await _imagePicker.pickMultipleMedia(
                      //   imageQuality: 50,
                      //   limit: 2,
                      // );

                      //if (file != null) ViewImage(file[0].path);
                    },
                  ),
                ],
              ),
              SizedBox(width: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconWithName(
                    Icons.headphones,
                    "Audio",
                    Colors.orangeAccent,
                    Colors.white,
                  ),
                  SizedBox(width: 20),
                  iconWithName(
                    Icons.location_pin,
                    "Location",
                    Colors.orangeAccent,
                    Colors.white,
                  ),
                  SizedBox(width: 20),
                  iconWithName(
                    Icons.person,
                    "Conatct",
                    Colors.orangeAccent,
                    Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void ViewImage(String path) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (buillder) => CameraView(imagePath: path, mediaType: "image"),
      ),
    );
  }

  Widget iconWithName(
    IconData icon,
    String name,
    Color color,
    Color iconColor, {
    Function? callback,
  }) {
    return InkWell(
      onTap: () {
        if (callback != null) callback();
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(icon, color: iconColor, size: 30),
          ),
          SizedBox(height: 5),
          Text(name),
        ],
      ),
    );
  }

  IconButton iconButton(IconData icon, onPressed) {
    return IconButton(onPressed: onPressed, icon: Icon(icon));
  }

  Widget handleEmojiPicker(bool isShow) {
    if (isShow) {
      return emojiPicker();
    }
    return Container();
  }

  Widget emojiPicker() {
    return EmojiPicker(
      config: Config(
        height: 256,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax:
              28 *
              (foundation.defaultTargetPlatform == TargetPlatform.iOS
                  ? 1.20
                  : 1.0),
        ),
        viewOrderConfig: const ViewOrderConfig(
          top: EmojiPickerItem.categoryBar,
          middle: EmojiPickerItem.emojiView,
          bottom: EmojiPickerItem.searchBar,
        ),
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: const CategoryViewConfig(),
        bottomActionBarConfig: const BottomActionBarConfig(),
        searchViewConfig: const SearchViewConfig(),
      ),
      onEmojiSelected: (emoji, category) {
        _txtController.text = _txtController.text + category.emoji;
      },
    );
  }
}

Widget titleWidget() {
  return Container(
    margin: EdgeInsets.all(2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Selected chat header",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Last seen at 8:15 AM', style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}
