import 'package:aldi_test/data/user.data.dart';
import 'package:aldi_test/helper/dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final _btnLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();
  final pwC = TextEditingController();

  bool get btnLoading => _btnLoading.value;
  set btnLoading(bool value) => _btnLoading.value = value;

  register() async {
    if (formKey.currentState!.validate()) {
      btnLoading = true;
      final result = await UserData.register(
        nameC.text,
        emailC.text,
        phoneC.text,
        pwC.text,
      );
      btnLoading = false;
      if (result) {
        Get.back();
        info(
          message: "Anda berhasil mendaftar, silahkan login untuk melanjutkan",
        );
      }
    }
  }
}
