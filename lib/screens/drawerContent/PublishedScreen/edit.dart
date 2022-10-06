import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../models/models.dart';
import '../../../service/database.dart';

class Edit extends StatefulWidget {
  News? news;
  Edit({Key? key, required this.news}) : super(key: key);

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  final fieldTextHeadline = TextEditingController();
  final fieldTextDesctipion = TextEditingController();
  String headline = "";
  String description = "";
  String source = "";
  File? imageFile;
  String newImage = '';
  bool loading = false;
  List<String> selected = [];
  List<String> category = ['All'];
  List<Category> categoryMap = [];

  void clearText() {
    fieldTextHeadline.clear();
    fieldTextDesctipion.clear();
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
    final _items = categoryMap
        .map((mapCategory) =>
            MultiSelectItem<Category>(mapCategory, mapCategory.cat))
        .toList();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Center(
            child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: MediaQuery.of(context).size.height - 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0), color: Colors.white),
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  // shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        initialValue: widget.news?.headline ?? '',
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
                              borderSide:
                                  BorderSide(color: Colors.purple[400]!)),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.purple[400]!)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.purple[400]!)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: TextFormField(
                        initialValue: widget.news?.description ?? '',
                        validator: (val) => val!.length != 6
                            ? 'Code should be 6 digits long'
                            : null,
                        textAlign: TextAlign.left,
                        onChanged: (val) {
                          setState(() {
                            description = val;
                          });
                        },
                        maxLength: 250,
                        keyboardType: TextInputType.multiline,
                        maxLines: 7,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
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
                              borderSide:
                                  BorderSide(color: Colors.purple[400]!)),
                          errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.purple[400]!)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(color: Colors.purple[400]!)),
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
                                    : Container(
                                        //image
                                        height: 50,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(9),
                                              topRight: Radius.circular(9)),
                                          color: Colors.grey[200],
                                        ),
                                        child: widget.news?.image != ''
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(9),
                                                    topRight:
                                                        Radius.circular(9)),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      widget.news?.image ?? '',
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.purple[
                                                                      300]!),
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              )
                                            : Center(
                                                child: Icon(
                                                  Icons.newspaper_rounded,
                                                  size: 150,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 40, vertical: 20),
                    //   child: MultiSelectDialogField(
                    //     items: _items.toList(),
                    //     title: Text("Category"),
                    //     buttonIcon: Icon(
                    //       Icons.select_all_rounded,
                    //       color: Colors.purple,
                    //     ),
                    //     selectedColor: Colors.purple[500],
                    //     decoration: BoxDecoration(
                    //       color: Colors.purple.withOpacity(0.1),
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //       border: Border.all(
                    //         color: Colors.purple[200]!,
                    //         width: 1,
                    //       ),
                    //     ),
                    //     buttonText: Text(
                    //       "Select Category",
                    //       style: TextStyle(
                    //           color: Colors.purple[200],
                    //           fontSize: 20.0,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //     onConfirm: (List<Category> results) {
                    //       category.clear();
                    //       results.forEach((e) => category.add(e.cat));
                    //       if (category == []) category = ['All'];
                    //     },
                    //   ),
                    // ),
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
                          } else {
                            newImage = widget.news!.image;
                          }
                          if (headline == "") {
                            headline = widget.news!.headline;
                          }
                          if (description == "") {
                            headline = widget.news!.description;
                          }

                          DatabaseService().updateNews(
                            headline,
                            description,
                            newImage,
                            widget.news!.documentId,
                          );
                          setState(() {
                            loading = false;
                          });
                          clearText();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(milliseconds: 800),
                              elevation: 5,
                              backgroundColor: Colors.purple,
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Edit Published',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          );
                          Navigator.of(context).pop();
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
                                    "Edit",
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
              Positioned(
                ///////////////////////////////convex effect for close button
                top: 0.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.cancel,
                      size: 30.0,
                      color: Colors.grey,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
