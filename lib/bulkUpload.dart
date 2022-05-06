import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;

import 'package:csv/csv.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

import 'ApiService.dart';

class bulkUpload extends StatefulWidget {
  const bulkUpload({Key? key}) : super(key: key);

  @override
  State<bulkUpload> createState() => _bulkUploadState();
}

class _bulkUploadState extends State<bulkUpload> {
  List<List<dynamic>> _data = [];
   String? filePath;
  bool loading = false;
  // This function is triggered when the  button is pressed

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
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () async {
                  var targetPath = await _localPath;

                  File file2 = File(targetPath.toString()+"/issue_bulk_certificate_template.csv");
                  await file2.writeAsString('MEM No.,REG No.,Ser No.,BC Name,BC Exam,Date(YYYY-MM-DDThh:mm:ss.fffZ)');

                  ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                    content: Text("File Downloaded at  /storage/emulated/0/Download/issue_bulk_certificate_template.csv"),
                  ));
                },
                  child: const Text("Download bulk_certificate_template.csv",
                    style: TextStyle(fontSize: 20),),),
              ],
            ),
            ElevatedButton(
            child: const Text("Upload FIle"),
              onPressed:(){
               _pickFile();
              },
            ),

            ListView.builder(
              itemCount: _data.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return Card(
                  margin: const EdgeInsets.all(3),
                  color: index == 0 ? Colors.amber : Colors.white,
                  child: ListTile(
                    leading: Text(_data[index][0].toString(),textAlign: TextAlign.center,
                      style: TextStyle(fontSize: index == 0 ? 18 : 15, fontWeight:index == 0 ? FontWeight.bold :FontWeight.normal,color: index == 0 ? Colors.red : Colors.black),),
                    title: Text(_data[index][3],textAlign: TextAlign.center,
                      style: TextStyle(fontSize: index == 0 ? 18 : 15, fontWeight: index == 0 ? FontWeight.bold :FontWeight.normal,color: index == 0 ? Colors.red : Colors.black),),
                    trailing: Text(_data[index][4].toString(),textAlign: TextAlign.center,
                      style: TextStyle(fontSize: index == 0 ? 18 : 15, fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,color: index == 0 ? Colors.red : Colors.black),),

                  ),

                );

              },

            ),
            Container(
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: ()async{
                  setState((){
                    loading = true;
                  }); // set loading to true here

                  for (var element in _data.skip(1))
                  {

                    var mydata = {
                      "data": {
                        "certificateType": "ProofOfEducation",
                        "membershipNum": element[0],
                        "registrationNum": element[1],
                        "serialNum": element[2],
                        "bcName": element[3],
                        "bcExam": element[4],
                        "date":element[5]
                      },
                      "credentialTemplate": {
                        "@context": [
                          "https://www.w3.org/2018/credentials/v1",
                          "https://gist.githubusercontent.com/rashmigandre/31e21b34d7ae174e64b6809db63da3b3/raw/fe26ccb438d5841c684f312e429b9bf2bbaf5659/proof-of-education-vc.json"
                        ],
                        "type": [
                          "VerifiableCredential"
                        ],
                        "issuanceDate": element[5],
                        "credentialSubject": {
                          "type": "Person",
                          "name": element[3]
                        },
                        "evidence": [
                          {
                            "type": [
                              "Certificate"
                            ],
                            "certificateType": "ProofOfEducation",
                            "membershipNum": element[0],
                            "registrationNum": element[1],
                            "serialNum": element[2],
                            "bcName": element[3],
                            "bcExam": element[4],
                            "date":element[5]
                          }
                        ],
                        "issuer": "did:issuer:protean"
                      }
                    };

                    String result = await ApiServices().postData(mydata);
                    //      print("result  ${json.decode(result)} ");
                    String result2 = await ApiServices().postresponseforpdf(json.encode(result));
                    print("result2  ${result2} ");

                    String date = DateTime.now().year.toString()+"_"+DateTime.now().month.toString()+"_"+DateTime.now().day.toString()+"_"+DateTime.now().hour.toString()+"_"+DateTime.now().minute.toString()+"_"+DateTime.now().second.toString();
                    await convert(result2,element[0]+"_"+date);
                    setState((){
                      loading = false;
                    });
                    print(element[1]);
                  }
                  ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                    content: Text("File Downloaded at  /storage/emulated/0/Download/"),
                  ));
                }, child: const Text("Generate Certificate"),

              ),
            ),
          ],
        )
    );

  }

  void _pickFile() async {

    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;

    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
    filePath = result.files.first.path!;
  //  _loadCSV(filePath!);
   // PlatformFile file = result.files.first;


    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print("aaaa");
    print(fields);


      setState(() {
        _data = fields;
      });
  }


  convert( String cfData,String name) async {

    var targetPath = await _localPath;
    var targetFileName = name;

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        cfData, targetPath!, targetFileName);
    print(generatedPdfFile);

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
