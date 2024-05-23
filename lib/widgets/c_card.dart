import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CCard extends StatefulWidget {
  final List<dynamic> image;
  final Function onTap;
  final String title;
  CCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
  });

  @override
  State<CCard> createState() => _CCardState();
}

class _CCardState extends State<CCard> {
  @override
  void initState() {
    print("ghhghghgh${widget.image}");
    // TODO: implement initState
    super.initState();
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
                  widget.image.length != 1
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
                      : widget.image.isNotEmpty
                          ? Image.network(
                              widget.image[0],
                              width: double.infinity,
                              fit: BoxFit.fill,
                              height: 150,
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
                          widget.title.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 17, color: Colors.black,fontFamily: 'Merriweather'),
                        ),
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
