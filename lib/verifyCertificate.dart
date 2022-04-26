import 'dart:convert';
import 'dart:io';
import 'package:demo/qrResult.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'ApiService.dart';


class ScanQrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanQrPageState();

}

class _ScanQrPageState extends State<ScanQrPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() => result = scanData);
    });
  }
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();

  }

  showAlertDialog(BuildContext context,String value) {

    // set up the button
    Widget okButton = TextButton(
      child: const Text("Scan Again"),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
              return ScanQrPage();
            }));

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Verification Result"),
      content: Text(value,
        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

Future readQr(BuildContext context) async {
    if (result != null) {
       controller!.pauseCamera();

      var response2 = result?.code;

      print(response2);
      String responseResult = await ApiServices().postResponseForUnzip(response2);
       print("Unzip Data Result");
       print(responseResult);

       var verifyData = responseResult;


      var mydata = {
        '"signedCredentials"':
           verifyData,
        '"signingKeyType"': '"ED25519"'
       };
       print("Data that pass to api");
       print(mydata);


      var verifyResult = await ApiServices().postResponseForVerifyData(mydata.toString());

       var decodedJson = json.decode(verifyResult);
       String jsonValue = decodedJson['verified'].toString();
     //  print(decodedJson['verified']);
       String verification ="";
       print("aaaaa");
      print(jsonValue);
      if(jsonValue.contains("true"))
        {
          verification = "Certificate verified Successfully";
          showAlertDialog(context,verification);
        }
      else{
        verification = "Certification verification UnSuccessful";
        showAlertDialog(context,verification);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
   readQr(context);
    return Scaffold(
      body: QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.orange,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 250,
      ),
        ),

    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}