import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../service/auth.dart';

class DrawerContent extends StatefulWidget {
  String type;
  StringCallback callback;
  DrawerContent({Key? key, required this.type, required this.callback}) : super(key: key);

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  bool _isSigningOut = false;
  String displayName = '';
  String email = '';
  bool isAnonymous = false;
  String phoneNumber = '';
  String photoURL = '';
  String uid = '';

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<List<UserInformation>>(context);
    if (_user.length != 0) {
      displayName = _user[0].displayName;
      email = _user[0].email;
      isAnonymous = _user[0].isAnonymous;
      phoneNumber = _user[0].phoneNumber;
      photoURL = _user[0].photoURL;
      uid = _user[0].uid;
    }

    return Container(
      color: Colors.grey[200],
      width: MediaQuery.of(context).size.width * 0.7,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100.0),
            photoURL != ''
                ? ClipOval(
                    child: Material(
                      color: Colors.purple,
                      child: Image.network(
                        photoURL,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                : ClipOval(
                    child: Material(
                      color: Colors.purple,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
            SizedBox(height: 16.0),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${email}',
                  style: TextStyle(
                    color: Colors.purple[300],
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 16.0),
                _isSigningOut
                    ? Center(
                        child: SpinKitCircle(
                        color: Colors.purple,
                        size: 50.0,
                      ))
                    : GestureDetector(
                        onTap: () async {
                          setState(() {
                            _isSigningOut = true;
                          });
                          await AuthServices.signOut(context: context);
                          setState(() {
                            _isSigningOut = false;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            border: Border.all(
                                width: 1, color: Colors.red.shade100),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Center(
                              child: Text(
                                email == '' ? "Sign In" : "Sign Out",
                                style: TextStyle(
                                    color: Colors.red[300],
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                widget.callback("publish");
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: widget.type == 'publish' ? Colors.purple : Colors.white,
                  border: Border.all(width: 1, color: Colors.purple),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12),
                      child: Text(
                        'Publish',
                        style: TextStyle(
                            color: widget.type == 'publish'
                                ? Colors.white
                                : Colors.purple,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                widget.callback("published");
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: widget.type == 'published' ? Colors.purple : Colors.white,
                  border: Border.all(width: 1, color: Colors.purple),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12),
                      child: Text(
                        'Edit Published',
                        style: TextStyle(
                            color: widget.type == 'published'
                                ? Colors.white
                                : Colors.purple,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                widget.callback("category");
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: widget.type == 'category' ? Colors.purple : Colors.white,
                  border: Border.all(width: 1, color: Colors.purple),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12),
                      child: Text(
                        'Edit Category',
                        style: TextStyle(
                            color: widget.type == 'category'
                                ? Colors.white
                                : Colors.purple,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                widget.callback("access");
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: widget.type == 'access' ? Colors.purple : Colors.white,
                  border: Border.all(width: 1, color: Colors.purple),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12),
                      child: Text(
                        'Admin Access',
                        style: TextStyle(
                            color: widget.type == 'access'
                                ? Colors.white
                                : Colors.purple,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ),
              SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                widget.callback("users");
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: widget.type == 'users' ? Colors.purple : Colors.white,
                  border: Border.all(width: 1, color: Colors.purple),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12),
                      child: Text(
                        'Users',
                        style: TextStyle(
                            color: widget.type == 'users'
                                ? Colors.white
                                : Colors.purple,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
