import 'package:aldi_test/data/product.data.dart';
import 'package:aldi_test/helper/function.dart';
import 'package:aldi_test/model/product.dart';
import 'package:aldi_test/routes/app_pages.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final _loading = false.obs;
  final products = <Product>[].obs;

  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  getData({String keyword = ''}) async {
    loading = true;
    products.value = await ProductData.get(name: keyword);
    loading = false;
  }

  formPage({Product? product}) async {
    await Get.toNamed(Routes.productForm, arguments: product);
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
