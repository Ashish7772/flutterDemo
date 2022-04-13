import 'dart:convert';

import 'package:demo/ApiService.dart';
import 'package:demo/certificateDownload.dart';
import 'package:flutter/material.dart';


class issueCertificate extends StatefulWidget {
  const issueCertificate({Key? key}) : super(key: key);

  @override
  State<issueCertificate> createState() => _issueCertificateState();
}

class _issueCertificateState extends State<issueCertificate> {
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
          title: Text("Issue a Certificate"),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                textfieldDesign("Membership Number",membershipController),
                const SizedBox(
                  height: 20,
                ),
                textfieldDesign("Registration Number",registrationController),
                const SizedBox(
                  height: 20,
                ),
                textfieldDesign(" Serial Number",serialController),
                const SizedBox(
                  height: 20,
                ),
                textfieldDesign("BC Name",nameController),
                const SizedBox(
                  height: 20,
                ),
                textfieldDesign("BC Exam",examController),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 53,
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
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
                      child: Text(showDate,
                      style: const TextStyle(color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      ),textAlign: TextAlign.start,
                      )
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 53,
                    width: double.infinity,
                    child: ElevatedButton.icon(
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
                          var mydata2 = {
                              "@context":[
                                "https://www.w3.org/2018/credentials/v1",
                              "https://gist.githubusercontent.com/rashmigandre/31e21b34d7ae174e64b6809db63da3b3/raw/fe26ccb438d5841c684f312e429b9bf2bbaf5659/proof-of-education-vc.json"
                            ],
                            "type":[
                              "VerifiableCredential"
                            ],
                            "issuanceDate":"2022-03-16T16:00:00.000Z",
                            "credentialSubject":{
                                "type":"Person",
                            "name":nameController.text
                            },
                            "evidence":[
                              {
                                "type":[
                                  "Certificate"
                          ],
                          "certificateType":"ProofOfEducation",
                          "membershipNum":membershipController.text,
                          "registrationNum":registrationController.text,
                          "serialNum":serialController.text,
                          "bcName":nameController.text,
                          "bcExam":examController.text,
                          "date":"2000-02-16T00:00:00.000Z"
                              }
                              ],
                            "issuer":"did:issuer:protean",
                            "proof":{
                                "type":"Ed25519Signature2018",
                            "created":"2022-03-16T07:19:26Z",
                            "verificationMethod":"did:india",
                            "proofPurpose":"assertionMethod",
                            "jws":"eyJhbGciOiJFZERTQSIsImI2NCI6ZmFsc2UsImNyaXQiOlsiYjY0Il19..apqLzyLsVMEf9Z69vgQIhB-KIZNpgeRbfJTE-I89hfOuyjUZQKn9aXAQH3iJ5siUeS3n6htskVe0Kp3msWqNCg"
                              }
                            };


                           String result = await ApiServices().postData(mydata);
                    //      print("result  ${json.decode(result)} ");
                           String result2 = await ApiServices().postresponseforpdf(json.encode(result));
                          print("result2  ${result2} ");

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CertificateDownload(certificateData: result2,),
                              ));
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Generate Certificate')
                    ),
                  ),
                )
              ],
            ),

          ),
        ),
    );
  }

  textfieldDesign(String hintText,controller) {
    return      Container(
      margin: EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
        ),
      ),
    );
  }

}
