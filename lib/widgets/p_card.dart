import 'dart:ffi';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gojo/weather_service.dart';
import 'package:gojo/widgets/rating.dart';
import 'package:weather/weather.dart';

class PCard extends StatefulWidget {
  final List<dynamic> image;
  final Function onTap;
  final String title;
  final int id;
  final double rate;
  final String city;
  PCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
    required this.id,
    required this.rate,
    required this.city,
  });

  @override
  State<PCard> createState() => _PCardState();
}

class _PCardState extends State<PCard> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  bool _weatherdone = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    Weather weather = await _weatherService.getCurrentWeather(widget.city);
    setState(() {
      _weather = weather;
      _weatherdone = true;
    });
  }

  String _weatherIcon(String? iconCode) {
    if (iconCode == null) return "";
    final iconUrl = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

    return iconUrl;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Card(
        surfaceTintColor: Colors.white,
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.image.isNotEmpty
                      ? CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            viewportFraction: 1.0,
                          ),
                          items: widget.image
                              .map((item) => Container(
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
                            widget.title,
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
                              initialRating: widget.rate,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
