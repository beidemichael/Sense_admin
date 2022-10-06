import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:news_admin/models/models.dart';
import 'package:news_admin/service/database.dart';

import 'package:provider/provider.dart';

class AdminSearchResult extends StatelessWidget {
  List<AdminInformation> adminList = [];

  @override
  Widget build(BuildContext context) {
    final admins = Provider.of<List<AdminInformation>>(context);
    if (admins != null) {
      if (admins.isNotEmpty) {
        adminList = admins;
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Center(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Search result",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.grey[900],
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Divider(
                          color: Colors.grey,
                          height: 4.0,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Center(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.56,
                          child: adminList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: adminList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          left: 13,
                                          right: 13,
                                          bottom: 10),
                                      child: InkWell(
                                        onTap: () {
                                          DatabaseService()
                                              .makeAdmin(adminList[index].uid);
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          Colors.grey.shade400,
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
                                                      color:
                                                          Colors.grey.shade400,
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
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        Marquee(
                                                          backDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      500),
                                                          directionMarguee:
                                                              DirectionMarguee
                                                                  .oneDirection,
                                                          child: Text(
                                                            adminList[index]
                                                                .displayName,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                        .purple[
                                                                    600]),
                                                          ),
                                                        ),
                                                        Marquee(
                                                          backDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      500),
                                                          directionMarguee:
                                                              DirectionMarguee
                                                                  .oneDirection,
                                                          child: Text(
                                                            adminList[index]
                                                                .email,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 14.0,
                                                                color: Colors
                                                                        .purple[
                                                                    400]),
                                                          ),
                                                        ),
                                                      ],
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
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Center(
                                    child: Text(
                                      "No User was found under the given email",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey[900],
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                        )),
                      ],
                    ),
                    Positioned(
                      /////////////////////////////// close button
                      top: 0.0,
                      right: 0.0,
                      child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white,
                          )),
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
                            FontAwesomeIcons.xmark,
                            size: 18.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
