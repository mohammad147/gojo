import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class jordanPage extends StatefulWidget {
  const jordanPage({super.key});

  @override
  State<jordanPage> createState() => _jordanPageState();
}

class _jordanPageState extends State<jordanPage> {
  List<dynamic> catalogdata = [];
  late String currName;
  late String currdescription;
  late double h;
  List<String> pics = [];
  List<String> allimgs = [];
  double picture_hieght = 200;
  double picture_width = 300;

  Future<String> read_Terms_of_use() async {
    var data = await rootBundle.loadString("assets/Json_Files/places_db.json");
    catalogdata = json.decode(data);
    setState(() {});
    print(catalogdata![0]['Name']);
    return "suc";
  }

  Future<List<String>> getAllAssetsWithPaths() async {
    List<String> assetPaths = [];
    String manifestContent = await rootBundle.loadString('AssetManifest.json');
    Map<String, dynamic> manifestMap = json.decode(manifestContent);

    manifestMap.keys.forEach((String key) {
      assetPaths.add(key);
    });
    allimgs = assetPaths;
    return assetPaths;
  }

  @override
  void initState() {
    //listFileNamesInDirectory("assets/ajloun/Ajlun castle/");
    //test();
    getAllAssetsWithPaths();
    read_Terms_of_use();
    GetLocale();
    super.initState();
  }

  void getimgswithpath(String imgpath) {
    clearPicArray();
    for (int i = 0; i < allimgs.length; i++) {
      if (allimgs[i].contains(imgpath)) {
        print(pics);
        pics.add(allimgs[i]);
      }
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

  String getImgName(int gov_key) {
    switch (gov_key) {
      case 1:
        return 'amman';
      case 2:
        return 'Zarqa';
      case 3:
        return 'ajloun';
      case 4:
        return 'Irbid';
      case 5:
        return 'Jerash';
      case 6:
        return 'Madaba';
      case 7:
        return 'Balqa';
      case 8:
        return 'Mafraq';
      case 9:
        return 'Tafilah';
      case 10:
        return "Ma'an";
      case 11:
        return 'Karak';
      case 12:
        return 'Aqaba';
      default:
        return "error";
    }
  }

  String getImgPath(String ImgName, int Govkey) {
    if (ImgName != null && Govkey != null) {
      String govname = getImgName(Govkey);
      return "assets/${govname}/${ImgName}/";
    }
    return "0";
  }

  void imgsArray(String ImgName, int Govkey) async {
    String path = getImgPath(ImgName, Govkey);
    print(path);
    getimgswithpath(path);
  }

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
                      imgsArray(catalogdata![index]["Name"],
                          catalogdata![index]["gov_key"]);
                      return Column(
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
                                              setState(() {
                                                
                                              });
                                            },
                                            onTapUp: (details) {
                                              picture_hieght = 200;
                                              picture_width = 300;
                                              setState(() {
                                                
                                              });
                                            },
                                            
                                            child: Container(
                                                width: picture_width,
                                                height: picture_hieght,
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
                      );
                    },
                    itemCount: catalogdata!.length,
                  )
                ],
              ),
            ),
    );
  }
}
