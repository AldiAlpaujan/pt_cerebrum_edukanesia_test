import 'package:aldi_test/helper/formatter.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/view/sale/sale.controller.form.dart';
import 'package:aldi_test/view/sale/widget/app_sale_product_card.dart';
import 'package:aldi_test/widget/app_404.dart';
import 'package:aldi_test/widget/app_bar_search.dart';
import 'package:aldi_test/widget/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaleFormPage extends GetView<SaleFormController> {
  const SaleFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        title: "Pilih Produk",
        hintText: 'Pencarian...',
        onClose: controller.getData,
        onChanged: controller.onChanged,
      ),
      body: Obx(
        () => Stack(
          children: [
            if (controller.products().isEmpty && !controller.loading)
              const App404(),
            if (controller.loading)
              const AppLoading()
            else
              RefreshIndicator(
                onRefresh: () async => controller.getData(withLoading: false),
                child: ListView(
                  children: [
                    ...controller.products().map(
                          (e) => AppSaleProductCard(
                            product: e,
                            onTap: controller.addToCart,
                            onRemove: controller.removeFromCart,
                            isLast: e.id == controller.products().last.id,
                            inCart: controller
                                    .productOnCarts()
                                    .firstWhereOrNull((i) => i.id == e.id)
                                    ?.qty ??
                                0,
                          ),
                        ),
                    if (controller.productOnCarts().isNotEmpty)
                      const SizedBox(height: 70),
                  ],
                ),
              ),
            if (controller.productOnCarts().isNotEmpty)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppTheme.padding,
                    0,
                    AppTheme.padding,
                    20,
                  ),
                  child: ElevatedButton(
                    onPressed: controller.cartsPage,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "(${controller.productOnCarts().length}) Produk",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          moneyFormatter(controller.totalCart),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.chevron_right,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
