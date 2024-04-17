import 'package:get/get.dart';
import 'package:taskmanager/presentation/controller/sign_in_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignInController(),
    );
  }
}
