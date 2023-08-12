import 'package:flutter/material.dart';
import 'package:BackEyes/screens/layout/layout.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../cameras/cameras.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  var serialNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            InkWell(
                onTap: ()async {
                  var res = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SimpleBarcodeScannerPage()));
                  setState(() {
                    if (res is String) {
                      serialNumber.text = res;
                    }
                  });
                },
                child: Image.asset('assets/qr_code.png')),
            const Text(
              'Scan Code Binding',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            const Text(
              'OR',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            const Text(
              'Enter Scrial Number',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            TextField(
              controller: serialNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.arrow_circle_right_rounded,
                    size: 35,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LayoutScreen(),
                        ));
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
