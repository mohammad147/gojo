import 'package:flutter/material.dart';
import 'package:gojo/const/consts.dart';
import 'package:gojo/generated/l10n.dart';
import 'package:gojo/home.dart';
import 'package:gojo/profile.dart';
import 'package:gojo/trip.dart';
import 'package:gojo/trips_page_new.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.change});
  final Function() change;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late List<Widget> listScreens;

  @override
  void initState() {
    super.initState();
    listScreens = [
      Trip_with_AI(),
      Home(),
      generateTrip(),
      profile(change: widget.change),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: listScreens[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 30,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor:Color.fromARGB(255, 255, 87, 87), // Change to desired color
        unselectedItemColor: Colors.grey, // Change to desired color
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.time_to_leave_sharp),
            label: S.of(context).trip,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: S.of(context).history,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: S.of(context).myProfile,
          ),
        ],
      ),
    );
  }
}
