import 'package:flutter/material.dart';
import 'package:BackEyes/Register/signup.dart';


import '../../login/login.dart';
import '../home/home_screen.dart';
import '../layout/layout.dart';
import 'content.dart';

class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(
                    start: 20, end: 20, top: 20),
                child: const Text(
                  "What do you use BackEyes for ? ",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Mixed",
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsetsDirectional.only(
                  start: 20,
                ),
                child: Text(
                  "please select all that apply.",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 17,
                    color: Color(0xff8000101D),
                    fontFamily: "Poppins",
                  ),
                ),
              ),

              Container(
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, top: 20, bottom: 20),
                  child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 50,
                      mainAxisSpacing: 40,
                      children: List.generate(
                          contentsa.length,
                              (index) =>
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                child: _buildGrid(
                                    contentsa[index],
                                    currentIndex == index
                                        ? Colors.black
                                        : Colors.black12,
                                    currentIndex == index
                                        ? Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 15,
                                        ))
                                        : Container()),
                              )))),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 360,
                  margin: EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  padding: EdgeInsetsDirectional.only(start: 13, end: 13),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 60,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff40000000).withOpacity(.4),
                          blurRadius: 4,
                          offset: Offset(5, 5))
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: currentIndex == null ? Color(0xffCC0C3B62) : Colors
                        .black,
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => LayoutScreen()));
                      },
                      child: Text(
                        "Send",
                        style: TextStyle(
                            fontSize: 24,
                            color:
                            currentIndex == null ? Colors.black : Colors.white),
                      ))),
              // SizedBox(
              //   height: 25,
              // ),
              Container(
                  width: 360,
                  margin: EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  padding: EdgeInsetsDirectional.only(start: 13, end: 13),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 60,
                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Color(0xff00000000).withOpacity(.3),
                    //       blurRadius: 4,
                    //       offset: Offset(0, 4))
                    // ],
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff00000000).withOpacity(.3),
                          blurRadius: 4,
                          offset: Offset(0, 4))
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => Login()));
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ))),
            ],
          ),
        ));
  }
  Widget _buildGrid(
    Contents cont,
    Color color,
    Widget icon,
  ) =>
      Container(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        width: 145,
        height: 140,
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10)),
        ),
        child: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(alignment: Alignment.topRight, child: icon),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(cont.image),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    cont.text,
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
            ],
          ),
        ),
      );
}
