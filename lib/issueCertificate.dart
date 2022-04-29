import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:demo/ApiService.dart';
import 'package:demo/bulkUpload.dart';
import 'package:demo/certificateDownload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class issueCertificate extends StatefulWidget {
  const issueCertificate({Key? key}) : super(key: key);

  @override
  State<issueCertificate> createState() => _issueCertificateState();
}

class _issueCertificateState extends State<issueCertificate> {
  File? pickedImage;
  File? pickedAuth1;
  File? pickedAuth2;
  DateTime selectedDate = DateTime.now() ;
  String showDate = "Select a Date";
  final TextEditingController membershipController = TextEditingController();
  final TextEditingController registrationController = TextEditingController();
  final TextEditingController serialController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController examController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        title: const Text("Issue Certificate",
            style: TextStyle(color: Colors.white,
              fontSize: 20.0,)
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height : MediaQuery.of(context).size.height,
          decoration:  const BoxDecoration(color: Colors.white ,
            image: DecorationImage(
              image: AssetImage("assets/images/bg1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              textfieldDesign("Membership Number",membershipController,Icons.people_outline),
              const SizedBox(
                height: 20,
              ),
              textfieldDesign("Registration Number",registrationController,Icons.people_outline),
              const SizedBox(
                height: 20,
              ),
              textfieldDesign(" Serial Number",serialController,Icons.numbers_outlined),
              const SizedBox(
                height: 20,
              ),
              textfieldDesign("BC Name",nameController,Icons.person_outlined ),
              const SizedBox(
                height: 20,
              ),
              textfieldDesign("BC Exam",examController,Icons.book_outlined ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 53,
                width: double.infinity,
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      readOnly: true,

                      //  onChanged: (value) {trxnProvider.changecontractDate(value);
                        //,loggedInUid);},
                        decoration: InputDecoration(
                          hintText: showDate,
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder:const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2.0),

                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_today,
                            ),

                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: (new DateTime.now()).add(new Duration(days: 7)
                                ),
                              ).then((value){
                                setState(() {
                                  selectedDate = value!;
                                  showDate = selectedDate.toString().split(' ')[0];
                                  print(selectedDate);
                                });
                              });
                            },
                          ),
                        ),
                          ),
                              ),
              ),
              const SizedBox(
                height: 20,
              ),
              // imageUploadDesign("Upload Image File"),
              // imageUploadDesign1("Upload Signature of Authority1"),
              // imageUploadDesign2("Upload Signature of Authority2"),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:5.0),
                child: SizedBox(
                  height: 53,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: ()async{
                        var mydata = {
                          "data": {
                            "certificateType": "ProofOfEducation",
                            "membershipNum": membershipController.text,
                            "registrationNum": registrationController.text,
                            "serialNum": serialController.text,
                            "bcName": nameController.text,
                            "bcExam": examController.text,
                            "date": "${selectedDate.toIso8601String().toString()}Z"
                          },
                          "credentialTemplate": {
                            "@context": [
                              "https://www.w3.org/2018/credentials/v1",
                              "https://gist.githubusercontent.com/rashmigandre/31e21b34d7ae174e64b6809db63da3b3/raw/fe26ccb438d5841c684f312e429b9bf2bbaf5659/proof-of-education-vc.json"
                            ],
                            "type": [
                              "VerifiableCredential"
                            ],
                            "issuanceDate": "${selectedDate.toIso8601String().toString()}Z",
                            "credentialSubject": {
                              "type": "Person",
                              "name": nameController.text
                            },
                            "evidence": [
                              {
                                "type": [
                                  "Certificate"
                                ],
                                "certificateType": "ProofOfEducation",
                                "membershipNum": membershipController.text,
                                "registrationNum": registrationController.text,
                                "serialNum": serialController.text,
                                "bcName": nameController.text,
                                "bcExam": examController.text,
                                "date": "${selectedDate.toIso8601String().toString()}Z"
                              }
                            ],
                            "issuer": "did:issuer:protean"
                          }
                        };

                        String result = await ApiServices().postData(mydata);
                        //      print("result  ${json.decode(result)} ");
                        String result2 = await ApiServices().postresponseforpdf(json.encode(result));
                        print("result2  ${result2} ");

                        await convert(result2);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CertificateDownload(certificateData: result2,),
                            ));
                      },

                      child: const Text('Generate Certificate',
                          style: TextStyle(color: Colors.white,
                        fontSize: 20.0,))
                  ),
                ),
              ),
              TextButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const bulkUpload(),
                    ));
              },
                child: const Text("Bulk Upload"),)
            ],

          ),

        ),
      ),
    );
  }
  imageUploadDesign(String imageHint)
  {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.center,
          child: Row(
            //mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo, width: 2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipOval(
                      child:
                      pickedImage != null
                          ? Image.file(
                        pickedImage!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        'assets/images/protean_logo.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      right: -15,
                      child: IconButton(
                        onPressed: imagePickerOption,
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(imageHint
                ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

      ],
    );
  }
  imageUploadDesign1(String imageHint)
  {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.center,
          child: Row(
            //mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo, width: 2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipOval(
                      child:
                      pickedAuth1 != null
                          ? Image.file(
                        pickedAuth1!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        'assets/images/protean_logo.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      right: -15,
                      child: IconButton(
                        onPressed: imagePickerOption1,
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(imageHint
                ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

      ],
    );
  }
  imageUploadDesign2(String imageHint)
  {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.center,
          child: Row(
            //mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo, width: 2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipOval(
                      child:
                      pickedAuth2 != null
                          ? Image.file(
                        pickedAuth2!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        'assets/images/protean_logo.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      right: -15,
                      child: IconButton(
                        onPressed: imagePickerOption2,
                        icon: const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(imageHint
                ,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)

            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

      ],
    );
  }
  textfieldDesign(String hintText,controller,IconData icon) {
    return      Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          labelText: hintText,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(),
          focusedBorder:const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),

          ),
        ),
      ),
    );
  }

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void imagePickerOption1() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage1(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage1(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void imagePickerOption2() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage2(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage2(ImageSource.gallery);
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
  pickImage1(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedAuth1 = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }
  pickImage2(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedAuth2 = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  convert( String cfData) async {

    var targetPath = await _localPath;
    var targetFileName = "Certificate_pdf_file";

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


