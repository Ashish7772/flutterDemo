import 'package:demo/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  const Splash ({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(const Duration(milliseconds: 2000),(){}); //Set Time of Splash Screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> homeScreen()));  // Screen open after Splash Screen

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: Stack(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Image.asset('assets/images/iibf-logo.jpg',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height*0.5,),

          ),
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Powered by",
              style: TextStyle(color: Colors.black,fontSize: 20),),
              Center(child:Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Image.asset('assets/images/protean-logo.png'),

              ) )
            ],
          )),

        ],
      ),
    );
  }
}
