import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:gojo/Homepage.dart';
import 'package:gojo/auth.dart';
import 'package:gojo/const/consts.dart';
import 'package:gojo/generated/intl/messages_ar.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/loginPage.dart';

class signUp extends StatefulWidget {
  signUp({super.key, required this.change});
  Function() change;

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _fname = TextEditingController();
  final TextEditingController _lname = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(250)),
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
                        S.of(context).SignUp,
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
                      S.of(context).Email,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                       validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.of(context).fill;
                        }
                       },
                      controller: _email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100)),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.email),
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
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  child: Text(S.of(context).ceateAnAccount),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                    final message = await AuthService().registration(
                        email: _email.text,
                        password: _pass.text,
                        fname: _fname.text,
                        lname: _lname.text);
                    if (message!.contains('Success')) {
                      if (!context.mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              change: widget.change,
                            ),
                          ),
                          (Route<dynamic> route) => false);
                    }
                    }
                
                  }),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).logIn))
            ],
          ),
        ]),
      ),
    );
  }
}
