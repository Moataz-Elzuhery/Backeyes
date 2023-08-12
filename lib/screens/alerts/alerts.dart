import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../shared/components/component.dart';
import '../cameras/liveDetails.dart';

class Alerts extends StatefulWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Row(
                children: const [
                  Text(
                    'Alerts',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    FontAwesomeIcons.circleQuestion,
                    size: 15,
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              color: Color(0xff00101D),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text(
                        'All Devices',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/vo.png',
                        color: Colors.white,
                        scale: 1.5,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'All Activity',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/vo.png',
                        color: Colors.white,
                        scale: 1.5,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                       "23JUN",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/vo.png',
                        color: Colors.white,
                        scale: 1.5,
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: alerts.length,
                itemBuilder: (context, index) {
                  final alert = alerts[index];
                  final date = alert.createdAt.toLocal().toString().split(' ')[0]; // Extract the date portion
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/unknown_face_0.jpg",
                          height: 80,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  alert.id.toString(),
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  date,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Text(
                                  "UNKNOWN DETECTED",
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.run_circle,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

