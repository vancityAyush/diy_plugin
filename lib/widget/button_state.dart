import 'package:get/get.dart';

class PressedState extends GetxController {
  RxBool isLoading = true.obs;

  void changeStatus() {
    isLoading.toggle();
  }
}
