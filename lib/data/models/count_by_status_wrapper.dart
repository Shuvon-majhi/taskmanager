import 'package:taskmanager/data/models/task_Count_by_status_data.dart';

class CountByStatusWrapper {
  String? status;
  List<TaskCountByStatusData>? listOfTaskByStatusData;

  CountByStatusWrapper({this.status, this.listOfTaskByStatusData});

  CountByStatusWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listOfTaskByStatusData = <TaskCountByStatusData>[];
      json['data'].forEach((v) {
       listOfTaskByStatusData!.add(TaskCountByStatusData.fromJson(v));
      });
    }
  }

}
