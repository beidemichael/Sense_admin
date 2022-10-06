import 'dart:math';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../models/models.dart';
import '../../../service/database.dart';
import 'adminSearchResult.dart';

class AddPopup extends StatefulWidget {
  @override
  _AddPopupState createState() => _AddPopupState();
}

class _AddPopupState extends State<AddPopup> {
  final _formKey = GlobalKey<FormState>();
  String? email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  carrierResult(BuildContext context, String adminEmail) {
    AdminSearchResult alert = AdminSearchResult();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamProvider<List<AdminInformation>>.value(
            value: DatabaseService(email: adminEmail).searchAdmin,
            initialData: [],
            child: alert);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add Admin",
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
                height: 35.0,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 20),
                        labelText: 'Enter Email',
                        focusColor: Colors.orange[900],
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 15.0,
                            color: Colors.grey[800]),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: Colors.grey.shade400)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide:
                                BorderSide(color: Colors.purple.shade200)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: Center(
                      child: Text('Cancel',
                          style: TextStyle(
                              fontSize: 21.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w100)),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(35.0))),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  carrierResult(context, email!);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: Center(
                      child: Text('Search',
                          style: TextStyle(
                              fontSize: 21.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w100)),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(35.0))),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
