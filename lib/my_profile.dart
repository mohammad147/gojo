import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gojo/Homepage.dart';
import 'package:gojo/auth.dart';
import 'package:gojo/const/consts.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/loginPage.dart';

class edit_profile extends StatelessWidget {
  edit_profile({super.key, required this.Data, required this.email});
  Map<String, dynamic> Data;
  final String email;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    while (_fname.text.isEmpty) {
      _fname.text = Data["firstName"];
      _lname.text = Data["LastName"];
      _age.text = Data["Age"];
      _height.text = Data["Weight"];
      _weight.text = Data["Height"];
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(150)),
                  child: Image.asset(
                    "assets/logo/logo.jpg",
                    width: w / 1.5,
                  )),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "${S.of(context).welcome} ${Data["firstName"]}",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      S.of(context).fname,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      // initialValue: Data["firstName"],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).fill;
                        }
                      },
                      controller: _fname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.account_box_sharp),
                      ),
                    ),
                    Text(
                      S.of(context).lname,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      //initialValue: Data["LastName"].toString(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).fill;
                        }
                      },
                      controller: _lname,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.account_box_sharp),
                      ),
                    ),
                    Text(
                      S.of(context).Password,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    password(
                      pass: _pass,
                    ),
                    Text(
                      S.of(context).Age,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      //initialValue: Data["Age"],
                      controller: _age,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.account_box_sharp),
                      ),
                    ),
                    Text(
                      S.of(context).height,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      //initialValue: Data["Height"],
                      controller: _height,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.account_box_sharp),
                      ),
                    ),
                    Text(
                      S.of(context).Weight,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      // initialValue: Data["Weight"],
                      controller: _weight,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.account_box_sharp),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  child: Text(S.of(context).edit_my_prof_button),
                  onPressed: () async {
                    if (await confirm(context)) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(email)
                          .set({
                        "firstName": _fname.text,
                        "LastName": _lname.text,
                        "Age": _age.text,
                        "Weight": _weight.text,
                        "Height": _height.text,
                      });
                      if (_pass.text.isNotEmpty) {
                        auth.currentUser?.updatePassword(_pass.text);
                      }
                      Navigator.of(context).pop();
                      ;
                    }
                  }),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).back))
            ],
          ),
        ]),
      ),
    );
  }
}
