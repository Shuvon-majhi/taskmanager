import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:taskmanager/data/models/count_by_status_wrapper.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';

class CountTaskByStatusController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Fetch countby task status failed';

  CountByStatusWrapper get countByStatusWrapper => _countByStatusWrapper;

  Future<bool> getCountByTaskStatus() async {
    bool isSuccess = false;

    _inProgress = true;

    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);

    if (response.isSucces) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
