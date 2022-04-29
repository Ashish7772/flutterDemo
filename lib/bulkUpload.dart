import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';

class bulkUpload extends StatefulWidget {
  const bulkUpload({Key? key}) : super(key: key);

  @override
  State<bulkUpload> createState() => _bulkUploadState();
}

class _bulkUploadState extends State<bulkUpload> {
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
        title: const Text("Bulk Upload",
            style: TextStyle(color: Colors.white,
              fontSize: 20.0,)
        ),
      ),
        body: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              ElevatedButton(onPressed: (){

              }, child:const Text("Upload File"))

            ],
        ),
    )
    );

  }
  //
  // pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //
  //     final input = File(file.path).openRead();
  //     final fields = await input
  //         .transform(utf8.decoder)
  //         .transform(new CsvToListConverter())
  //         .toList();
  //
  //     print(fields);
  //   }
  // }

}
