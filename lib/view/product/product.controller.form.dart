import 'package:aldi_test/data/product.data.dart';
import 'package:aldi_test/enum/form_type.dart';
import 'package:aldi_test/enum/product_availability.dart';
import 'package:aldi_test/helper/dialog.dart';
import 'package:aldi_test/model/product.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProductFormController extends GetxController {
  final _arg = Get.arguments as Product?;

  var price = 0.0;
  var productAvilable = true;

  final _btnLoading = false.obs;
  final _formType = FormType.add.obs;

  final formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final priceC = TextEditingController();
  final categoryC = TextEditingController();
  final descC = TextEditingController();
  final productAvilableC = TextEditingController();

  bool get btnLoading => _btnLoading.value;
  set btnLoading(bool value) => _btnLoading.value = value;

  FormType get formType => _formType.value;
  set formType(FormType value) => _formType.value = value;

  submit() async {
    if (formKey.currentState!.validate()) {
      btnLoading = true;
      if (formType == FormType.add) {
        final result = await ProductData.create(
          Product(
            name: nameC.text,
            price: price,
            category: categoryC.text,
            description: descC.text,
            availability: productAvilable,
          ),
        );
        if (result) {
          Get.back();
          info(message: "Product berhasil ditambahkan!");
        }
      } else {
        final result = await ProductData.update(
          Product(
            id: _arg!.id,
            name: nameC.text,
            price: price,
            category: categoryC.text,
            description: descC.text,
            availability: productAvilable,
          ),
        );
        if (result) {
          info(message: "Product berhasil diubah!");
        }
      }
      btnLoading = false;
    }
  }

  onProductDelete() async {
    waitingDialog();
    final result = await ProductData.delete(_arg!.id!);
    Get.back();
    if (result) {
      Get.back();
      info(message: "Product berhasil dihapus!");
    }
  }

  @override
  void onInit() {
    if (_arg != null) {
      formType = FormType.edit;
      price = _arg.price;
      nameC.text = _arg.name;
      priceC.text = _arg.price.toString();
      categoryC.text = _arg.category;
      descC.text = _arg.description ?? "";
      productAvilable = _arg.availability;
    }
    productAvilableC.addListener(() {
      final value = productAvilableC.text;
      if (value == ProductAvailability.redy.caption) {
        productAvilable = true;
      } else {
        productAvilable = false;
      }
    });
    super.onInit();
  }
}
