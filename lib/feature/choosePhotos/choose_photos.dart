import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/createProfile/create_profile.dart';
import 'package:flutter_application_firebase/feature/moviePages/movie_pages.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../product/models/userprofile.dart';

class ChoosePhotosView extends StatefulWidget {
  final UserProfile user;
  ChoosePhotosView({required this.user});

  @override
  _ChoosePhotosViewState createState() => _ChoosePhotosViewState();
}

class _ChoosePhotosViewState extends State<ChoosePhotosView> {
  List<File> _images = [];

  Future<void> _selectPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  void _deletePhoto(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Widget _buildImage(int index) {
    return Stack(
      children: [
        Image.file(
          _images[index],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: () => _deletePhoto(index),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _images.isEmpty
              ? const Text(
                  'Add Your Photos',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                )
              : Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                        ),
                        itemCount: _images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildImage(index);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.appRed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                          onPressed: () {
                            /*_uploadImagesToFirebaseStorage(
                                    '3423532545', _images)
                                .then((imageUrls) {
                              print('Yüklenen Resim URL\'leri: $imageUrls');
                            }).catchError((error) {
                              print('Resim yükleme hata: $error');
                            });*/
                            _images.forEach((element) {
                              widget.user.imageList
                                  .add(AssetImage(element.path ?? ''));
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MovieSearchPage(user: widget.user)),
                            );
                          },
                          child: Text('Continue'),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 80),
        child: FloatingActionButton(
          onPressed: _selectPhoto,
          child: Icon(Icons.add),
          backgroundColor: ColorConstants.appRed,
        ),
      ),
    );
  }
}

Future<List<String>> _uploadImagesToFirebaseStorage(
    String uid, List<File> images) async {
  List<String> imageUrls = [];

  for (int i = 0; i < images.length; i++) {
    File image = images[i];

    try {
      // Resmi yüklemek için bir referans alın
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + "_$i";
      Reference reference =
          FirebaseStorage.instance.ref().child('users/$uid/$fileName');

      // Resmi yükleyin
      UploadTask uploadTask = reference.putFile(image);
      TaskSnapshot storageTaskSnapshot =
          await uploadTask.whenComplete(() => null);

      // Yükleme tamamlandığında resmin URL'sini alın
      String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();

      // Resim URL'sini listeye ekle
      imageUrls.add(imageUrl);
    } catch (e) {
      print('Resim yükleme hatası: $e');
    }
  }

  return imageUrls;
}
