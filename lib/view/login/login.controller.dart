import 'package:aldi_test/data/user.data.dart';
import 'package:aldi_test/helper/global_var.dart';
import 'package:aldi_test/routes/app_pages.dart';
import 'package:aldi_test/services/shared/shared_pref.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _btnLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final emailC = TextEditingController();
  final pwC = TextEditingController();

  bool get btnLoading => _btnLoading.value;
  set btnLoading(bool value) => _btnLoading.value = value;

  login() async {
    if (formKey.currentState!.validate()) {
      btnLoading = true;
      final result = await UserData.login(emailC.text, pwC.text);
      btnLoading = false;
      if (result != null) {
        user = result;
        await SharedPref.setUserID(result.id);
        Get.offAllNamed(Routes.navigation);
      }
    }
  }

  register() async {
    Get.toNamed(Routes.register);
  }
}
