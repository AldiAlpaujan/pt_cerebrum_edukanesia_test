import 'package:aldi_test/view/sale/sale.controller.dart';
import 'package:aldi_test/view/sale/widget/app_sale_card.dart';
import 'package:aldi_test/widget/app_404.dart';
import 'package:aldi_test/widget/app_bar_search.dart';
import 'package:aldi_test/widget/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalePage extends GetView<SaleController> {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        title: "Penjualan",
        hintText: "Pencarian...",
        withLeading: false,
        onClose: controller.getData,
        onChanged: controller.onChanged,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.formPage,
        child: const Icon(Icons.add_rounded),
      ),
      body: Obx(
        () => Stack(
          children: [
            if (controller.data().isEmpty && !controller.loading)
              const App404(),
            if (controller.loading)
              const AppLoading()
            else
              RefreshIndicator(
                onRefresh: () async => controller.getData(withLoading: false),
                child: ListView(
                  children: controller
                      .data()
                      .map(
                        (e) => AppSaleCard(
                          sale: e,
                          isLast: e.id == controller.data().last.id,
                          onTap: controller.detailPage,
                        ),
                      )
                      .toList(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
