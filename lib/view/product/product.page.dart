import 'package:aldi_test/view/product/product.controller.dart';
import 'package:aldi_test/widget/app_404.dart';
import 'package:aldi_test/widget/app_bar_search.dart';
import 'package:aldi_test/widget/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        title: "Produk",
        hintText: 'Pencarian...',
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
            if (controller.products().isEmpty && !controller.loading)
              const App404(),
            if (controller.loading)
              const AppLoading()
            else
              RefreshIndicator(
                onRefresh: () async => controller.getData(),
                child: ListView(
                  children: const [],
                ),
              )
          ],
        ),
      ),
    );
  }
}
