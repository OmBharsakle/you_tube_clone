

import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiHelper{
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();
  String jsonVideoUrl = "https://raw.githubusercontent.com/bikashthapa01/myvideos-android-app/master/data.json";

  Future<Map> apiResponse()
  async {
    Response response = await http.get(Uri.parse("https://raw.githubusercontent.com/bikashthapa01/myvideos-android-app/master/data.json"));
    if(response.statusCode== 200)
      {
        final json = response.body;
        final jsonShare = await jsonDecode(json);
        return jsonShare;
      }
    else{
      return {};
    }
  }
}