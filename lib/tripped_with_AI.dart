import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/functions.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/weather_service.dart';
import 'package:gojo/widgets/c_card.dart';
import 'package:gojo/widgets/p_card.dart';
import 'package:gojo/widgets/rating.dart';
import 'package:gojo/widgets/t_card.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class Trip_after_generate extends StatefulWidget {
  final String trip_id;
  Trip_after_generate({
    super.key,
    required this.trip_id,
  });

  @override
  State<Trip_after_generate> createState() => _Trip_after_generatsetate();
}

class _Trip_after_generatsetate extends State<Trip_after_generate> {
  String name_local = "Name";
  String description_local = "description";
  String? name;
  String? description;
  String? weatherName;
  
  List<dynamic>? placeid;
  int listNumber = 0;
  double? rate;
  String? key;
  String? city;
  List<dynamic>? img;
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

  Future<void> getallDetails() async {
    await FirebaseFirestore.instance
        .collection("trips")
        .doc(widget.trip_id)
        .get()
        .then((value) {
      var data2 = value.data();
      if (data2 != null) {
        placeid = data2['places'];
      }
    });

    if (placeid != null || placeid!.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("places")
          .doc(placeid![listNumber])
          .get()
          .then((value) {
        var dataq = value.data();
        name = dataq![name_local];
        description = dataq![description_local];
        key = dataq!["gov_key"];
        img = dataq["images"];
        rate = calculateTotalRate(
            (dataq['rates'] as List).cast<Map<String, dynamic>>());
      });
      await FirebaseFirestore.instance
          .collection("cities")
          .doc(key)
          .get()
          .then((value) {
        var data3 = value.data();
        city = data3!['title'];
      });
      _fetchWeather();
    }
  }

  Future<void> removebutton() async {
    var removeplace;
    await FirebaseFirestore.instance
        .collection("trips")
        .doc(widget.trip_id)
        .get()
        .then((value) {
      var dataplace = value.data();
      removeplace = dataplace!["places"] as List;
      removeplace.removeAt(listNumber);
    });
    FirebaseFirestore.instance
        .collection("trips")
        .doc(widget.trip_id)
        .update({'places': removeplace}).then((value) {
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(S.of(context).please_rate),
      );
     if (listNumber >= (placeid!.length-1)) {
                  Navigator.of(context).pop();
                } else {
                  setState(() {
                    initState();
                    Navigator.of(context).pop();
                  });
                }
    });
  }

  Future<void> rateplace() async {
    var _email = FirebaseAuth.instance.currentUser?.email;
    showDialog(
      context: context,
      builder: (context) {
        double user_rate = 0;
        return AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text(S.of(context).please_rate),
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
              child: Text(S.of(context).Cancel),
            ),
            TextButton(
              onPressed: () async {
                var placeData = await FirebaseFirestore.instance
                    .collection('places')
                    .doc(placeid![listNumber])
                    .get();

                if (placeData.exists) {
                  List<dynamic> ratesData = placeData.data()?['rates'] ?? [];
                  bool userFound = false;

                  // Iterate through the rates to find the user's rate
                  for (var rate in ratesData) {
                    if (rate['user_id'] == _email) {
                      rate['rate'] = user_rate; // Update the user's rate
                      userFound = true;
                      break;
                    }
                  }

                  // If the user is not found, add a new rate
                  if (!userFound) {
                    ratesData.add({'user_id': _email, 'rate': user_rate});
                  }

                  // Update the Firestore document with the modified rates
                  await FirebaseFirestore.instance
                      .collection('places')
                      .doc(placeid![listNumber])
                      .update({'rates': ratesData});
                }
                if (listNumber >= (placeid!.length-1)) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  setState(() {
                    Navigator.of(context).pop();
                    listNumber += 1;
                    initState();
                  });
                }
              },
              child: Text(S.of(context).Ok),
            ),
          ],
        );
      },
    );
  }

  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _weatherdone = false;
  Future<void> _fetchWeather() async {
    if (city != null) {
      Weather weather = await _weatherService.getCurrentWeather(city!);
      setState(() {
        _weather = weather;
        _weatherdone = true;
      });
    }
  }

  String _weatherIcon(String? iconCode) {
    if (iconCode == null) return "";
    final iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

    return iconUrl;
  }

  @override
  void initState() {
    getLoc();
    getallDetails();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        surfaceTintColor: Colors.white,
        clipBehavior: Clip.hardEdge,
        child: city != null
            ? Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        img!.isNotEmpty
                            ? CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1.0,
                                ),
                                items: img
                                    ?.map((item) => Container(
                                          child: Image.network(
                                            item,
                                            fit: BoxFit.fill,
                                            width: double.infinity,
                                            height: 150,
                                          ),
                                        ))
                                    .toList(),
                              )
                            : Image.asset("gojo/assets/logo/logo.jpg"),
                        //
                        //     ? Image.network(
                        //         widget.image,
                        //         fit: BoxFit.fill,
                        //         height: 150,
                        //         width: double.infinity,
                        //       )
                        //     : Image.asset(''),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(children: [
                                Text(
                                  name!,
                                  style: const TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                Spacer(),
                                _weatherdone
                                    ? Text(
                                        '${_weather?.temperature?.celsius?.toStringAsFixed(1)}°C')
                                    : Text("")
                              ]),
                              const SizedBox(height: 10),
                              Row(children: [
                                Container(
                                  child: CustomRatingBar(
                                    initialRating: rate,
                                    itemCount: 5,
                                    itemSize: 15,
                                    ignoreGestures: true,
                                  ),
                                ),
                                Spacer(),
                                _weatherdone
                                    ? Image.network(
                                        _weatherIcon(_weather?.weatherIcon),
                                        height: 40,
                                      )
                                    : Text(""),
                              ]),
                              const SizedBox(height: 10),
                                            Text(description!),
                            ],
                          ),
                        ),
Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  removebutton();
                                },
                                child: Text(
                                  'remove',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  rateplace();
                                },
                                child: Text(
                                  'Mark as Done',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.green),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()));
  }
}
