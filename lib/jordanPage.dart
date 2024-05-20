import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class jordanPage extends StatefulWidget {
  const jordanPage({super.key});

  @override
  State<jordanPage> createState() => _jordanPageState();
}

class _jordanPageState extends State<jordanPage> {
  late Map<String, dynamic> catalogdata;
  late String currlocale;
  late double h;

  Future<String> read_Terms_of_use() async {
    var data = await rootBundle.loadString("assets/Json_Files/places_db.json");
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

  String getImgName(String placeName) {
placeName
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListView.builder(
            itemBuilder: (context, index) => Column(
              children: [],
            ),
            itemCount: catalogdata.length,
            shrinkWrap: true,
          )
        ],
      ),
    );
  }
}
