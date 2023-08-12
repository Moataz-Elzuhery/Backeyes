import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../alerts/alerts.dart';
import '../cameras/cameras.dart';
import '../home/home_screen.dart';
import '../members/members.dart';
import '../profile/profile.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;
  List pages = [HomeScreen(), Cameras(),Members(), Alerts(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: pages.elementAt(currentIndex),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color(0xff2E004F6E),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.houseChimney,
                  size: 25,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  label: "cameras", icon: Icon(FontAwesomeIcons.video)),
              BottomNavigationBarItem(
                  label: "Member", icon: Icon(Icons.groups)),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.bell), label: "Alerts"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_pin,
                    size: 27,
                  ),
                  label: "Profile"),
            ],
            currentIndex: currentIndex,
            showUnselectedLabels: true,
            selectedItemColor: Color(0xff00101D),
            unselectedItemColor: Color(0xff7D7E7F),
            selectedIconTheme: IconThemeData(
              color: Color(0xff00101D),
            ),
            selectedLabelStyle: TextStyle(color: Color(0xff7D7E7F)),
            unselectedLabelStyle: TextStyle(color: Color(0xff7D7E7F)),
            onTap: _changeItem));
  }

  void _changeItem(int value) {
    setState(() {
      currentIndex = value;
    });
  }
}
