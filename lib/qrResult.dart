import 'package:flutter/material.dart';

class QRResult extends StatefulWidget {
  const QRResult({Key? key, required this.QRData}) : super(key: key);
  final String QRData ;

  @override
  State<QRResult> createState() => _QRResultState(QRData);
}


class _QRResultState extends State<QRResult> {
  _QRResultState(this.QRData);
  late String QRData;
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          resizeToAvoidBottomInset : false,
          appBar: AppBar(
            title: Text("QR Result"),
          ),
          body:Container(
            child: Text(QRData),
          )

    );
  }


}
