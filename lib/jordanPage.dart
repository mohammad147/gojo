import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class jordanPage extends StatefulWidget {
  jordanPage({super.key, required this.placesInCity});
  List<String> placesInCity;
  @override
  State<jordanPage> createState() => _jordanPageState();
}

class _jordanPageState extends State<jordanPage> {
  String? placeName;
  List<dynamic> catalogdata = [];
  late String currName;
  late String currdescription;
  late double h;
  List<String> pics = [];
  //List<String> allimgs = [];
  double picture_hieght = 200;
  double picture_width = 300;
  int? gov_key;
  List<Map<String, dynamic>> json_file = [];
  Future<String> read_Terms_of_use() async {
    var data = await rootBundle.loadString("assets/Json_Files/places_db.json");
    catalogdata = json.decode(data);
    setState(() {});

    return "suc";
  }

  @override
  void initState() {
    //listFileNamesInDirectory("assets/ajloun/Ajlun castle/");
    //test();
    //getAllAssetsWithPaths();
    getImgName();
    gov_key = convert_placeName_to_Key();
    read_Terms_of_use();
    GetLocale();
    super.initState();
  }

  /*void getimgswithpath(String imgpath) {
    clearPicArray();
    for (int i = 0; i < allimgs.length; i++) {
      if (allimgs[i].contains(imgpath)) {
        print(pics);
        pics.add(allimgs[i]);
      }
    }
  }*/
  int convert_placeName_to_Key() {
    switch (placeName) {
      case "ajloun":
        return 3;
      case "amman":
        return 1;
      case "Aqaba":
        return 12;
      case "Balqa":
        return 7;
      case "Irbid":
        return 4;
      case "Jerash":
        return 5;
      case "Karak":
        return 11;
      case "Ma'an":
        return 10;
      case "Madaba":
        return 6;
      case "Mafraq":
        return 8;
      case "Zarqa":
        return 2;
      case "Tafilah":
        return 9;
      default:
        return -1;
    }
  }

  void GetLocale() {
    String currLocale = Intl.getCurrentLocale();
    if (currLocale == "en") {
      currName = "Name";
      currdescription = "description";
    } else {
      currName = "Name_arabic";
      currdescription = "description_arabic";
    }
  }

  void getImgName() {
    List<String> place = widget.placesInCity[1].split("/");
    //print("testtttt${widget.placesInCity}");
    placeName = place[1];
  }

  /* String getImgPath(String ImgName) {
    if (ImgName != null ) {
      widget
      return "${placeImgName}/";
    }
    return "0";
  }*/

  /*void imgsArray(String ImgName, int Govkey) async {
    String path = getImgPath(ImgName, Govkey);
    print(path);
    getimgswithpath(path);
  }*/

  void clearPicArray() {
    pics.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: catalogdata.isEmpty
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 232, 228, 214),
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              catalogdata![index][currName],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              child: CarouselSlider(
                                items: pics
                                    .map((item) => Center(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: GestureDetector(
                                              onTapDown: (details) {
                                                picture_hieght = 300;
                                                picture_width = 500;
                                                setState(() {});
                                              },
                                              onTapUp: (details) {
                                                picture_hieght = 200;
                                                picture_width = 300;
                                                setState(() {});
                                              },
                                              child: Container(
                                                  width: picture_width,
                                                  height: picture_hieght,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 35),
                                                  child: Image.asset(
                                                    item,
                                                    fit: BoxFit.fill,
                                                  )),
                                            ))))
                                    .toList(),
                                options: CarouselOptions(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: widget.placesInCity.length,
                  )
                ],
              ),
            ),
    );
  }
}
