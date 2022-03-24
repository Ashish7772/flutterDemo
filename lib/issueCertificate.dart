import 'dart:convert';

import 'package:demo/ApiService.dart';
import 'package:demo/certificateDownload.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class issueCertificate extends StatefulWidget {
  const issueCertificate({Key? key}) : super(key: key);

  @override
  State<issueCertificate> createState() => _issueCertificateState();
}

class _issueCertificateState extends State<issueCertificate> {
   DateTime selectedDate = DateTime.now() ;
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
            decoration: BoxDecoration(color: Colors.white),
            padding: new EdgeInsets.all(20.0),
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
                        print('enter');
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: (new DateTime.now()).add(new Duration(days: 7)
                          ),
                        ).then((value){
                          setState(() {
                            selectedDate = value!;
                          });
                        });
                      },
                      child: Text('$selectedDate'.split(' ')[0],
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
                              "certificateType": "ProofOfEduation",
                              "membershipNum": "MEM001",
                              "registrationNum": "REG10001",
                              "serialNum": "1",
                              "bcName": "Merry D.",
                              "bcExam": "Banking & Insurance Exam",
                              "date": "2000-02-16T00:00:00.000Z"
                            },
                            "credentialTemplate": {
                              "@context": [
                                "https://www.w3.org/2018/credentials/v1",
                                "https://gist.githubusercontent.com/rashmigandre/31e21b34d7ae174e64b6809db63da3b3/raw/fe26ccb438d5841c684f312e429b9bf2bbaf5659/proof-of-education-vc.json"
                              ],
                              "type": [
                                "VerifiableCredential"
                              ],
                              "issuanceDate": "2022-03-16T16:00:00.000Z",
                              "credentialSubject": {
                                "type": "Person",
                                "name": "{{Merry D.}}"
                              },
                              "evidence": [
                                {
                                  "type": [
                                    "Certificate"
                                  ],
                                  "certificateType": "ProofOfEduation",
                                  "membershipNum": "MEM001",
                                  "registrationNum": "REG10001",
                                  "serialNum": "1",
                                  "bcName": "Merry D.",
                                  "bcExam": "Banking & Insurance Exam",
                                  "date": "2000-02-16T00:00:00.000Z"
                                }
                              ],
                              "issuer": "did:issuer:protean"
                            }
                          };
                          var mydata2 = {
                            "certificate":"{\"@context\":[\"https://www.w3.org/2018/credentials/v1\",\"https://gist.githubusercontent.com/rashmigandre/31e21b34d7ae174e64b6809db63da3b3/raw/4edff5ccd9d8213e215ce60f088245c7038faaae/proof-of-education-vc.json\"],\"type\":[\"VerifiableCredential\"],\"issuanceDate\":\"2022-03-10T16:00:00.000Z\",\"credentialSubject\":{\"type\":\"Person\",\"name\":\"DemoCandidate\"},\"evidence\":[{\"type\":[\"Certificate\"],\"certificateType\":\"ProofOfEduation\",\"educationLevel\":\"Graduate\",\"rollNumber\":\"54735\",\"passingYear\":\"2020\",\"board\":\"Mumbai\",\"school\":\"XYZCollege\",\"percentage\":\"80\",\"dob\":\"2000-08-27T00:00:00.000Z\"}],\"issuer\":\"did:issuer:protean\",\"proof\":{\"type\":\"Ed25519Signature2018\",\"created\":\"2022-03-10T11:18:09Z\",\"verificationMethod\":\"did:india\",\"proofPurpose\":\"assertionMethod\",\"jws\":\"eyJhbGciOiJFZERTQSIsImI2NCI6ZmFsc2UsImNyaXQiOlsiYjY0Il19..elW9i1pKniEdv-i-RRVQwGDRWrdOUhF57rBlXAD-23VeenfVs8Rqw560pns43P8yyOVNktAF_vLKbKiSVks1BQ\"}}",
                            "templateUrl":"https://gist.githubusercontent.com/rashmigandre/b3a2e6b690346f284b979b54934b1f99/raw/643282605b4d1dd5f0596e22214dfc553c4596b8/ProofOfEducation.html"
                          };
                           String result = await ApiServices().postData(json.encode(mydata));
                          print("result  ${json.decode(result)} ");
                           String result2 = await ApiServices().postresponseforpdf(json.encode(mydata2));
                          print("result2  ${result2} ");

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => CertificateDownload(certificateData: result2,),
                          //     ));
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
