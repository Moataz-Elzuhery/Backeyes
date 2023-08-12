import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/components/constants.dart'; // Import the file where the `token` variable is defined
import '../grid/grid.dart';
import '../../choosee/choose.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    print('token is $token');
    Future.delayed(Duration(seconds: 4), () {
      token != null && token != ""
          ? Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Grid()),
      )
          : Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChoosePage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    return Scaffold(
      backgroundColor: Color(0xff00101D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/1.png'),
          ],
        ),
      ),
    );
  }
}
