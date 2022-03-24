import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices{

  String url = "http://192.168.0.102:4324/sign";
  String url2 = "http://192.168.0.102:4322/api/v1/certificate";
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


// Future<CertificateResponseModel?> createUser(data) async{
//   String url = "http://192.168.0.102:4324/sign";
//   var response = await http.post(Uri.parse(url),body: data);
//     print(" ${json.decode(response.body)} ");
//     if(response.statusCode == 201)
//       {
//         final String responseString = json.decode(response.body);
//         return CertificateResponseModel.fromJson();
//       }else{
//       return null;
//     }
// }
}