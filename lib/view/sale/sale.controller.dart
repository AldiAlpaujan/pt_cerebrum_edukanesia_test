import 'package:aldi_test/data/sale.data.dart';
import 'package:aldi_test/helper/function.dart';
import 'package:aldi_test/model/sale.dart';
import 'package:aldi_test/routes/app_pages.dart';
import 'package:get/get.dart';

class SaleController extends GetxController {
  final _loading = false.obs;
  final data = <Sale>[].obs;

  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  getData({String keyword = '', bool withLoading = true}) async {
    loading = withLoading;
    data.value = await SaleData.get(customer: keyword);
    loading = false;
  }

  detailPage(Sale sale) async {
    // await Get.toNamed(Routes.saleForm);
  }

  formPage() async {
    await Get.toNamed(Routes.saleForm);
    getData();
  }

  onChanged(String value) {
    Func.searchListener(
      value,
      (result) async => {getData(keyword: result)},
    );
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
