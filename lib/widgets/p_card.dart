import 'package:flutter/material.dart';

class PCard extends StatefulWidget {
  final String image;
  final Function onTap;
  final String title;
  PCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.title,
  });

  @override
  State<PCard> createState() => _PCardState();
}

class _PCardState extends State<PCard> {
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
                  widget.image != null
                      ? Image.network(
                          widget.image,
                          fit: BoxFit.fill,
                          height: 150,
                          width: double.infinity,
                        )
                      : Image.asset(''),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 17, color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
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
