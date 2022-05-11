import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices{

  String url = "http://192.168.1.38:4324/sign";
  String url2 = "http://192.168.1.38:4322/api/v1/certificate";
  String url3 = "http://192.168.1.38:4322/api/v1/unzip/certificate";
  var url4 = "http://192.168.1.38:4324/verify";
  Future postData(data)async{  // Prepare Data for certification creation Api
  var data1 = json.encode(data);
     print("Create Certificate sent Data");
     print(data1);
    var response = await http.post(Uri.parse(url),body: data1);
  print("Create Certificate Response Data");
  print(response.body.toString());
    return response.body.toString();
  }
  Map<String, String> headers = {
    "Accept": "text/html",
  };
  Future postresponseforpdf(data2)async{   // create certificate api
    const tempUrl = '"https://gist.githubusercontent.com/rashmigandre/b3a2e6b690346f284b979b54934b1f99/raw/5b62ca9a759c4177a7bc60fa93370d575100a278/ProofOfEducation.html"';

    var mainData = {
      '"certificate"' :
      data2,
      '"templateUrl"': tempUrl
    };

    print("Certificate Show Sent Data");
    print(mainData);

    http.Response response2 = await http.post(Uri.parse(url2),body: mainData.toString(),headers:headers);
    print("Certificate Show Response Data");
    print(response2.body.toString());
    return response2.body.toString();
  }
  Map<String, String> headers2 = {
    "Content-Type": "text/html",
    "Accept": "text/html",
  };
  Future postResponseForUnzip(data3)async{   // Decode zip file data api

    print("Unzip Certificate Sent Data");
    print(data3);
    var response3 = await http.post(Uri.parse(url3),body: data3,headers:headers2);
    print("Unzip Certificate Response Data");
    print(data3);
    return response3.body.toString();
  }

  Map<String, String> headers3 = {
  //  "Content-Type": "application/json",
    "Content-Length": "1282"
  };
  Future postResponseForVerifyData(data3)async{    // Api for QR code Verification

    print("Certificate Verification Sent Data");
    print(data3);
    http.Response response4 = await http.post(Uri.parse(url4),body: data3.toString());
    print("Certificate Verification Response Data");
    print(response4.body.toString());
    return response4.body.toString();
  }
}