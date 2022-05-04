import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


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
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.white,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title: const Text("Certificate"),
        ),

        body:SfPdfViewer.file(
            File('storage/emulated/0/Download/'+cfData+'.pdf'))

        // SingleChildScrollView(
        //   child: Column(
        //     children: [
        //
        //       Html(data: cfData),
        //       SizedBox(
        //         child: ElevatedButton(
        //           child:  const Text(
        //             'Download PDF',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //           style: ButtonStyle(
        //
        //               backgroundColor: MaterialStateProperty.resolveWith(
        //                       (states) => Colors.blue)),
        //           onPressed: (){
        //             convert(cfData);
        //           }
        //         ),
        //       )
        //     ],
        //   ),
        // )
    );
  }

  // convert( String cfData) async {
  //
  //   var targetPath = await _localPath;
  //   var targetFileName = "example_pdf_file";
  //
  //   var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
  //       cfData, targetPath!, targetFileName);
  //   print(generatedPdfFile);
  //   ScaffoldMessenger.of(context).showSnackBar( SnackBar(
  //     content: Text(generatedPdfFile.toString()),
  //   ));
  // }
  //
  // Future<String?> get _localPath async {
  //   Directory? directory;
  //   try {
  //     if (Platform.isIOS) {
  //       directory = await getApplicationDocumentsDirectory();
  //     } else {
  //       directory = Directory('/storage/emulated/0/Download');
  //       if (!await directory.exists()) directory = await getExternalStorageDirectory();
  //     }
  //   } catch (err, stack) {
  //     print("Can-not get download folder path");
  //   }
  //   return directory?.path;
  // }
}
