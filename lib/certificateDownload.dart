import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';



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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Certificate"),
        ),

        body:SingleChildScrollView(
          child: Column(
            children: [
              Html(data: cfData),
              SizedBox(
                child: ElevatedButton(
                  child:  const Text(
                    'Download PDF',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(

                      backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.blue)),
                  onPressed: (){
                    convert(cfData);
                  }
                ),
              )
            ],
          ),
        )
    );
  }

  convert( String cfData) async {

    var targetPath = await _localPath;
    var targetFileName = "example_pdf_file";

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        cfData, targetPath!, targetFileName);
    print(generatedPdfFile);
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: Text(generatedPdfFile.toString()),
    ));
  }

  Future<String?> get _localPath async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Can-not get download folder path");
    }
    return directory?.path;
  }
}
