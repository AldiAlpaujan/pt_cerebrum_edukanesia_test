import 'package:aldi_test/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailC = TextEditingController(text: "aldi@gmail.com");
  final pwC = TextEditingController(text: "aldi");

  login() async {
    if (formKey.currentState!.validate()) {
      Get.toNamed(Routes.navigation);
    }
  }

  register() async {
    Get.toNamed(Routes.register);
  }
}
