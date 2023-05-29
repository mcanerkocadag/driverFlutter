import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/choosePhotos/choose_photos.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCreationPage extends StatefulWidget {
  @override
  _ProfileCreationPageState createState() => _ProfileCreationPageState();
}

class _ProfileCreationPageState extends State<ProfileCreationPage> {
  final _firstNameController = TextEditingController();
  final _surnameController = TextEditingController();
  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  File? _imageFile;
  final userProvider =
      Provider<UserProfile>((ref) => throw UnimplementedError());
  final container = ProviderContainer();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.0),
              const Text(
                'Create Profile',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40.0),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundImage:
                        _imageFile != null ? FileImage(_imageFile!) : null,
                    child: _imageFile == null
                        ? Icon(Icons.add_a_photo, size: 80.0)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isMaleSelected = true;
                          isFemaleSelected = false;
                        });
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (isMaleSelected) {
                              return ColorConstants.genderMale;
                            } else {
                              return ColorConstants.lightGray;
                            }
                          },
                        ),
                      ),
                      icon: ImageIcon(AssetImage('assets/icons/ic_male.png')),
                      label: Text('Male'),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isMaleSelected = false;
                          isFemaleSelected = true;
                        });
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (isFemaleSelected) {
                              return ColorConstants.genderFemale;
                            } else {
                              return ColorConstants.lightGray;
                            }
                          },
                        ),
                      ),
                      icon: ImageIcon(AssetImage('assets/icons/ic_female.png')),
                      label: Text('Female'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 46.0),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: ColorConstants.appRed),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.grayPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _surnameController,
                decoration: const InputDecoration(
                  labelText: 'Surname',
                  labelStyle: TextStyle(color: ColorConstants.appRed),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorConstants.grayPrimary),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
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
                      var user = UserProfile(
                          profilePhoto: "sd",
                          firstName: "Akif",
                          lastName: "demirezen");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChoosePhotosView(
                                  user: user,
                                )),
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
    );
  }
}

class UserProfile {
  final String profilePhoto;
  final String firstName;
  final String lastName;

  UserProfile(
      {required this.profilePhoto,
      required this.firstName,
      required this.lastName});
}
