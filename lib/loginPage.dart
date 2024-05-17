import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/auth.dart';
import 'package:gojo/const/consts.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/homepage.dart';
import 'package:gojo/signup.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key, required this.change});
  Function() change;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          S.of(context).logIn,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        S.of(context).Username,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.account_circle_outlined),
                          ),
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
                    onPressed: () async {
                      print(_email.text);
                      print(_pass.text);
                      final message = await AuthService().login(
                        email: _email.text,
                        password: _pass.text,
                      );
                      if (message!.contains('Success')) {
                        if (!context.mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                change: change,
                              ),
                            ),
                            (Route<dynamic> route) => false);
                      }
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    },
                    child: Text(S.of(context).logIn)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => signUp(
                                change: change,
                              )));
                    },
                    child: Text(S.of(context).SignUp)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.fingerprint,
                      size: w / 6,
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class password extends StatefulWidget {
  password({super.key, this.pass});

  TextEditingController? pass;

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
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
