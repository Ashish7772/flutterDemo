import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';


class CertificateDownload extends StatefulWidget {
  const CertificateDownload({Key? key, required this.certificateData}) : super(key: key);
  final String certificateData ;
  @override
  State<CertificateDownload> createState() => _CertificateDownloadState(certificateData);
}

class _CertificateDownloadState extends State<CertificateDownload> {
  _CertificateDownloadState(this.cfData);
  late String cfData;
  @override



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Certificate"),
        ),
        body:SingleChildScrollView(
          child: Text("data: cfData,"),
        )
    );
  }
}
