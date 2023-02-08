import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageUtil {
  File? imageFile;

  ///引数で与えられたパスへ画像をアップロード
  void imgUpload(String imgPath, File image) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref(imgPath).putFile(image);
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///引数で与えられたパスの画像URLを返す
  Future<String> imgDownloadPath(String imgPath) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference imageRef = storage.ref(imgPath);
    String imgUrl = await imageRef.getDownloadURL();
    debugPrint(imgUrl);
    return imgUrl;
  }
}

class NetworkImageBuilder extends FutureBuilder {
  NetworkImageBuilder(Future<String> item)
      : item = item,
        super(
        future: item,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return CachedNetworkImage(
              imageUrl: snapshot.data,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      );
  final Future<String> item;
}