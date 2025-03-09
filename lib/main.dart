import 'package:flutter/material.dart';
import 'package:myapp/otp.dart';
import 'package:myapp/phone.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'SchoolByte',
      debugShowCheckedModeBanner: false,
      initialRoute: 'phone',
      routes: {'phone': (context) => Phone(), 'otp': (context) => Otp()},
    ),
  );
}
