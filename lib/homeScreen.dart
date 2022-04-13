import 'package:demo/verifyCertificate.dart';
import 'package:flutter/material.dart';

import 'issueCertificate.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Protean RC"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              // color: Colors.blueAccent,
              child: Card(
                child:  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => issueCertificate(),
                          ));
                    } ,
                  child:  const Center(
                    child: Text("Issue a Certificate",
                    style: TextStyle(color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)
                ),
                elevation: 50.0,
                margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 25.0),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              // color: Colors.blueAccent,
              child: Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScanQrPage(),
                        ));
                  } ,
                  child:  const Center(
                    child: Text("Verify a Certificate",
                      style: TextStyle(color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)
                ),
                elevation: 50.0,
                margin: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 25.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
