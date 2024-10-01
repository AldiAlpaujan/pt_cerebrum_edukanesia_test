import 'package:aldi_test/view/sale/sale.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalePage extends GetView<SaleController> {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: controller.formPage,
        child: const Icon(Icons.add_rounded),
      ),
      body: Container(),
    );
  }
}
