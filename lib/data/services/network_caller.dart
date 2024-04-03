import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:taskmanager/app.dart';
import 'package:taskmanager/data/models/response_object.dart';
import 'package:taskmanager/presentation/controller/auth_controller.dart';
import 'package:taskmanager/presentation/screens/auth/sign_in_screen.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      final Response response = await get(
        Uri.parse(url),
        headers: {
          'token': AuthController.accessToken ?? '',
        },
      );
      // log(response.statusCode.toString());
      // log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSucces: true, statusCode: 200, responseBody: decodedResponse);
      } else if (response.statusCode == 401) {
        _moveToSignIn();
        return ResponseObject(
          isSucces: false,
          statusCode: response.statusCode,
          responseBody: '',
        );
      } else {
        return ResponseObject(
          isSucces: false,
          statusCode: response.statusCode,
          responseBody: '',
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
      String url, Map<String, dynamic> body,
      {bool fromSignIn = false}) async {
    try {
      // log(url);
      // log(body.toString());
      final Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-type': 'application/json',
          'token': AuthController.accessToken ?? '',
        },
      );

      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSucces: true, statusCode: 200, responseBody: decodedResponse);
      } else if (response.statusCode == 401) {
        if (fromSignIn) {
          return ResponseObject(
            isSucces: false,
            statusCode: response.statusCode,
            responseBody: '',
            errorMessage: 'Email/Password is Incorrect! Try again',
          );
        } else {
          _moveToSignIn();
          return ResponseObject(
            isSucces: false,
            statusCode: response.statusCode,
            responseBody: '',
          );
        }
      } else {
        return ResponseObject(
          isSucces: false,
          statusCode: response.statusCode,
          responseBody: '',
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

  static void _moveToSignIn() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
        TaskManager.navigatarKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false);
  }
}
