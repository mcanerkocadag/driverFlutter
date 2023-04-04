import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/home/home_provider.dart';
import 'package:flutter_application_firebase/feature/home_create/home_logic.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:flutter_application_firebase/product/models/category.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_utility.dart';
import 'package:kartal/kartal.dart';

/**
 * 1:28:59
 */
class HomeCreateView extends StatefulWidget {
  const HomeCreateView({super.key});

  @override
  State<HomeCreateView> createState() => _HomeCreateViewState();
}

class _HomeCreateViewState extends State<HomeCreateView> with Loading {
  HomeLogic? homeLogic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeLogic = HomeLogic();
    fetchCategory();
  }

  Future<void> fetchCategory() async {
    await homeLogic?.fetchAllCategoryList();
    // final response = homeLogic?.categoryList;
    setState(() {
      //   _categoryList = response;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homeLogic?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new item"),
        centerTitle: false,
        actions: [
          if (isLoading)
            const Center(
                child: CircularProgressIndicator(color: ColorConstants.white))
        ],
      ),
      body: Form(
        key: homeLogic?.formKey,
        onChanged: () {
          homeLogic?.checkValidateAndSave((value) {
            (value) {
              setState(() {});
            };
          });
        },
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 8,
              ),
              _HomeCategoryDropDown(
                categoryList: homeLogic?.categoryList,
                onSelected: (value) {
                  homeLogic?.updateCategory(value);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: homeLogic?.editingController,
                validator: (value) {
                  return value.isNullOrEmpty ? 'Not empty' : null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () async {
                  await homeLogic?.pickAndImage(
                    (value) {},
                  );
                  setState(() {});
                },
                child: SizedBox(
                  height: context.dynamicHeight(.2),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorConstants.grayPrimary)),
                    child: homeLogic?.selectedImage != null
                        ? Image.memory(homeLogic!.selectedImage!)
                        : const Icon(Icons.add_a_photo_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20)),
                  onPressed: !(homeLogic?.isValidateAllForm ?? false)
                      ? null
                      : () async {
                          changeLoading();
                          var response = await homeLogic?.save();
                          changeLoading();
                          if (response ?? false && context.mounted) {
                            await context.pop<bool>(true);
                          }
                        },
                  icon: Icon(Icons.send),
                  label: Text("Save"))
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeCategoryDropDown extends StatelessWidget {
  const _HomeCategoryDropDown(
      {required this.categoryList, required this.onSelected});
  final List<Category>? categoryList;
  final ValueSetter<Category?> onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Category>(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      items: categoryList?.map((e) {
        return DropdownMenuItem<Category>(
          value: e,
          child: Text(e.name ?? ''),
        );
      }).toList(),
      hint: Text("Category select"),
      onChanged: (value) {
        onSelected.call(value);
      },
    );
  }
}

mixin Loading on State<HomeCreateView> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
