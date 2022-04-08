import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices{

  String url = "http://192.168.1.35:4324/sign";
  String url2 = "http://192.168.1.35:4322/api/v1/certificate";
  String url3 = "http://192.168.1.35:4322/api/v1/unzip/certificate";
  String url4 = "http://192.168.1.35:4324/verify";
  Future postData(data)async{
    var response = await http.post(Uri.parse(url),body: data);
    //print(" ${json.decode(response.body)} ");
    return response.body.toString();
  }
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Content-Length": "1171",
    "Accept": "text/html",
  };
  Future postresponseforpdf(data2)async{
    var response2 = await http.post(Uri.parse(url2),body: data2,headers:headers);
    //print(" ${json.decode(response.body)} ");
    return response2.body.toString();
  }
  Map<String, String> headers2 = {
    "Content-Type": "text/html",
    "Accept": "text/html",
    "Content-Length": "1009"
  };
  Future postResponseForUnzip(data3)async{
    var response3 = await http.post(Uri.parse(url3),body: data3,headers:headers2);
   // print(" ${json.decode(response3.body)} ");
    return response3.body.toString();
  }

  Map<String, String> headers3 = {
   // "Content-Type": "application/json",
    "Content-Length": "1052"
  };
  Future postResponseForVerifyData(data3)async{

    var response4 = await http.post(Uri.parse(url4),body: data3,headers:headers3);
    // print(" ${json.decode(response3.body)} ");
    return response4.body.toString();
  }


}