import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker_web/image_picker_web.dart';

class ImageUtil {
  File? imageFile;

  ///引数で与えられたパスへ画像をアップロード
  Future<void> imgUpload(String imgPath, Uint8List memory) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref(imgPath).putData(memory);
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

  /// ローカルから画像取得
  /// WEBアプとしてのみ対応
  // Future<Image?> getPictureImage() async {
  //   Image? image;
  //   image = await ImagePickerWeb.getImageAsWidget();
  //   return image;
  // }
  Future<Uint8List?> getPictureFile() async {
    // File? file;
    Uint8List? uint8list = await ImagePickerWeb.getImageAsBytes();
    // if(uint8list != null) file = File.fromRawPath(uint8list);
    return uint8list;
  }

  Future<void> deletePicture(String imgPath) async{
    final storageReference = FirebaseStorage.instance.ref();
    await storageReference.child(imgPath).delete();
  }
}

class NetworkImageBuilder extends FutureBuilder {
  NetworkImageBuilder(Future<String> item)
      : item = item,
        super(
          future: item,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
