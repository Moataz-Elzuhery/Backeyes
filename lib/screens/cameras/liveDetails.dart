import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:BackEyes/screens/cameras/cameras_live.dart';
import 'package:BackEyes/shared/components/component.dart';

import '../../services/users.dart';

class LiveDatails extends StatefulWidget {
  const LiveDatails({Key? key}) : super(key: key);

  @override
  State<LiveDatails> createState() => _LiveDatailsState();
}

String? token = User.loggedInUser!.apiToken ;

class _LiveDatailsState extends State<LiveDatails> {
  List<Alert> alerts = [];

  @override

  void initState() {
    super.initState();
    fetchAlerts();
  }



  final url = Uri.parse('$localhost/BackEyes_v2/public/api/alerts');
  final headers = {'Authorization': 'Bearer $token'};

  Future<void> fetchAlerts() async {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        alerts = data.map((item) => Alert.fromJson(item)).toList();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            cameraLiveItems(context),
            Card(
              elevation: 5,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '25/06/2023',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('${alerts.length} Events'),
                      ],
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.list),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) => liveDetails(alerts[index]),
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemCount: alerts.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget cameraLiveItems(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset("assets/modarag3.jpg",
            height: 300,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: 30,
          left: 15,
          child: Container(
            width: 100,
            color: Colors.black38,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 5,
                ),
                SizedBox(width: 5),
                Text(
                  'Live',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 60,
          color: Colors.white24,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc_name,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      '1st camera',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget liveDetails(Alert alert) {

    final date = alert.createdAt.toLocal().toString().split(' ')[0]; // Extract the date portion

    return Container(
      height : 100,
      color: Colors.grey.withOpacity(0.5),
      child: Row(
        children: [
          Text(
            date, // Use createdAt property for time
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 15),
          Container(
            width: 2,
            height: 120,
            color: Colors.grey,
          ),
          SizedBox(width: 15),
          Text(
            alert.id.toString(), // Use id property for description
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.run_circle,
            color: Colors.green,
          ),
          SizedBox(width: 15),
          Text(
            "UNKNOWN DETECTED", // Use id property for description
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                "assets/unknown_face_0.jpg", // Use alertImage property for the image URL
                fit: BoxFit.fill,
                width: 120,
              ),
            ),
          ),
        ],
      ),
    );
  }

}


class Alert {
  final int id;
  final int userId;
  final String alertImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Alert({
    required this.id,
    required this.userId,
    required this.alertImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      alertImage: json['alert_image'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      updatedAt: DateTime.parse(json['updated_at'] ?? ''),
    );
  }
}

