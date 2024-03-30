import 'package:taskmanager/data/models/user_data.dart';

class LogInResponse {
  String? status;
  String? token;
  UserData? data;

  LogInResponse({this.status, this.token, this.data});

  LogInResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}
