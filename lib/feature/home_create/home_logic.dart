import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/product/models/category.dart';
import 'package:flutter_application_firebase/product/models/news.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_utility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';

import '../../product/utility/firebase/firebase_collections.dart';

class HomeLogic with FirebaseUtility {
  final TextEditingController editingController = TextEditingController();
  Category? _category;
  List<Category>? _categoryList;
  List<Category>? get categoryList => _categoryList;
  Uint8List? _selectedImage;
  Uint8List? get selectedImage => _selectedImage;
  bool isValidateAllForm = false;
  XFile? _pickedImage = null;

  final GlobalKey<FormState> formKey = GlobalKey();

  void dispose() {
    editingController.dispose();
    _category = null;
  }

  void updateCategory(Category? category) {
    _category = category;
  }

  bool checkValidateAndSave(ValueSetter<bool>? onUpdate) {
    final value = isValidateAllForm = formKey.currentState?.validate() ?? false;
    if (value != isValidateAllForm && selectedImage != null) {
      isValidateAllForm = value;
      onUpdate?.call(value);
    }
    return value;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    _pickedImage = await picker.pickImage(source: ImageSource.gallery);
    _selectedImage = await _pickedImage?.readAsBytes();
  }

  Future<void> pickAndImage(ValueSetter<bool> onUpdate) async {
    await _pickImage();
    checkValidateAndSave(null);
    onUpdate.call(true);
  }

  Future<void> fetchAllCategoryList() async {
    final response = await fetchList<Category, Category>(
      Category(),
      FirebaseCollections.category,
    );
    _categoryList = response;
  }

  Future<bool> save() async {
    if (!checkValidateAndSave(null) == true) return false;
    final imageReference = createImageReference();
    if (imageReference == null) {
      throw Exception("Referans oluşmadı ");
    }
    if (_selectedImage == null) {
      throw Exception("Resim sorunu ");
    }

    final imageString = await _pickedImage?.readAsBytes();

//test
    String imagenConvertida = base64.encode(imageString!);
    await imageReference.putString(imagenConvertida!,
        format: PutStringFormat.base64);
    var downloadUrl = await imageReference.getDownloadURL();

    final response = await FirebaseCollections.news.referance.add(
      News(
        backgroundImage: downloadUrl,
        category: _category?.name,
        categoryId: _category?.id,
        title: editingController.text,
      ).toJson(),
    );
    return response.id.isNotNullOrNoEmpty;
  }

  Reference? createImageReference() {
    if (_pickedImage == null || (_pickedImage?.name?.isNullOrEmpty ?? true)) {
      return null;
    }
    final storageRef = FirebaseStorage.instance.ref();
    final childRef = storageRef.child(_pickedImage!.name);
    return childRef;
  }
}
