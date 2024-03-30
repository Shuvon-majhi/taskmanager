import 'package:taskmanager/data/models/user_data.dart';

class LogInResponse {
  String? status;
  String? token;
  UserData? userData;

  LogInResponse({this.status, this.token, this.userData});

  LogInResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userData = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}
