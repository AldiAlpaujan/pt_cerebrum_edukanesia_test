import 'package:aldi_test/data/product.data.dart';
import 'package:aldi_test/data/sale.data.dart';
import 'package:aldi_test/enum/form_type.dart';
import 'package:aldi_test/helper/dialog.dart';
import 'package:aldi_test/helper/formatter.dart';
import 'package:aldi_test/helper/function.dart';
import 'package:aldi_test/model/product.cart.dart';
import 'package:aldi_test/model/product.dart';
import 'package:aldi_test/model/sale.dart';
import 'package:aldi_test/view/sale/sale.page.cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaleFormController extends GetxController {
  final _arg = Get.arguments as Sale?;

  var pay = 0.0;

  final _loading = false.obs;
  final _formType = FormType.add.obs;

  final customerC = TextEditingController(text: 'Pelanggan Umum');
  final totalC = TextEditingController();
  final payC = TextEditingController();

  final products = <Product>[].obs;
  final productOnCarts = <ProductCart>[].obs;

  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  FormType get formType => _formType.value;
  set formType(FormType value) => _formType.value = value;

  double get totalCart {
    double total = 0;
    for (var element in productOnCarts) {
      total += element.qty * element.price;
    }
    return total;
  }

  onSubmit() async {
    if (_validationOnSubmit()) {
      if (formType == FormType.add) {
        waitingDialog();
        final result = await SaleData.create(
          customer: customerC.text,
          payment: pay,
          productCarts: productOnCarts,
        );
        Get.back();
        if (result) {
          Get.back();
          customerC.text = 'Pelanggan Umum';
          payC.clear();
          pay = 0.0;
          productOnCarts.clear();
          info(message: "Penjualan berhasil ditambahkan");
        }
      } else {
        waitingDialog();
        final result = await SaleData.update(
          id: _arg!.id,
          customer: customerC.text,
          payment: pay,
          productCarts: productOnCarts,
        );
        Get.back();
        if (result) {
          Get.back();
          Get.back();
          info(message: "Penjualan berhasil diubah");
        }
      }
    }
  }

  bool _validationOnSubmit() {
    if (productOnCarts.isEmpty) {
      info(message: "Pilih produk terlebih dahulu");
      return false;
    }
    if (customerC.text.isEmpty) {
      info(message: "Masukan pelanggan terlebih dahulu");
      return false;
    }
    if (pay == 0) {
      info(message: "Masukan nominal pembayaran terlebih dahulu");
      return false;
    }
    if (pay < totalCart) {
      info(message: "Nominal yang dimasukan kurang");
      return false;
    }
    return true;
  }

  getData({String keyword = '', bool withLoading = true}) async {
    loading = withLoading;
    products.value = await ProductData.get(name: keyword);
    loading = false;
  }

  addToCart(Product product) {
    final exist = productOnCarts.firstWhereOrNull(
      (element) => element.id == product.id,
    );
    if (exist == null) {
      productOnCarts.add(ProductCart.fromParent(product, 1));
    } else {
      exist.qty++;
    }
    productOnCarts.value = [...productOnCarts()];
  }

  removeFromCart(Product product) {
    final exist = productOnCarts.firstWhereOrNull(
      (element) => element.id == product.id,
    );
    if (exist != null) {
      if (exist.qty > 1) {
        exist.qty--;
      } else {
        productOnCarts.removeWhere((e) => e.id == product.id);
      }
    }
    productOnCarts.value = [...productOnCarts()];
  }

  removeFromListCart(int id) async {
    productOnCarts.removeWhere((e) => e.id == id);
  }

  onChanged(String value) {
    Func.searchListener(
      value,
      (result) async => {getData(keyword: result)},
    );
  }

  cartsPage() async {
    await Get.to(const SaleCartPage());
  }

  @override
  void onInit() {
    getData();
    if (_arg != null) {
      formType = FormType.edit;
      customerC.text = _arg.customer;
      payC.text = moneyFormatter(_arg.payment);
      pay = _arg.payment;
      productOnCarts.value = _arg.products;
    }
    super.onInit();
  }
}
