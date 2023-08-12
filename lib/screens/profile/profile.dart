
import 'package:flutter/material.dart';
import 'package:BackEyes/services/users.dart';

import '../../login/login.dart';
import '../about/about.dart';
import '../help/help.dart';
import '../setting/setting.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF00101D),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/profile.png",
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  User.loggedInUser!.name.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HelpScreen(),
              ),
            ),
            leading: Image.asset("assets/help.png"),
            title: const Text("Help & support"),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SettingScreen(),
              ),
            ),
            leading: Image.asset("assets/setting.png"),
            title: const Text("Setting"),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AboutScreen(),
              ),
            ),
            leading: Image.asset("assets/about.png"),
            title: const Text("About"),
          ),
          ListTile(
            onTap: () {},
            leading: Image.asset("assets/followUs.png"),
            title: const Text("Follow Us"),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            ),
            leading: Image.asset("assets/signout.png"),
            title: const Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
