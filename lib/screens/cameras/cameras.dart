import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:BackEyes/shared/components/component.dart';
import 'dart:convert';

import '../../services/users.dart';
import 'cameras_live.dart';

class Cameras extends StatefulWidget {
  const Cameras({Key? key}) : super(key: key);

  @override
  State<Cameras> createState() => _CamerasState();
}

List<String> cameraLocations = [];

class _CamerasState extends State<Cameras> {


  @override
  void initState() {
    super.initState();
    fetchCameraLocations();
  }

  String? token = User.loggedInUser!.apiToken ;

  Future<void> fetchCameraLocations() async {
    final url = Uri.parse('$localhost/BackEyes_v2/public/api/locations');
    final headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        final locations = data.map((location) => location['place_name'] as String).toList();
        setState(() {
          cameraLocations = locations;
        });
      } else {
        // Handle the error response here
      }
    } catch (e) {
      // Handle any exceptions here
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/vo.png',
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  Text(
                    'Cameras',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              SizedBox(
                height: height * 0.7,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: height * 0.01,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: cameraLocations.length,
                  itemBuilder: (context, index) => cameraPlace(cameraLocations[index]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cameraPlace(String location) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CamerasLive(),
          ),
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset("assets/modarag3.jpg")
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                location,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
