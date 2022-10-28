import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;


import '../data/data.dart';
import '../models/wallpaper_model.dart';
import '../widgets/widgets.dart';

class Categories extends StatefulWidget {
  // const Categories({super.key});

  
  String? categoryName;

  Categories({required this.categoryName});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
   List<WallpaperModel> wallpapers = [];


  getSearchWallpaper(String query) async {
    var response = await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$query&per_page=10&page=1'),
        headers: {
          'Authorization': apiKey,
        });

    // print(response.body);

    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData['photos'].forEach((element) {
      // print(element);

      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSearchWallpaper(widget.categoryName!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            
            SizedBox(
              height: 16,
            ),
            wallpaperList(wallpapers: wallpapers, context: context),
          ]),
        ),
      ),
    );
  }
}