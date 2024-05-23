import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:intl/intl.dart';

class policy_page extends StatefulWidget {
  const policy_page({super.key});

  @override
  State<policy_page> createState() => _policy_pageState();
}

class _policy_pageState extends State<policy_page> {
  late Map<String, dynamic> catalogdata;
  late String currlocale;
  late double h;

  Future<String> read_Terms_of_use() async {
    var data = await rootBundle.loadString("assets/Json_Files/policy.json");
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
      currlocale = "en";
    } else {
      currlocale = "ar";
    }
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).privacy_policy,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(children: [
          Text(
            catalogdata[currlocale]["introduction"],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              Text(
                  catalogdata[currlocale]["data_we_collect"]
                      ["personal_information"],
                  ),
              Text(catalogdata[currlocale]["data_we_collect"]["location_data"],
                  ),
              Text(catalogdata[currlocale]["data_we_collect"]["usage_data"],
                 ),
            ],
          ),
          Column(children: [
            Text(
              "${S.of(context).how_we_use_your_data}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                Text(catalogdata[currlocale]["how_we_use_your_data"][0],
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(catalogdata[currlocale]["how_we_use_your_data"][1],
                    ),
                Text(catalogdata[currlocale]["how_we_use_your_data"][2],
                   ),
                Text(catalogdata[currlocale]["how_we_use_your_data"][3],
                    ),
                Text(catalogdata[currlocale]["how_we_use_your_data"][4],
                   ),
                Text(catalogdata[currlocale]["how_we_use_your_data"][5],
                   ),
              ],
            )
          ]),
          Column(children: [
            Text(catalogdata[currlocale]["data_sharing"],
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(catalogdata[currlocale]["data_security"],
                style: TextStyle(color: Colors.white)),
            Text(catalogdata[currlocale]["changes_to_this_privacy_policy"],
                style: TextStyle(color: Colors.white)),
            Text(catalogdata[currlocale]["contact_us"],
                style: TextStyle(color: Colors.white)),
          ])
        ]),
      ),
    );
  }
}
