import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gojo/Places.dart';
import 'package:gojo/widgets/c_card.dart';
import 'package:gojo/widgets/p_card.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        title: const Text('Home'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('cities').snapshots(),
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
            print("${data[0]['images']}");
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
                          builder: (context) => Places(
                            id: data[index].id,
                          ),
                        ));
                  },
                  image: data[index]['images'],
                  title: data[index][title_local],
                );
              },
            );
          }),
    );
  }
}
