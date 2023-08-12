import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:BackEyes/shared/components/component.dart';

import '../Register/signup.dart';
import '../login/login.dart';

class ChoosePage extends StatelessWidget {
  static const String backgroundImage = "assets/d.jpeg";

  const ChoosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            opacity: 20,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(child: Image.asset("assets/c.png", key: const Key('logoImage'))),
            const SizedBox(
              height: 330,
            ),
            defaultButton(
              width: 360,
              function: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              text: "Sign up",
              background: const Color(0xff00101D),
            ),
            const SizedBox(
              height: 30,
            ),
            defaultButton(
              width: 360,
              function: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              },
              text: "Log in",
              background: Colors.white12,
            ),
          ],
        ),
      ),
    );
  }
}
