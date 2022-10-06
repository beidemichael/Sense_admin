import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../service/database.dart';
import '../drawer.dart';
import 'package:chip_list/chip_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PublishScreen extends StatefulWidget {
  String type;
  PublishScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  final _formKey = GlobalKey<FormState>();
  final fieldTextHeadline = TextEditingController();
  final fieldTextDesctipion = TextEditingController();
  String displayName = '';
  String headline = "";
  String description = "";
  String source = "";
  File? imageFile;
  String newImage = '';
  bool loading = false;
  bool active = true;
  List<String> selected = [];
  List<String> category = [];
  List<String> categoryexample = [];
  List<Category> categoryMap = [];
  var _items;
  listToMap(List categoryList) {
    categoryMap.clear();
    for (int i = 0; i < categoryList.length; i++) {
      categoryMap.addAll({Category(id: i + 1, cat: categoryList[i])});
    }
    if (_items != null) {
      _items.clear();
    }

    _items = categoryMap
        .map((mapCategory) =>
            MultiSelectItem<Category>(mapCategory, mapCategory.cat))
        .toList();
  }

  void clearText() {
    fieldTextHeadline.clear();
    fieldTextDesctipion.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);

    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<List<UserInformation>>(context);
    if (_user.length != 0) {
      displayName = _user[0].displayName;
    }
    final newsCategory = Provider.of<List<NewsCategory>>(context);
    if (newsCategory != null && newsCategory.length != 0) {
      setState(() {
        listToMap(newsCategory[0].category);
      });
    }
    final _items = categoryMap
        .map((mapCategory) =>
            MultiSelectItem<Category>(mapCategory, mapCategory.cat))
        .toList();
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      controller: fieldTextHeadline,
                      validator: (val) => val!.length != 6
                          ? 'Code should be 6 digits long'
                          : null,
                      textAlign: TextAlign.left,
                      onChanged: (val) {
                        setState(() {
                          headline = val;
                        });
                      },
                      maxLength: 90,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: 'Headline',
                        labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400),
                        focusColor: Colors.purple[900],
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey[400]!)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.purple[400]!)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.purple[400]!)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.purple[400]!)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: TextFormField(
                      controller: fieldTextDesctipion,
                      validator: (val) => val!.length != 6
                          ? 'Code should be 6 digits long'
                          : null,
                      textAlign: TextAlign.left,
                      onChanged: (val) {
                        setState(() {
                          description = val;
                        });
                      },
                      maxLength: 500,
                      keyboardType: TextInputType.multiline,
                      maxLines: 7,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400),
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400),
                        focusColor: Colors.purple[900],
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.grey[400]!)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.purple[400]!)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.purple[400]!)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.purple[400]!)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          // color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.grey[400]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text(
                                "Image",
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 90,
                              child: imageFile != null
                                  ? Container(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(9),
                                            topRight: Radius.circular(9)),
                                        child: Image.file(
                                          imageFile!,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    )
                                  : Icon(
                                      Icons.cloud_upload,
                                      color: Colors.purple,
                                    ),
                              decoration: BoxDecoration(
                                color: Colors.purple[100],
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(9),
                                    topRight: Radius.circular(9)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          active != active;
                        });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          // color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.grey[400]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: active
                                  ? Text(
                                      "Active",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    )
                                  : Text(
                                      "Inactive",
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                            ),
                            Container(
                              height: 50,
                              width: 90,
                              child: Switch(
                                // This bool value toggles the switch.
                                value: active,
                                activeColor: Colors.purple,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    active = value;
                                  });
                                },
                              ),
                              decoration: BoxDecoration(
                                color: active
                                    ? Colors.purple[100]
                                    : Colors.grey[350],
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(9),
                                    topRight: Radius.circular(9)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: MultiSelectDialogField(
                      items: _items.toList(),
                      title: Text("Category"),
                      buttonIcon: Icon(
                        Icons.select_all_rounded,
                        color: Colors.purple,
                      ),
                      selectedColor: Colors.purple[500],
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.purple[200]!,
                          width: 1,
                        ),
                      ),
                      buttonText: Text(
                        "Select Category",
                        style: TextStyle(
                            color: Colors.purple[200],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400),
                      ),
                      onConfirm: (List<Category> results) {
                        category.clear();
                        results.forEach((e) => category.add(e.cat));
                        if (category == []) category = ['All'];
                        setState(() {
                          category = category;
                        });
                        results.clear();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: ChipList(
                      listOfChipNames: category,
                      activeBgColorList: [Colors.purple.shade100],
                      inactiveBgColorList: [Colors.purple.shade100],
                      activeTextColorList: [Colors.purple],
                      inactiveTextColorList: [Colors.purple],
                      listOfChipIndicesCurrentlySeclected: [0],
                      shouldWrap: true,
                      runSpacing: 0,
                      spacing: 0,
                      activeBorderColorList: [Colors.purple.shade100],
                      inactiveBorderColorList: [Colors.purple.shade100],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: GestureDetector(
                      onTap: () async {
                        if (imageFile != null) {
                          setState(() {
                            loading = true;
                          });
                          FirebaseStorage storage = FirebaseStorage.instance;
                          Reference ref = storage
                              .ref()
                              .child("image1" + DateTime.now().toString());
                          UploadTask uploadTask = ref.putFile(imageFile!);

                          await uploadTask.then((res) async {
                            final String downloadUrl =
                                await res.ref.getDownloadURL();
                            setState(() {
                              newImage = downloadUrl;
                            });
                          });
                        }

                        category.add('All');

                        DatabaseService().publishNews(
                          headline,
                          description,
                          newImage,
                          category,
                          displayName,
                          active,
                        );
                        category.clear();
                        setState(() {
                          loading = false;
                        });
                        clearText();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 800),
                            elevation: 5,
                            backgroundColor: Colors.purple,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'News Published',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            )));
                      },
                      child: Container(
                        height: 60,
                        child: loading
                            ? Center(
                                child: SpinKitCircle(
                                color: Colors.white,
                                size: 40.0,
                              ))
                            : Center(
                                child: Text(
                                  "Publish",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
