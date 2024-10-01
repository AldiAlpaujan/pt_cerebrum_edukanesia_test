import 'package:aldi_test/enum/product_availability.dart';
import 'package:aldi_test/helper/validator.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/view/product/product.controller.form.dart';
import 'package:aldi_test/widget/app_button.dart';
import 'package:aldi_test/widget/app_custom_appbar.dart';
import 'package:aldi_test/widget/app_textfield_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFormPage extends GetView<ProductFormController> {
  const ProductFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppBar(
        title: controller.formType.getCaptionByValue(
          "Tambah Produk",
          "Ubah Produk",
        ),
        actions: [
          Obx(
            () => controller.formType.isEdit
                ? IconButton(
                    onPressed: controller.onProductDelete,
                    icon: const Icon(Icons.delete_outline_rounded),
                  )
                : const SizedBox(),
          )
        ],
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppTheme.padding),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: AppTextFieldInput(
                label: "Produk",
                hintText: "Masukkan nama produk",
                controller: controller.nameC,
                validator: (v) => emptyValidator("Nama produk", v!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: AppTextFieldInput(
                label: "Harga",
                hintText: "Masukkan harga produk",
                controller: controller.priceC,
                isCurrency: true,
                onCurrencyChanged: (v) => controller.price = v,
                validator: (v) => emptyValidator("Harga produk", v!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: AppTextFieldInput(
                label: "Kategori",
                hintText: "Masukkan kategori produk",
                controller: controller.categoryC,
                validator: (v) => emptyValidator("Kategori produk", v!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: AppTextFieldInput(
                label: "Deskripsi",
                hintText: "Masukkan deskripsi produk",
                controller: controller.descC,
                validator: (v) => emptyValidator("Deskripsi produk", v!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AppTextFieldInput(
                isDropDown: true,
                label: "Status Produk",
                hintText: "Pilih status product",
                controller: controller.productAvilableC,
                validator: (v) => emptyValidator("Status produk", v!),
                dropDownInitialValue: ProductAvailability.redy.caption,
                dropDownItems: ProductAvailability.values
                    .map((item) => item.caption)
                    .toList(),
              ),
            ),
            Obx(
              () => AppButton(
                onTap: controller.submit,
                isLoading: controller.btnLoading,
                child: const Text("Simpan", style: AppTheme.btnStyle),
              ),
            )
          ],
        ),
      ),
    );
  }
}
