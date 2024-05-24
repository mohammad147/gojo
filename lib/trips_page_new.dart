import 'dart:convert';
import 'dart:math';
import 'package:gojo/functions.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/model.dart';
import 'package:gojo/my_profile.dart';
import 'package:http/http.dart' as http;

class Trip_with_AI extends StatefulWidget {
  const Trip_with_AI({super.key});

  @override
  State<Trip_with_AI> createState() => _Trip_with_AIState();
}

class _Trip_with_AIState extends State<Trip_with_AI> {
  int? _age;
  int? _height;
  int? _weight;
  List<int>? places = [1, 10, 100, 101, 102, 103, 104, 105];
  List<String> allplaces = [];
  List<String> allplaces_sorted = [];

  var _email;
  final TextEditingController _age_update = TextEditingController();
  final TextEditingController _height_update = TextEditingController();
  final TextEditingController _weight_update = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _prediction = {};
  Future<void> _getPrediction() async {
    final response = await http.post(
      Uri.parse('http://192.168.98.11:8000/predict/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'age': _age,
        'height': _height,
        'weight': _weight,
        'place_ids': allplaces
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      setState(() {
        _prediction = responseJson['predicted_ratings'];
        print(_prediction);
        allplaces_sorted = sortplaces(_prediction, allplaces);
        getTitleAndName();
      });
    } else {
      throw Exception('Failed to load prediction');
    }
  }

  void update_info() {
    showDialog(
      context: context,
      builder: (context) {
        return ListView(children: [
          AlertDialog(
            title: Text(S.of(context).pleaseUpdate),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).errormsgpleaseenteravlue;
                      }
                      final n = int.tryParse(value!);
                      if (n! < 16 || n! > 71) {
                        return S.of(context).ageerror;
                      }
                    },
                    controller: _age_update,
                    decoration: InputDecoration(labelText: S.of(context).Age),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).errormsgpleaseenteravlue;
                      }
                      final n = int.tryParse(value!);
                      if (n! < 135 || n! > 220) {
                        return S.of(context).heighterror;
                      }
                    },
                    controller: _height_update,
                    decoration:
                        InputDecoration(labelText: S.of(context).height),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).errormsgpleaseenteravlue;
                      }
                      final n = int.tryParse(value!);
                      if (n! < 36 || n! > 149) {
                        return S.of(context).weighterror;
                      }
                    },
                    controller: _weight_update,
                    decoration:
                        InputDecoration(labelText: S.of(context).Weight),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(S.of(context).Cancel),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(_email)
                          .update({
                        "Age": _age_update.text,
                        "Weight": _weight_update.text,
                        "Height": _height_update.text,
                      });
                    });
                    _age = int.tryParse(_age_update.text);
                    _weight = int.tryParse(_height_update.text);
                    _height = int.tryParse(_weight_update.text);
                    Navigator.of(context).pop();
                  }
                },
                child: Text(S.of(context).Ok),
              ),
            ],
          ),
        ]);
      },
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  Map<String, dynamic>? Data;
  Future<void>? getusername() async {
    _email = auth.currentUser?.email;

    ;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_email)
        .get()
        .then((value) {
      Data = value.data();
      _age = int.parse(value.data()!['Age']);
      _height = int.parse(value.data()!['Height']);
      _weight = int.parse(value.data()!['Weight']);
    });
  }

  Future<void> getallplaces() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('places').get();
    setState(() {
      allplaces = querySnapshot.docs.map((doc) => doc.id).toList();
    });
  }

  void getTitleAndName() {
    String img = "";
    String title = "";
    List<String> places5 = [allplaces[0]];

    FirebaseFirestore.instance
        .collection("places")
        .doc(allplaces_sorted[0])
        .get()
        .then((value) {
      var data2 = value.data();
      if (data2 != null) {
        img = data2['images'][0];
        title = data2['Name'];

        for (int i = 1; i < 5; i++) {
          places5.add(allplaces_sorted[i]);
        }
        savetodatabse(img, title, places5);
      } else {
        print("No data found");
      }
    }).catchError((error) {
      // Handle the error
      print("Error getting document: $error");
    });
  }

  Future<void> savetodatabse(
      String img, String title, List<String> places5) async {
    try {
      DocumentReference docRef =
          await FirebaseFirestore.instance.collection("trips").add({
        'images': img,
        'title': title,
        'userid': FirebaseAuth.instance.currentUser!.email,
        'places': places5,
      });
      String docId = docRef.id;
    } catch (e) {
      // Handle the error
      print("Error saving to database: $e");
    }
  }

  @override
  void initState() {
    getusername();
    getallplaces();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'generate trip',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 255, 87, 87)),
              alignment: Alignment.center,
            ),
            child: const Text(
              'generate trip',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_age == 0 || _height == 0 || _weight == 0) {
                update_info();
              } else {
                _getPrediction();
              }
            },
          ),
        ));
  }
}
