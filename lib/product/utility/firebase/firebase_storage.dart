import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void _uploadImagesToStorage(List<AssetImage> assetImages) {
  var storage = FirebaseStorage.instance;

  List<String> listOfImage = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg'
  ];

  listOfImage.forEach((img) async {
    String imageName =
        img.substring(img.lastIndexOf("/") + 1, img.lastIndexOf("."));

    String path = img.substring(img.indexOf("/") + 1, img.lastIndexOf("/"));

    final Directory systemTempDir = Directory.systemTemp;
    final byteData = await rootBundle.load(img);
    final file = File('${systemTempDir.path}/$imageName.jpg');

    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    TaskSnapshot taskSnapshot =
        await storage.ref('$path/$imageName').putFile(file);
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  });
}

Future<String> storeImage(String uid, File userImage) async {
  final reference =
      FirebaseStorage.instance.ref().child('user-image').child("$uid.png");
  await reference.putFile(userImage);
  final imageUrl = await reference.getDownloadURL();
  return imageUrl;
}
