import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/auth.dart';
import 'package:gojo/auth_service.dart';
import 'package:gojo/const/consts.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/homepage.dart';
import 'package:gojo/profile.dart';
import 'package:gojo/signup.dart';
import 'package:gojo/auth.dart' as auth1;
import 'package:gojo/auth_service.dart' as auth2;
import 'package:shared_preferences/shared_preferences.dart';


class SignInPage extends StatefulWidget {
  SignInPage({
    super.key,
    required this.change,
  });
  Function() change;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _pass = TextEditingController();
  String UserName = "";
  String pass = "";

  final AuthService_finger _authService = AuthService_finger();
  late SharedPreferences k;
  bool _canCheckBiometrics = false;

  bool _authenticated = false;
  void getk() async {
    k = await SharedPreferences.getInstance();
    UserName = k.getString("Email").toString();
    pass = k.getString("Password").toString();
  }

  @override
  void initState() {
    getk();
       
    super.initState();
    _checkBiometrics();
     _authenticate();
  }

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics = await _authService.canCheckBiometrics();
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = await _authService.authenticate();
    setState(() {
      _authenticated = authenticated;
    });
    loginUsing_auth(authenticated);
  }

  void setlogInDetails() {
    setState(() {
      k.setString("Email", _email.text);
      k.setString("Password", _pass.text);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomePage(
              change: widget.change,
            ),
          ),
          (Route<dynamic> route) => false);
    });
  }

  void loginUsing_auth(bool authenticated) async {
    if (authenticated) {

      if (UserName != "" && pass != "") {
        final message = await AuthService().login(
          email: UserName,
          password: pass,
        );
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
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }
    }
  }

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
                      final message = await AuthService().login(
                        email: _email.text,
                        password: _pass.text,
                      );
                      if (message!.contains('Success')) {
                        if (!context.mounted) return;
                        setlogInDetails();
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
                                change: widget.change,
                              )));
                    },
                    child: Text(S.of(context).SignUp)),
                IconButton(
                    onPressed: _authenticate,
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
