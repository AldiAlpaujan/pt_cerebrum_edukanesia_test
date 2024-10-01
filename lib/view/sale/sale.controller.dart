import 'package:aldi_test/routes/app_pages.dart';
import 'package:get/get.dart';

class SaleController extends GetxController {
  formPage() async {
    await Get.toNamed(Routes.saleForm);
  }
}
