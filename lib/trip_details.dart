import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/functions.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/widgets/c_card.dart';
import 'package:gojo/widgets/p_card.dart';
import 'package:gojo/widgets/rating.dart';
import 'package:gojo/widgets/t_card.dart';
import 'package:intl/intl.dart';

class TripDetails extends StatefulWidget {
  final String trip_id;
  TripDetails({
    super.key,
    required this.trip_id,
  });

  @override
  State<TripDetails> createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  String title_local = "Name";

  void getLoc() {
    String currLocale = Intl.getCurrentLocale();
    if (currLocale == "en") {
      title_local = "Name";
    } else {
      title_local = "Name_ar";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          // S.of(context).trip,
          'Trip Details',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
          backgroundColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 255, 87, 87)),
          shape: MaterialStatePropertyAll(CircleBorder()),
        ),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('trips')
              .doc(widget.trip_id)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Container();
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;
            return ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: data['places'].length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('places')
                        .doc(data['places'][index])
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Container();
                      }

                      var p_data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      print(p_data['Name']);
                      return TCard(
                        onRemoveTap: () async {
                          var tempData = data['places'] as List;
                          await tempData.removeAt(index);
                          await FirebaseFirestore.instance
                              .collection('trips')
                              .doc(widget.trip_id)
                              .update({'places': tempData}).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Please rate this place"),
                              ),
                            );
                          });
                        },
                        onDoneTap: () async {
                          String? email =
                              FirebaseAuth.instance.currentUser?.email;

                          //  bool isUserRateBefore= await FirebaseFirestore.instance.collection('')
                          //  if()
                          showDialog(
                            context: context,
                            builder: (context) {
                              double user_rate = 0;
                              return AlertDialog(
                                surfaceTintColor: Colors.white,
                                backgroundColor: Colors.white,
                                title: Text('Please rate this place'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomRatingBar(
                                      itemCount: 5,
                                      itemSize: 45,
                                      onRatingUpdate: (p0) {
                                        setState(() {
                                          user_rate = p0;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      var placeData = await FirebaseFirestore
                                          .instance
                                          .collection('places')
                                          .doc(data['places'][index])
                                          .get();

                                      if (placeData.exists) {
                                        List<dynamic> ratesData =
                                            placeData.data()?['rates'] ?? [];
                                        bool userFound = false;

                                        // Iterate through the rates to find the user's rate
                                        for (var rate in ratesData) {
                                          if (rate['user_id'] == email) {
                                            rate['rate'] =
                                                user_rate; // Update the user's rate
                                            userFound = true;
                                            break;
                                          }
                                        }

                                        // If the user is not found, add a new rate
                                        if (!userFound) {
                                          ratesData.add({
                                            'user_id': email,
                                            'rate': user_rate
                                          });
                                        }

                                        // Update the Firestore document with the modified rates
                                        await FirebaseFirestore.instance
                                            .collection('places')
                                            .doc(data['places'][index])
                                            .update({'rates': ratesData}).then(
                                                (value) =>
                                                    Navigator.pop(context));
                                      }
                                    },
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        image: p_data['images'],
                        title: p_data['Name'],
                        rate: calculateTotalRate((p_data['rates'] as List)
                            .cast<Map<String, dynamic>>()),
                      );
                    });
              },
            );
          }),
    );
  }
}
