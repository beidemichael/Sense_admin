import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_admin/screens/drawerContent/edit%20category/editCategory.dart';
import 'package:news_admin/screens/drawerContent/publishScreen.dart';
import 'package:news_admin/screens/drawerContent/PublishedScreen/publishedPage.dart';
import 'package:news_admin/screens/signIn/signinScreen.dart';
import 'package:news_admin/service/database.dart';

import 'package:provider/provider.dart';

import '../models/models.dart';
import 'drawer.dart';
import 'drawerContent/adminAccess/adminAccess.dart';
import 'drawerContent/adminAccess/userScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;
  String type = 'publish';
  set string(String value) => setState(() => type = value);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
    final user = Provider.of<UserAuth?>(context);
    final _userInfo = Provider.of<List<UserInformation>>(context);
    return _userInfo == null
        ? Center(
            child: SpinKitCircle(
            color: Colors.black,
            size: 50.0,
          ))
        : _userInfo.length == 0
            ? Center(
                child: SpinKitCircle(
                color: Colors.black,
                size: 50.0,
              ))
            : _userInfo[0].isAdmin == true || _userInfo[0].uid == '3QNwrhjVKDhM9LpuCAi2EbPhGqs1'
            ? 
             Scaffold(
                key: _scaffoldState,
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'Admin App',
                  ),
                  backgroundColor: const Color(0xff764abc),
                ),
                drawer: DrawerContent(
                  type: type,
                  callback: (val) => setState(() => type = val),
                ),
                body: Container(
                  child: type == 'publish'
                      ? StreamProvider<List<NewsCategory>>.value(
                          value: DatabaseService().newsCategory,
                          initialData: [],
                          child: PublishScreen(type: type))
                      : type == 'published'
                          ? StreamProvider<List<News>>.value(
                              value: DatabaseService().news,
                              initialData: [],
                              child: PublishedPage())
                          : type == 'category'
                              ? StreamProvider<List<NewsCategory>>.value(
                                  value: DatabaseService().newsCategory,
                                  initialData: [],
                                  child: EditCategory())
                              : type == 'access'
                                  ? StreamProvider<
                                          List<AdminInformation>>.value(
                                      value: DatabaseService().adminInfo,
                                      initialData: [],
                                      child: AdminAccess())
                                  : type == 'users'
                                      ? StreamProvider<
                                              List<UserInformation>>.value(
                                          value: DatabaseService().usersList,
                                          initialData: [],
                                          child: UserScreen())
                                      : Container(),
                ),
              ):Scaffold(
                body: Container(
                  child: Center(
                    child: Text('You are not registered as an admin',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              );
  }
}
