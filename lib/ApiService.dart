import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiServices{

  String url = "http://192.168.1.40:4324/sign";
  String url2 = "http://192.168.1.40:4322/api/v1/certificate";
  String url3 = "http://192.168.1.40:4322/api/v1/unzip/certificate";
  var url4 = "http://192.168.1.40:4324/verify";
  Future postData(data)async{
  var data1 = json.encode(data);
    // print("111111");
    // print(data1);
    var response = await http.post(Uri.parse(url),body: data1);
  //  print(" ${response.body.toString()} ");
    return response.body.toString();
  }
  Map<String, String> headers = {
    "Accept": "text/html",
  };
  Future postresponseforpdf(data2)async{
    const tempUrl = '"https://gist.githubusercontent.com/rashmigandre/b3a2e6b690346f284b979b54934b1f99/raw/718dbc010b7d8cdb9da4d56ad7d413e365a00932/ProofOfEducation.html"';

    var mainData = {
      '"certificate"' :
      data2,
      '"templateUrl"': tempUrl
    };

    // print("AAAA");
    // print(mainData);

    http.Response response2 = await http.post(Uri.parse(url2),body: mainData.toString(),headers:headers);
    print(" ${(response2.body.toString())} ");
    return response2.body.toString();
  }
  Map<String, String> headers2 = {
    "Content-Type": "text/html",
    "Accept": "text/html",
  };
  Future postResponseForUnzip(data3)async{
    var response3 = await http.post(Uri.parse(url3),body: data3,headers:headers2);
   // print(" ${json.decode(response3.body)} ");
    return response3.body.toString();
  }

  Map<String, String> headers3 = {
  //  "Content-Type": "application/json",
    "Content-Length": "1282"
  };
  Future postResponseForVerifyData(data3)async{
    http.Response response4 = await http.post(Uri.parse(url4),body: data3.toString());
    // print(" ${json.decode(response3.body)} ");
    return response4.body.toString();
  }
}