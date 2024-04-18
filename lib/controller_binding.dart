import 'package:get/get.dart';
import 'package:taskmanager/presentation/controller/count_task_by_controller.dart';
import 'package:taskmanager/presentation/controller/new_task_controller.dart';
import 'package:taskmanager/presentation/controller/sign_in_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignInController(),
    );
    Get.lazyPut(() => CountTaskByStatusController());
    Get.lazyPut(() => NewTaskController());
  }
}
