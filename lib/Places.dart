import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gojo/firebase_options.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/jordanPage.dart';
import 'package:gojo/loginPage.dart';
import 'package:gojo/term_of_use.dart';
import 'package:gojo/widgets/p_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Places extends StatefulWidget {
  Places({super.key, required this.id});
  String id;
  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  String name_local = "Name";

  void getLoc() {
    String currLocale = Intl.getCurrentLocale();
    if (currLocale == "en") {
      name_local = "Name";
    } else {
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Places'),
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
            print("testtt $data");
            return ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                return PCard(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Places(
                            id: data[index].id,
                          ),
                        ));
                  },
                  image: data[index]['images'][0],
                  title: data[index][name_local],
                );
              },
            );
          }),
    );
  }
}
