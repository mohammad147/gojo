import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gojo/firebase_options.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale = Locale("en");
  late SharedPreferences _prefs;
  late String? lang;
  @override
  void initState() {
    start();

    super.initState();
  }

  start() async {
    _prefs = await SharedPreferences.getInstance();
    lang = _prefs.getString("language_code");
    print("lang is $lang");
    if (lang != null) {
      setState(() {
        locale = Locale(lang!);
      });
    }
  }

  changeLanguage() {
    print("lang in function is $lang");
    if (lang == 'ar') {
      setState(() {
        locale = Locale('en');
        _prefs.setString("language_code", "en");
        lang = "en";
      });
    } else {
      setState(() {
        locale = Locale('ar');
        _prefs.setString("language_code", "ar");
        lang = "ar";
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'GOJO',
      theme: ThemeData(
        
        listTileTheme: ListTileThemeData(tileColor: Colors.white,shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        appBarTheme: AppBarTheme(color: Color.fromARGB(255, 255, 87, 87)),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 87, 87),
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 241, 66, 53)),
        useMaterial3: true,
      ),
      home: SignInPage(change: changeLanguage),
    );
  }
}
