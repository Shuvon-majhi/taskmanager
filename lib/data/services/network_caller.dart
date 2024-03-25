import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:taskmanager/data/models/response_object.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      final Response response = await get(Uri.parse(url));
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSucces: true, statusCode: 200, responseBody: decodedResponse);
      } else {
        return ResponseObject(
          isSucces: false,
          statusCode: response.statusCode,
          responseBody: " ",
        );
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
        isSucces: false,
        statusCode: -1,
        responseBody: '',
        errorMessage: e.toString(),
      );
    }
  }

  static Future<ResponseObject> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      final Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {'Content-type': 'application/json'});
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSucces: true, statusCode: 200, responseBody: decodedResponse);
      } else {
        return ResponseObject(
          isSucces: false,
          statusCode: response.statusCode,
          responseBody: " ",
        );
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
        isSucces: false,
        statusCode: -1,
        responseBody: '',
        errorMessage: e.toString(),
      );
    }
  }
}
