import 'package:demo/verifyCertificate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        backgroundColor: Colors.white,
        elevation: 2,
        systemOverlayStyle: const SystemUiOverlayStyle( // for status bar colors
          // Status bar color
          statusBarColor: Colors.white,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title :Row(  // AppBar Design
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/protean_logo.png',
              height: 90,
              width: 150,),
            Image.asset('assets/images/iibf-logo-2.png',
              height: 80,
              width: 150,),
          ],
        ),
      ),
      body: Container(

        decoration:  const BoxDecoration(color: Colors.white ,
          image: DecorationImage(
            image: AssetImage("assets/images/bg1.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              cardViewDesign2("    Issue \nCertificate",'assets/images/certificate.png'),  // Cardview Design 1
              cardViewDesign("    Verify \nCertificate",'assets/images/quality.png'),  // CardView Design 2
            ],
          ),
        ),
      ),
    );
  }
  cardViewDesign(String text,String imagePath)
  {
    return  Container(
      width:  MediaQuery.of(context).size.height*0.4,
      height: MediaQuery.of(context).size.height*0.25,
      padding: const EdgeInsets.all(10.0),


      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScanQrPage(),
              ));
        } ,
        child: Card(
          shape:
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color: Colors.blue.withOpacity(0.8),
              width: 2,
            ),
          ),
          color: Colors.white,
          elevation: 10,
          child: Container(

            decoration:  const BoxDecoration(color: Colors.white ,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: AssetImage("assets/images/bg1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Image.asset('assets/images/ribbon.png',
                height: MediaQuery.of(context).size.height*0.09,
                width:  MediaQuery.of(context).size.height*0.05,),
              ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(text,
                        style: const TextStyle(color: Colors.blueGrey,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0,bottom: 5.0),
                      child: Image.asset(imagePath),
                    ))
              ],
            ),
          )
        ),
      ),
    ) ;
  }
  cardViewDesign2(String text,String imagePath)
  {
    return  Container(
      width:  MediaQuery.of(context).size.height*0.4,
      height: MediaQuery.of(context).size.height*0.25,
      padding: const EdgeInsets.all(10.0),

      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => issueCertificate(),
              ));
        } ,
        child: Card(
            shape:
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Colors.blue.withOpacity(0.8),
                width: 2,
              ),
            ),
            color: Colors.white,
             elevation: 10,
            child: Container(
              decoration:  const BoxDecoration(color: Colors.white ,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                  image: AssetImage("assets/images/bg1.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Image.asset('assets/images/ribbon.png',
                      height: MediaQuery.of(context).size.height*0.09,
                      width:  MediaQuery.of(context).size.height*0.05,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text(text,
                            style: const TextStyle(color: Colors.blueGrey,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0,bottom: 5.0),
                        child: Image.asset(imagePath),
                      ))
                ],
              ),
            )
        ),
      ),
    ) ;
  }
}
