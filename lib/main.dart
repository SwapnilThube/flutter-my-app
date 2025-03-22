import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myapp/chat-ui/homescreen.dart';
import 'package:myapp/chat-ui/individual_chat.dart';
import 'package:myapp/features_screens/camera_screen.dart';
import 'package:myapp/screens/otp.dart';
import 'package:myapp/screens/phone.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(
    MaterialApp(
      title: 'SchoolByte',
      debugShowCheckedModeBanner: false,
      initialRoute: 'homescreen',
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: Colors.green,
        appBarTheme: AppBarTheme(color: Colors.orangeAccent),
        secondaryHeaderColor: Colors.redAccent,
      ),
      routes: {
        'phone': (context) => Phone(),
        'otp': (context) => Otp(),
        "homescreen": (context) => HomeScreen(),
        "individual": (context) => IndividualChat(),
      },
    ),
  );
}
