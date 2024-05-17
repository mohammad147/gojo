import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/auth.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/loginPage.dart';
import 'package:gojo/my_profile.dart';

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
        backgroundColor: Color.fromARGB(255, 232, 228, 214),
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
                        color: const Color.fromARGB(255, 222, 95, 92)),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Text(
              S.of(context).editProfile,
            ),
            GestureDetector(
              onTap: () {
                print(Data);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        edit_profile(Data: Data!, email: _email!)));
              },
              child: ListTile(
                  leading: Icon(
                    Icons.account_box_rounded,
                  ),
                  title: Text(
                    S.of(context).myProfile,
                  )),
            ),
            Text(S.of(context).accountSettings),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.currentUser!.delete();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => SignInPage(
                        change: widget.change,
                      ),
                    ),
                    (Route<dynamic> route) => false);
              },
              child: ListTile(
                  leading: Icon(
                    Icons.delete,
                  ),
                  title: Text(
                    S.of(context).deleteAccount,
                  )),
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => SignInPage(
                        change: widget.change,
                      ),
                    ),
                    (Route<dynamic> route) => false);
              },
              child: ListTile(
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: Text(
                    S.of(context).logOut,
                  )),
            ),
            Text(S.of(context).more),
            Container(
                margin: EdgeInsets.all(7),
                child: ListTile(
                    leading: Icon(
                      Icons.question_mark_rounded,
                    ),
                    title: Text(
                      S.of(context).about,
                    ))),
            ListTile(
                leading: Icon(
                  Icons.shield,
                ),
                title: Text(
                  S.of(context).terms,
                )),
            ListTile(
                leading: Icon(
                  Icons.security,
                ),
                title: Text(
                  S.of(context).privary,
                )),
            Text(S.of(context).language_name),
            GestureDetector(
              onTap: widget.change,
              child: ListTile(
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
