import 'dart:ui';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:provider/provider.dart';

import '../../../models/models.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserInformation>>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: users == null
                    ? Center(
                        child: SpinKitCircle(
                        color: Colors.black,
                        size: 50.0,
                      ))
                    : users.length == 0
                        ? Center(
                            child: Text('No userss.',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w600)),
                          )
                        : ListView.builder(
                            itemCount: users.length,
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
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            child: Column(
                                              children: [
                                                Marquee(
                                                  backDuration: Duration(
                                                      milliseconds: 500),
                                                  directionMarguee:
                                                      DirectionMarguee
                                                          .oneDirection,
                                                  child: Text(
                                                    users[index].displayName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25.0,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Marquee(
                                                  backDuration: Duration(
                                                      milliseconds: 500),
                                                  directionMarguee:
                                                      DirectionMarguee
                                                          .oneDirection,
                                                  child: Text(
                                                    users[index].email,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 18.0,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                )
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
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 2.0, //effect of softening the shadow
                    spreadRadius: 0.1, //effecet of extending the shadow
                    offset: Offset(
                        0.0, //horizontal
                        3.0 //vertical
                        ),
                  ),
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 1.0, //effect of softening the shadow
                    spreadRadius: 0.1, //effecet of extending the shadow
                    offset: Offset(
                        0.0, //horizontal
                        -1.0 //vertical
                        ),
                  ),
                ],
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'No of Users',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.grey.shade700),
                    ),
                    Text(
                      users.length.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.grey.shade400),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
