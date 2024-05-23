import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gojo/firebase_options.dart';
import 'package:gojo/functions.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/loginPage.dart';
import 'package:gojo/places_with_details.dart';
import 'package:gojo/term_of_use.dart';
import 'package:gojo/widgets/p_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Places extends StatefulWidget {
  Places({super.key, required this.id,required this.city});
  String id;
  String city;
  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  String name_local = "Name";
  String description_local = "description";

  void getLoc() {
    String currLocale = Intl.getCurrentLocale();
    if (currLocale == "en") {
      description_local = "description";
      name_local = "Name";
    } else {
      description_local = "description_ar";
      name_local = "name_ar";
    }
  }

  @override
  void initState() {
    getLoc();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Places',style: const TextStyle(
            color: Colors.white)),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('places')
              .where("gov_key", isEqualTo: widget.id)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return Container();
            }

            var data = snapshot.data!.docs;

            return ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                print("testtt ${data[index]['key']}");
                return PCard(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => places_with_details(image: data[index]['images'],Name: data[index][name_local],rate: calculateTotalRate((data[index]['rates'] as List)
                      .cast<Map<String, dynamic>>()),description: data[index][description_local],weatherName: data[index]["Name"],),
                        ));
                  },
                  image: data[index]['images'],
                  title: data[index][name_local],
                  id: data[index]['key'],
                  rate: calculateTotalRate((data[index]['rates'] as List)
                      .cast<Map<String, dynamic>>()),
                      city: widget.city
                );
              },
            );
          }),
    );
  }
}
