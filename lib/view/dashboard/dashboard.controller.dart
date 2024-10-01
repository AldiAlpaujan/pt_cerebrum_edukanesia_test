import 'package:aldi_test/helper/global_var.dart';
import 'package:aldi_test/routes/app_pages.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  logout() {
    user = null;
    Get.offAllNamed(Routes.login);
  }
}
