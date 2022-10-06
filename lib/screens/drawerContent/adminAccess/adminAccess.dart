import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';
import '../../../service/database.dart';
import 'addAdminPopup.dart';

class AdminAccess extends StatefulWidget {
  const AdminAccess({Key? key}) : super(key: key);

  @override
  State<AdminAccess> createState() => _AdminAccessState();
}

class _AdminAccessState extends State<AdminAccess> {
  @override
  Widget build(BuildContext context) {
    void whenAddTapped() {
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
                  child: AddPopup(),
                ),
              ),
            );
          });
    }

    final admin = Provider.of<List<AdminInformation>>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            // color: Colors.blue,
            child: admin == null
                ? Center(
                    child: SpinKitCircle(
                    color: Colors.black,
                    size: 50.0,
                  ))
                : admin.length == 0
                    ? Center(
                        child: Text('No Admins.',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w600)),
                      )
                    : ListView.builder(
                        itemCount: admin.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 20.0, left: 40, right: 40),
                            child: InkWell(
                              onTap: () {
                                // whenCategoryUpDateTapped(
                                //     categoryList![index], documentId!, index);
                              },
                              child: Container(
                                // height: 60,
                                // color: Colors.red,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    // height: 60,
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
                                      color: Colors.purple[50],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: Column(
                                          children: [
                                            Marquee(
                                              backDuration:
                                                  Duration(milliseconds: 500),
                                              directionMarguee:
                                                  DirectionMarguee.oneDirection,
                                              child: Text(
                                                admin[index].displayName,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18.0,
                                                    color: Colors.purple[400]),
                                              ),
                                            ),
                                            Marquee(
                                              backDuration:
                                                  Duration(milliseconds: 500),
                                              directionMarguee:
                                                  DirectionMarguee.oneDirection,
                                              child: Text(
                                                admin[index].email,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14.0,
                                                    color: Colors.purple[300]),
                                              ),
                                            ),
                                            admin[index].email !=
                                                    'pulagamvamshii@gmail.com'
                                                ? GestureDetector(
                                                    onTap: () {
                                                      DatabaseService()
                                                          .updateAdmin(
                                                        admin[index].uid,
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Container(
                                                        height: 50,
                                                        width: 100,
                                                        child: Center(
                                                          child: Text(
                                                            'Remove',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                        .purple[
                                                                    800]),
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .purple[200],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
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
            bottom: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                whenAddTapped();
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
          )
        ],
      ),
    );
  }
}
