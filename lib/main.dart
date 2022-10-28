import 'package:flutter/material.dart';
import 'package:wallpaper_app/helper/color_helper.dart';
import 'package:wallpaper_app/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpaper App',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: Home(),
    );
  }
}
