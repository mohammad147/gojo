import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/auth.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/loginPage.dart';
import 'package:gojo/my_profile.dart';
import 'package:gojo/term_of_use.dart';

class profile extends StatefulWidget {
  profile({super.key, required this.change});
  Function() change;

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String? _email;

  String? _name;

  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic>? Data;

  void getemail() {
    _email = auth.currentUser?.email;
  }

  Future<String>? getusername() async {
    _email = auth.currentUser?.email;
    ;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_email)
        .get()
        .then((value) {
      Data = value.data();
      _name = value.data()!['firstName'];
    }); //then((value) => );
    return Future.value(_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 138, 138),
        body: ListView(
          shrinkWrap: true,
          children: [
            FutureBuilder(
              future: getusername(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "${S.of(context).welcome} $_name ",
                    style: TextStyle(
                        fontSize: 50,
                        color: Color.fromARGB(255, 248, 158, 158)),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Text(
              S.of(context).editProfile,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: ListTile(
                  onTap: () {
                    print(Data);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            edit_profile(Data: Data!, email: _email!)));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  leading: Icon(
                    Icons.account_box_rounded,
                  ),
                  title: Text(
                    S.of(context).myProfile,
                  )),
            ),
            Text(S.of(context).accountSettings),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  onTap: () async {
                    if (await confirm(context)) {
                       FirebaseAuth.instance.currentUser!.delete();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                           builder: (context) => SignInPage(
                              change: widget.change,
                            ),
                          ),
                          (Route<dynamic> route) => false);
                    }
                  },
                  leading: Icon(
                    Icons.delete,
                  ),
                  title: Text(
                    S.of(context).deleteAccount,
                  )),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  onTap: () async {
                    if (await confirm(context)) {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => SignInPage(
                              change: widget.change,
                            ),
                          ),
                          (Route<dynamic> route) => false);
                    }
                  },
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: Text(
                    S.of(context).logOut,
                  )),
            ),
            Text(S.of(context).more),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    leading: Icon(
                      Icons.question_mark_rounded,
                    ),
                    title: Text(
                      S.of(context).about,
                    ))),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyWidget(),
                    ));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  leading: Icon(
                    Icons.shield,
                  ),
                  title: Text(
                    S.of(context).terms,
                  )),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  leading: Icon(
                    Icons.security,
                  ),
                  title: Text(
                    S.of(context).privary,
                  )),
            ),
            Text(S.of(context).language_name),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                onTap: widget.change,
                leading: Icon(
                  Icons.language,
                ),
                title: Text(
                  S.of(context).language,
                ),
              ),
            ),
          ],
        ));
  }
}
