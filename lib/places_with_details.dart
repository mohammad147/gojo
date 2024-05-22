import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gojo/widgets/rating.dart';

class places_with_details extends StatefulWidget {
  final List<dynamic> image;
  final String Name;
  final double rate;
  final String description;
  places_with_details(
      {super.key,
      required this.image,
      required this.Name,
      required this.rate,
      required this.description});

  @override
  State<places_with_details> createState() => _PCardState();
}

class _PCardState extends State<places_with_details> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      Text(
                        widget.Name,
                        style:
                            const TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        child: CustomRatingBar(
                          initialRating: widget.rate,
                          itemCount: 5,
                          itemSize: 25,
                          ignoreGestures: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(widget.description)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
