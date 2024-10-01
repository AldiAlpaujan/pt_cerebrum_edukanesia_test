import 'package:aldi_test/data/sale.data.dart';
import 'package:aldi_test/data/weather.data.dart';
import 'package:aldi_test/helper/global_var.dart';
import 'package:aldi_test/model/product.dart';
import 'package:aldi_test/model/sale.dart';
import 'package:aldi_test/routes/app_pages.dart';
import 'package:aldi_test/view/navigation/navigation.controller.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final navInstance = NavigationController.instance;

  final _loading = false.obs;
  final _weatherLoading = false.obs;

  final weathers = <Map<String, dynamic>>[].obs;
  final saleData = <Sale>[].obs;
  final productData = <Product>[].obs;

  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  bool get weatherLoading => _weatherLoading.value;
  set weatherLoading(bool value) => _weatherLoading.value = value;

  getWeather() async {
    if (!weatherLoading) {
      weatherLoading = true;
      weathers.value = await WeatherData.getWeather();
      weatherLoading = false;
    }
  }

  getDataSummary() async {
    getWeather();
    loading = true;
    saleData.value = await SaleData.getToday();
    productData.value = await SaleData.getBestSellingProduct();
    loading = false;
  }

  salePage() => navInstance.onNavChanged(2);

  logout() {
    user = null;
    Get.offAllNamed(Routes.login);
  }

  @override
  void onInit() {
    getDataSummary();
    super.onInit();
  }
}
