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
      _height.text = Data["Height"];
      _weight.text = Data["Weight"];
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
                    Pass_edit(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).errormsgpleaseenteravlue;
                        }
                        if (int.parse(value!) < 14 || int.parse(value) > 71) {
                          return S.of(context).ageerror;
                        }
                      },
                      keyboardType: TextInputType.number,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).errormsgpleaseenteravlue;
                        }
                        if (int.parse(value!) < 135 || int.parse(value) > 220) {
                          return S.of(context).heighterror;
                        }
                      },
                      keyboardType: TextInputType.number,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).errormsgpleaseenteravlue;
                        }
                        if (int.parse(value!) < 35 || int.parse(value) > 149) {
                          return S.of(context).weighterror;
                        }
                      },
                      controller: _weight,
                      keyboardType: TextInputType.number,
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
                    if (_formKey.currentState!.validate()) {
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

class Pass_edit extends StatefulWidget {
  Pass_edit({super.key, this.pass});

  TextEditingController? pass;

  @override
  State<Pass_edit> createState() => _Pass_editState();
}

class _Pass_editState extends State<Pass_edit> {
  bool password_show = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.pass,
      obscureText: password_show,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
          fillColor: Colors.white,
          filled: true,
          suffixIcon: IconButton(
              onPressed: () {
                if (password_show)
                  setState(() {
                    password_show = false;
                  });
                else {
                  setState(() {
                    password_show = true;
                  });
                }
              },
              icon: Icon(
                  password_show ? Icons.visibility_off : Icons.visibility))),
    );
  }
}
