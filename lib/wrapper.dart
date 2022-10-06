import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_admin/screens/homeScreen.dart';
import 'package:news_admin/screens/drawerContent/publishScreen.dart';
import 'package:news_admin/screens/signIn/signinScreen.dart';
import 'package:news_admin/service/database.dart';

import 'package:provider/provider.dart';

import 'Shared/loading.dart';
import 'models/models.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool loading = true;

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
    final user = Provider.of<UserAuth?>(context);
    return Scaffold(
      body: Container(
        child: user == null
            ? SignInScreen()
            : loading == true
                ? Loading()
                : StreamProvider<List<UserInformation>>.value(
                    value: DatabaseService(userUid: user.uid).userInfo,
                    initialData: [],
                    child: HomeScreen(),
                  ),
      ),
    );
  }
}
