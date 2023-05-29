import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/createProfile/create_profile.dart';
import 'package:flutter_application_firebase/feature/moviePages/movie_pages.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: null,
    );
  }
}

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieSearchPage()),
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
