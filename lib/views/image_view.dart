import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';

class ImageView extends StatefulWidget {
  // const ImageView({super.key});
  final String imageUrl;

  ImageView(this.imageUrl);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Hero(
          tag: widget.imageUrl,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: _save,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        
                      color: Color(0xff1c1b1b).withOpacity(0.8),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white54, width: 1),
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            Color(0x36ffffff),
                            Color(0x0fffffff),
                          ],
                        ),
                      ),
                      child: Column(children: [
                        Text(
                          'Set Wallpaper',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        Text(
                          'Image will be saved to gallery',
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        )
      ]),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      name: randomAlpha(10),
    );
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      Map<Permission, PermissionStatus> permissions =
          await [Permission.photos].request();
    } else {
      PermissionStatus permissions = await Permission.storage.request();
    }
  }
}
