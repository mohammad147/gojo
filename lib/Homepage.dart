import 'package:flutter/material.dart';
import 'package:gojo/const/consts.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/jordanPage.dart';
import 'package:gojo/profile.dart';
import 'package:gojo/trip.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.change});
  Function() change;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _current_index = 0;
  int tabIndex = 0;
  late List<Widget> listScreens;
  @override
  void initState() {
    super.initState();
    listScreens = [
      jordanPage(),
      generateTrip(),
      profile(
        change: widget.change,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black12,
        body: listScreens[tabIndex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            iconSize: 30,
            currentIndex: tabIndex,
            onTap: (int index) {
              setState(() {
                tabIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined), label: S.of(context).home),
              BottomNavigationBarItem(
                  icon: Icon(Icons.time_to_leave_sharp),
                  label: S.of(context).trip),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_box_outlined),
                  label: S.of(context).myProfile)
            ]),
      ),
    );
  }
}
