import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../data/data.dart';
import '../models/wallpaper_model.dart';
import '../widgets/widgets.dart';

class Search extends StatefulWidget {
  // const Search({super.key});

  String? searchQuery;

  Search({required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<WallpaperModel> wallpapers = [];

  TextEditingController searchController = TextEditingController();

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
    getSearchWallpaper(widget.searchQuery!);
    searchController.text = widget.searchQuery!;
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
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search wallpaper',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () => getSearchWallpaper(searchController.text),
                      child: Icon(Icons.search)),
                ],
              ),
            ),
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
