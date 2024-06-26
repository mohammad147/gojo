import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/trip_details.dart';
import 'package:gojo/widgets/c_card.dart';
import 'package:intl/intl.dart';

class generateTrip extends StatefulWidget {
  const generateTrip({super.key});

  @override
  State<generateTrip> createState() => _generateTripState();
}

class _generateTripState extends State<generateTrip> {
  String title_local = "title";

  void getLoc() {
    String currLocale = Intl.getCurrentLocale();
    if (currLocale == "en") {
      title_local = "title";
    } else {
      title_local = "title_ar";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).history,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
     
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('trips').where("userid",isEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
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
                return CCard(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TripDetails(
                            trip_id: data[index].id,
                          ),
                        ));
                  },
                  image: [data[index]['images']],
                  title: data[index]['title'],
                );
              },
            );
          }),
    );
  }
}
