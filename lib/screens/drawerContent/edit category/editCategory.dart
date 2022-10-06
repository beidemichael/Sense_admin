import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:marquee_widget/marquee_widget.dart';
import '../../../models/models.dart';
import 'add_category_popup.dart';
import 'edit_category_popup.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({Key? key}) : super(key: key);

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  bool? categoryMoreThanOne = false;
  List? categoryList = [];
  String? documentId = '';

  @override
  Widget build(BuildContext context) {
    void whenCategoryAddTapped(String documentId) {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: FractionallySizedBox(
                heightFactor: 0.6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: AddCategorySettingPopup(
                    documentId: documentId,
                  ),
                ),
              ),
            );
          });
    }

    void whenCategoryUpDateTapped(String name, String documentId, int index) {
      showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: FractionallySizedBox(
                heightFactor: 0.6,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: EditCategorySettingPopup(
                    name: name,
                    documentId: documentId,
                    index: index,
                    categoryMoreThanOne: categoryMoreThanOne!,
                  ),
                ),
              ),
            );
          });
    }

    final category = Provider.of<List<NewsCategory>>(context);
    if (category != null && category.length != 0) {
      setState(() {
        categoryList = category[0].category;
        documentId = category[0].documentId;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              // color: Colors.blue,
              child: ListView.builder(
                itemCount: categoryList!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 40, right: 40),
                    child: InkWell(
                      onTap: () {
                        whenCategoryUpDateTapped(
                            categoryList![index], documentId!, index);
                      },
                      child: Container(
                        height: 60,
                        // color: Colors.red,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius:
                                        2.0, //effect of softening the shadow
                                    spreadRadius:
                                        0.1, //effecet of extending the shadow
                                    offset: Offset(
                                        0.0, //horizontal
                                        3.0 //vertical
                                        ),
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius:
                                        1.0, //effect of softening the shadow
                                    spreadRadius:
                                        0.1, //effecet of extending the shadow
                                    offset: Offset(
                                        0.0, //horizontal
                                        -1.0 //vertical
                                        ),
                                  ),
                                ],
                                color: Colors.purple[100],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: Marquee(
                                  backDuration: Duration(milliseconds: 500),
                                  directionMarguee:
                                      DirectionMarguee.oneDirection,
                                  child: Text(
                                    categoryList![index],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.purple[400]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              right: 5.0,
              bottom: 5.0,
              child: InkWell(
                onTap: () {
                  whenCategoryAddTapped(documentId!);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  child: Icon(Icons.add, color: Colors.purple[500], size: 40),
                  decoration: BoxDecoration(
                    color: Colors.purple[200],
                    borderRadius: BorderRadius.circular(45.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
