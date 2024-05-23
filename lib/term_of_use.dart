import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:gojo/generated/l10n.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Map<String, dynamic> catalogdata;
  late String currlocale;
  late double h;

  Future<String> read_Terms_of_use() async {
    var data =
        await rootBundle.loadString("assets/Json_Files/terms_of_use_eng.json");
    setState(() {
      catalogdata = json.decode(data);
    });

    return "suc";
  }

  @override
  void initState() {
    read_Terms_of_use();
    GetLocale();
    super.initState();
  }

  void GetLocale() {
    String currLocale = Intl.getCurrentLocale();
    if (currLocale == "en") {
      currlocale = "english";
    } else {
      currlocale = "arabic";
    }
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).terms,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
        body: ListView(
          children: [Column(
                  children: [
                    Text(
                      catalogdata["terms_of_use"][currlocale]["introduction"],
                      style: TextStyle( fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                      itemCount: 13,
                      itemBuilder: (context, index) {
          return  Column(
              children: [
                Text(
                    catalogdata["terms_of_use"][currlocale]["sections"]
                        [index]['title'],
                    style: TextStyle(
                        
                        fontWeight: FontWeight.bold)),
                Text(
                    catalogdata["terms_of_use"][currlocale]["sections"]
                        [index]['content'],
                    ),
              ],
           
          );
                      },
                    )
                  ],
          )],
        ));
  }
}
