import 'package:aldi_test/helper/formatter.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/view/sale/sale.controller.form.dart';
import 'package:aldi_test/view/sale/widget/app_cart_card.dart';
import 'package:aldi_test/widget/app_custom_appbar.dart';
import 'package:aldi_test/widget/app_fix_btm_btn.dart';
import 'package:aldi_test/widget/app_textfield_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaleCartPage extends GetView<SaleFormController> {
  const SaleCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppCustomAppBar(title: "Keranjang"),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppTheme.padding),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: AppTextFieldInput(
                      label: "Pelanggan",
                      hintText: "Masukkan nama pelanggan",
                      controller: controller.customerC,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextFieldInput(
                          label: "Total Bayar",
                          hintText: "Masukkan total bayar",
                          readOnly: true,
                          controller: controller.totalC
                            ..text = moneyFormatter(controller.totalCart),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppTextFieldInput(
                          label: "Bayar",
                          hintText: "Masukkan nomial",
                          isCurrency: true,
                          onCurrencyChanged: (v) => controller.pay = v,
                          controller: controller.payC,
                        ),
                      ),
                    ],
                  ),
                  ...controller.productOnCarts().map(
                        (e) => AppCartCard(
                          product: e,
                          onTap: controller.addToCart,
                          onRemove: controller.removeFromCart,
                          onRemoveFromList: controller.removeFromListCart,
                          isLast: e.id == controller.productOnCarts().last.id,
                          inCart: controller
                                  .productOnCarts()
                                  .firstWhereOrNull((i) => i.id == e.id)
                                  ?.qty ??
                              0,
                        ),
                      ),
                ],
              ),
            ),
            AppFixBtmButton(onPressed: controller.onSubmit, label: "Simpan"),
          ],
        ),
      ),
    );
  }
}
